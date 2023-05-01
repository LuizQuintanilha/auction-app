require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'create product' do
      it 'valid' do
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return 'luizab1234'
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        # act
        result = produto.valid?
        expect(result).to eq true
        produto.save
        expect(produto.code).to eq 'luizab1234'
      end
      it 'invalid' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: '', photo: '', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Name can't be blank"]
      end
    end
  end
end
