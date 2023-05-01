class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :email, format: { with: /[\w+.]+@leilaodogalpao.com.br\z/, message: 'Precisa pertencer ao domínio @leilaodogalpao.com.br' }
  validates :cpf, cpf: { message: 'CPF inválido' }
  validates :cpf, format: { with: /[0-9]{11}/, message: 'Precisa ter 11 dígitos' }
end
