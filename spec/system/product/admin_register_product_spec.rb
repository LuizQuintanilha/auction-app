require 'rails_helper'

describe 'Admin access the itens form' do
  context 'and view the form' do
    it 'from the homepage' do
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      login_as(admin, :scope => :admin)
      visit root_path
      within('nav.admin') do
        click_on 'Cadastrar Produto'
      end
      # Assert
      expect(current_path).to eq new_product_path
      expect(page).to have_field 'Name'
      expect(page).to have_field 'Photo'
      expect(page).to have_field 'Weight'
      expect(page).to have_field 'Height'
      expect(page).to have_field 'Width'
      expect(page).to have_field 'Depth'
      expect(page).to have_field 'Description'
      expect(page).to have_button 'Salvar'
    end
  end
  context 'Admin create a new product' do
    it 'sucessfully' do
      Category.create!(name: 'Informática')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      informatica = Category.create!(name: 'Informática')
      mouse_produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      produto = Product.new(name:'Microondas', weight: 90, width: 12, height: 4, 
                                depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
      mouse_produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
      mouse_produto.save
      produto.save
      
      login_as(admin, :scope => :admin)
      visit root_path
      within('nav.admin') do
        click_on 'Cadastrar Produto'
      end
      fill_in 'Name', with: 'Mouse Red LG'
      attach_file 'Photo', Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')
      fill_in 'Weight', with: '300'
      fill_in 'Width', with: '4'
      fill_in 'Height', with: '8'
      fill_in 'Depth', with: '3'
      fill_in 'Description', with: 'MOUSE RED LG ULTIMA GERAÇÃO'
      select 'Eletrodoméstico', from: 'Category'
      click_on 'Salvar'

      expect(current_path).to eq products_path
      expect(page).to have_content 'Produto cadastrado com sucesso.'
      expect(page).to have_link 'Mouse Red LG'
    end
    it 'unsucessfully' do
      Category.create!(name: 'Informática')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      login_as(admin, :scope => :admin)
      visit root_path
      within('nav.admin') do
        click_on 'Cadastrar Produto'
      end
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      click_on 'Salvar'
      
      expect(page).to have_content 'Não foi possível cadastrar produto.'
    end
  end
end
