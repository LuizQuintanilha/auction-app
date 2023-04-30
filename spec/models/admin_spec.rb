require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid?' do
    context 'format email domain' do
      it 'valid' do
        admin = Admin.new(email: 'ana_22@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
        # act
        result = admin.valid?
        expect(result).to eq true

      end
      it 'invalid' do
        admin = Admin.new(email: 'ana_22@email.com.br', password: '123456', cpf: '12662381744')
        # act
        result = admin.valid?
        expect(result).to eq false
        admin.save
        expect(admin.errors.full_messages).to eq ['Email Precisa pertencer ao domínio @leilaodogalpao.com.br']
      end
    end

    context 'cpf is mandatory' do
      it 'presence' do
        admin = Admin.new(email: 'ana_22@leilaodogalpao.com.br', password: '123456', cpf: '')
        result = admin.valid?
        expect(result).to eq false
        expect(admin.errors.full_messages).to eq ["Cpf can't be blank", "Cpf Precisa ter 11 dígitos"]
      end
    end

    context 'cpf is uniq' do
      it 'uniquiness' do
        Admin.create!(email: 'ana_22@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
        admin_dois = Admin.new(email: 'maria@leilaodogalpao.com.br', password: '112233', cpf: '12662381744')

        result = admin_dois.valid?
        expect(result).to eq false
        expect(admin_dois.errors.full_messages).to eq ['Cpf has already been taken']
      end
    end
  end
end
