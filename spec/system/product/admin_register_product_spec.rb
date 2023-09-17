require 'rails_helper'

describe 'Admin access the itens form' do
  context 'and view the form' do
    it 'from the homepage' do
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      login_as(admin, scope: :admin)
      visit root_path
      within('nav.admin') do
        click_on 'Cadastrar Produto'
      end
      # Assert
      expect(current_path).to eq new_product_path
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'Foto'
      expect(page).to have_field 'Peso'
      expect(page).to have_field 'Altura'
      expect(page).to have_field 'Comprimento'
      expect(page).to have_field 'Profundidade'
      expect(page).to have_field 'Descrição'
      expect(page).to have_button 'Salvar'
    end
  end
  context 'Admin create a new product' do
    it 'sucessfully' do
      Category.create!(name: 'Informática')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      eletrodomestico = Category.create!(name: 'Eletrodoméstico')
      informatica = Category.create!(name: 'Informática')
      mouse_produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: 'MOUSE OFFICE TGT P90', category: informatica)
      produto = Product.new(name: 'Microondas', weight: 90, width: 12, height: 4,
                            depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
      mouse_produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                                 filename: 'mouse_red.jpg')
      mouse_produto.save
      produto.save

      login_as(admin, scope: :admin)
      visit root_path
      within('nav.admin') do
        click_on 'Cadastrar Produto'
      end
      fill_in 'Nome', with: 'Mouse Red LG'
      attach_file 'Foto', Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')
      fill_in 'Peso', with: '300'
      fill_in 'Comprimento', with: '4'
      fill_in 'Altura', with: '8'
      fill_in 'Profundidade', with: '3'
      fill_in 'Descrição', with: 'MOUSE RED LG ULTIMA GERAÇÃO'
      select 'Eletrodoméstico', from: 'Categoria do Produto'
      click_on 'Salvar'

      expect(current_path).to eq products_path
      expect(page).to have_content 'Produto cadastrado com sucesso.'
      expect(page).to have_link 'Mouse Red LG'
    end
    it 'unsucessfully' do
      Category.create!(name: 'Informática')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      login_as(admin, scope: :admin)
      visit root_path
      within('nav.admin') do
        click_on 'Cadastrar Produto'
      end
      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      click_on 'Salvar'

      expect(page).to have_content 'Não foi possível cadastrar produto.'
    end
  end
end
