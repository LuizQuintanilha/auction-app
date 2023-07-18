class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids
  has_many :product_batches, through: :bid
  has_many :favorites, dependent: :destroy

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, cpf: { message: 'CPF inválido' }
  validates :cpf, format: { with: /[0-9]{11}/, message: 'Precisa ter 11 dígitos' }
  validate :email_format
  validate :cpf_different_from_admin

  # validate :check_blocked_cpf, on: :create

  def email_format
    return unless email.present? && email.match(/@leilaodogalpao.com.br\z/)

    errors.add(:email, 'Domínio exclusivo')
  end

  def cpf_different_from_admin
    return unless Admin.exists?(cpf: cpf)

    errors.add(:cpf, 'CPF já cadastrado')
  end

  def active_for_authentication?
    super && !blocked?
  end

  def inactive_message
    blocked? ? 'Sua conta está suspensa.' : super
  end

  def favorite_products
    favorites.map(&:product_batch)
  end
end
