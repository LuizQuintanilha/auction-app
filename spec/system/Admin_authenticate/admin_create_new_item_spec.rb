require 'rails_helper'

describe 'Admin access the itens form' do
  context 'and view the form' do
    it 'from the homepage' do
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      visit root_path
      within('nav') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Produtos Cadastrados'
      click_on 'Cadastrar Produto'
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
    it 'and has not access' do

      visit products_path

      expect(current_path).to eq new_admin_session_path
      expect(page).not_to have_link 'Cadastrar Produto'
      expect(page).to have_field 'Email'
      expect(page).to have_field 'Password'
    end
  end
  context 'Admin create a new product' do
    it 'sucessfully' do
      Category.create!(name: 'Informática')
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                                depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)

      visit root_path
      within('nav') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Produtos Cadastrados'
      click_on 'Cadastrar Produto'
      fill_in 'Name', with: 'Monitor AOC 21 polegadas'
      fill_in 'Photo', with: '3x4'
      fill_in 'Weight', with: '3000'
      fill_in 'Width', with: '50'
      fill_in 'Height', with: '35'
      fill_in 'Depth', with: '5'
      fill_in 'Description', with: 'MONITOR AOC B1 SERIES, 21, VA, FHD, 6MS, 75HZ,
                                    FLICKER FREE E LOW BLUE MODE, VGA/HDMI, 24B1XHM'
      #select 'Informática', from: 'Product'
      click_on 'Salvar'

      expect(current_path).to eq products_path
      expect(page).to have_content 'Produto cadastrado com sucesso.'
      expect(page).to have_link 'Monitor AOC 21 polegadas'
    end
    it 'unsucessfully' do
      Category.create!(name: 'Informática')
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      visit root_path
      within('nav') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Produtos Cadastrados'
      click_on 'Cadastrar Produto'
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      click_on 'Salvar'
      
      expect(page).to have_content 'Não foi possível cadastrar produto.'
    end
  end
end
