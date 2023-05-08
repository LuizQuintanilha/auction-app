require 'rails_helper'

describe 'User visit homepage' do
  context 'without authenticate' do
    it 'and see informations' do

      visit root_path
      click_on 'Leilão de Estoque'

      expect(current_path).to eq root_path
      within('header') do
        expect(page).to have_link 'Leilão de Estoque'
        expect(page).to have_link 'Produtos Cadastrados'
        expect(page).to have_link 'Lotes Cadastrados'
      end
    end

    it 'view all products registered' do
      informatica = Category.create!(name:'Informática')
      mouse = 'MOUSE OFFICE TGT P90'
      mouse_product = Product.new(name:'Mouse', weight: 90, width: 12, height: 4, 
                                  depth: 6, description: mouse, category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
      mouse_product.save

      visit root_path
      click_on 'Produtos Cadastrados'

      expect(current_path).to eq products_path
      expect(page).to have_content 'Produtos Cadastrados'
      expect(page).to have_content 'Produto:'
      expect(page).to have_link 'Mouse'
    end

    it 'and has no product registered' do 

      visit root_path
      click_on 'Produtos Cadastrados'

      expect(current_path).to eq products_path
      expect(page).to have_content 'Produtos Cadastrados'
      expect(page).to have_content 'Sem produtos cadastrados.'
    end

    it 'and view all batches registered' do 
      informatica = Category.create!(name:'Informática')
      mouse = 'MOUSE OFFICE TGT P90'
      mouse_product = Product.new(name:'Mouse', weight: 90, width: 12, height: 4, 
                                  depth: 6, description: mouse, category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
      mouse_product.save
      
      visit root_path
      click_on 'Lotes Cadastrados'

      expect(page).to have_content 'Lotes Cadastrados'

    end
    it 'and there no batches registered' do
      
      visit root_path
      click_on 'Lotes Cadastrados'

      expect(page).to have_content 'Lotes Cadastrados'
      expect(page).to have_content 'Não existem lotes cadastrados'

    end
  end
end
