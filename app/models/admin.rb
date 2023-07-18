class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :product_batches
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, cpf: { message: 'CPF inválido' }
  validates :cpf, format: { with: /[0-9]{11}/, message: 'Precisa ter 11 dígitos' }
  validates :email,
            format: { with: /[\w+.]+@leilaodogalpao.com.br\z/,
                      message: 'Precisa pertencer ao domínio @leilaodogalpao.com.br' }
  validate :cpf_different_from_user

  def cpf_different_from_user
    return unless User.exists?(cpf: cpf)

    errors.add(:cpf, 'CPF já cadastrado')
  end
end
