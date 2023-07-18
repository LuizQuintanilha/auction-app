require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'when email is invalid' do
      it 'domain: leilaodogalpao.com.br' do
        user = User.new(email: 'ana_22@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
        # Act
        result = user.valid?

        expect(result).to eq false
      end

      it 'has any domain' do
        user = User.new(email: 'ana_22', password: '123456', cpf: '12662381744')
        # Act
        result = user.valid?

        expect(result).to eq false
      end
    end

    context 'password  is invalid' do
      it 'when has less than 6 caracters' do
        user = User.new(email: 'luana@email.com', password: '12345', password_confirmation: '12345', cpf: '13008409784')
        # Act
        result = user.valid?

        expect(result).to eq false
      end

      it 'when password different from password confirmation' do
        user = User.new(email: 'luana@email.com', password: '123456', password_confirmation: '654321',
                        cpf: '13008409784')
        # Act
        result = user.valid?

        expect(result).to eq false
        expect(user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
      end
    end

    context 'cpf is mandatory and uniq' do
      it 'presence' do
        user = User.new(email: 'ana_22@email.com', password: '123456', cpf: '')

        result = user.valid?

        expect(result).to eq false
        expect(user.errors.full_messages).to eq ["Cpf can't be blank", 'Cpf Precisa ter 11 dígitos']
      end

      it 'uniquiness' do
        User.create!(email: 'ana_22@email.comr', password: '123456', cpf: '12662381744')
        user = User.new(email: 'maria@email.com', password: '112233', cpf: '12662381744')

        result = user.valid?

        expect(result).to eq false
        expect(user.errors.full_messages).to eq ['Cpf has already been taken']
      end
    end
  end
end
