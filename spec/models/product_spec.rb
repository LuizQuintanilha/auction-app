require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'true when all fields are filled in' do
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return 'luizBb1234'
        aleatorio = SecureRandom.alphanumeric(10)
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')
        # act
        result = produto.valid?
        produto.save

        expect(result).to eq true
        expect(produto.code).to eq 'luizBb1234'
      end
      it 'false when name is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: '', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')

        result = produto.valid?

        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ["Nome não pode ficar em branco"]
      end
      it 'false when photo is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)

        result = produto.valid?

        produto.save
        expect(result).to eq false
        expect(produto.errors.full_messages).to eq ['Foto não pode ficar em branco']
      end
      it 'false when weight is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: '', width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')

        result = produto.valid?

        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ['Peso não pode ficar em branco']
      end
      it 'false when width is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: 90, width: '', height: 4,
                              depth: 6, description: mouse, category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')

        result = produto.valid?

        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ['Comprimento não pode ficar em branco']
      end
      it 'false when height is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: '',
                              depth: 6, description: mouse, category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')

        result = produto.valid?

        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ['Altura não pode ficar em branco']
      end
      it 'false when depth is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                              depth: '', description: mouse, category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')

        result = produto.valid?

        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ['Profundidade não pode ficar em branco']
      end
      it 'false when description is empty' do
        product_category = Category.create!(name: 'Informática')
        mouse = 'MOUSE OFFICE TGT P90'
        produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                              depth: 6, description: '', category: product_category)
        produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                             filename: 'mouse_red.jpg')

        result = produto.valid?

        expect(result).to eq false
        produto.save
        expect(produto.errors.full_messages).to eq ['Descrição não pode ficar em branco']
      end
    end
  end
end
