require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    context 'create category' do
      it 'valid' do
        product_category = Category.new(name: 'Informática')
        # Act
        result = product_category.valid?
        expect(result).to eq true
      end
      it 'invalid' do
        product_category = Category.new(name: '')
        # Act
        result = product_category.valid?
        expect(result).to eq false
        expect(product_category.errors.full_messages).to eq ["Name can't be blank"]
      end
    end
  end
end
