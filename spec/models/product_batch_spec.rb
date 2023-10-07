require 'rails_helper'

RSpec.describe ProductBatch, type: :model do
  describe '#valid' do
    it 'true when all fields are filled in' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      lote = ProductBatch.new(created_by: luana, code: 'ACB123456', start_date: Date.today, deadline: 5.days.from_now,
                              minimum_value: 10.99, minimal_difference: 2.00)

      result = lote.valid?

      expect(result).to be true
    end

    it 'false when code is empty' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      lote = ProductBatch.new(created_by: luana, code: '', start_date: Date.today, deadline: 5.days.from_now,
                              minimum_value: 1.99, minimal_difference: 10.59)

      result = lote.valid?

      expect(result).to be false
    end
    it 'false when start date is less the date today' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      lote = ProductBatch.new(created_by: luana, code: 'ACB123456', start_date: 2.days.ago, deadline: 5.days.from_now,
                              minimum_value: 1.99, minimal_difference: 10.599)

      result = lote.valid?
  
      expect(result).to be false
    end
    it 'false when deadline is empty' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      lote = ProductBatch.new(created_by: luana, code: 'ACB123456', start_date: Date.today, deadline: '',
                              minimum_value: 1.99, minimal_difference: 10.599)

      result = lote.valid?

      expect(result).to be false
    end
    it 'false when minimum value is empty' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      lote = ProductBatch.new(created_by: luana, code: 'ACB123456', start_date: Time.current, deadline: 5.days.from_now,
                              minimum_value: '', minimal_difference: 10.59)

      result = lote.valid?

      expect(result).to be false
    end
    it 'false when code is invalid format' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      lote = ProductBatch.new(created_by: luana, code: '125AB23', start_date: Date.today, deadline: 5.days.from_now,
                              minimum_value: 15.99, minimal_difference: 8.99)

      result = lote.valid?

      expect(result).to be false
    end
  end
end
