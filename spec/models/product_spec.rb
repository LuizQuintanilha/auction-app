require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'true when all fields are filled in' do
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
      it 'false when name is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: '', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Name can't be blank"]
      end
      it 'false when photo is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Photo can't be blank"]
      end
      it 'false when weight is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '3x4', weight: '' , width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Weight can't be blank"]
      end
      it 'false when width is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '3x4', weight: 90, width: '', height: 4,
                              depth: 6, description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Width can't be blank"]
      end
      it 'false when height is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: '',
                              depth: 6, description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Height can't be blank"]
      end
      it 'false when depth is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: '', description: mouse, category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Depth can't be blank"]
      end
      it 'false when description is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6 , description: '', category: product_category)
        result = produto.valid?
        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Description can't be blank"]
      end
    end
  end
end
