require 'rails_helper'

RSpec.describe ProductBatch, type: :model do
  describe '#valid' do  
    it 'true when all fields are filled in' do
      # Arrange
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                                depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
      lote = ProductBatch.new(code: 'ACB123456', start_date: Date.today, deadline: 5.days.from_now,
                              minimum_value: 1.99, minimal_difference: 10.59)
      lote = ProductBatch.new(code: 'ACB123456', start_date: Date.today, deadline: 5.days.from_now, 
                              minimum_value: 1.99, minimal_difference: 10.59)
      # Act
      result = lote.valid?
      # Assert
      expect(result).to be true
    end
    it 'false when code is empty' do
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      lote = ProductBatch.new(code: '', start_date: Date.today, deadline: 5.days.from_now, 
                              minimum_value: 1.99, minimal_difference: 10.59)
      # Act
      result = lote.valid?
      # Assert
      expect(result).to be false
    end
    it 'false when star date is empty' do
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      lote = ProductBatch.new(code: 'ACB123456', start_date:'', deadline: 5.days.from_now, 
                              minimum_value: 1.99, minimal_difference: 10.59)
      # Act
      result = lote.valid?
      # Assert
      expect(result).to be false
    end
    it 'false when deadline is empty' do
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      lote = ProductBatch.new(code: 'ACB123456', start_date: Date.today, deadline: '', 
                              minimum_value: 1.99, minimal_difference: 10.59)
      # Act
      result = lote.valid?
      # Assert
      expect(result).to be false
    end
    it 'false when minimum value is empty' do
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      lote = ProductBatch.new(code: 'ACB123456', start_date: Date.today, deadline: 5.days.from_now,
                              minimum_value: '', minimal_difference: 10.59)
      # Act
      result = lote.valid?
      # Assert
      expect(result).to be false
    end
    it 'false when code is invalid format' do
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      lote = ProductBatch.new(code: '125AB23', start_date: Date.today, deadline: 5.days.from_now, 
                              minimum_value: 15.99, minimal_difference: 8.99)
      # Act
      result = lote.valid?
      # Assert
      expect(result).to be false
    end
    context 'if validator rules are correct filled in'  do
      it 'is equal to or greater than the current date' do
        eletrodomestico = Category.create!(name:'Eletrodoméstico')
        produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                                  depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
        lote = ProductBatch.create!(code: 'ABC123456', start_date: Date.today, deadline: 2.days.ago, 
                                    minimum_value: 1.99, minimal_difference: 10.59)

        lote.valid?
        result = lote.errors.include?(:start_date)

        expect(result).to eq false
      end
      it 'value is the difference between two batches' do
        batches = [10.00,10.20,10.40]
        eletrodomestico = Category.create!(name:'Eletrodoméstico')
        current_value = ( batches[-1] - batches.last)
        produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                                  depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
        lote = ProductBatch.create!(code: 'ABC123456', start_date: Date.today, deadline: 2.days.ago, 
                                    minimum_value: 8.99, minimal_difference: current_value)
        result = lote.valid?
          
      end
    end
  end
end
