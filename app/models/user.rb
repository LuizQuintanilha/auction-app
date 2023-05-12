class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :bids  
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, cpf: { message: 'CPF inválido' }
  validates :cpf, format: { with: /[0-9]{11}/, message: 'Precisa ter 11 dígitos' }
  validate :email_format
  validate :cpf_different_from_admin

  def email_format
    if self.email.present? && self.email.match(/@leilaodogalpao.com.br\z/)
      errors.add(:email, "Can't be the exclusive domain 'leilaodogalpão.com'")
    end
  end

  def cpf_different_from_admin
    if Admin.exists?(cpf: cpf)
      errors.add(:cpf, 'has already been taken')
    end
  end
end
