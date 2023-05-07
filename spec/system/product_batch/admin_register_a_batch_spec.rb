require 'rails_helper'

describe 'From the homepage' do 
  it 'sucessfully' do
    # Arrange
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    # Act
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Aprovar lote'
    click_on 'Cadastrar Lote'
    # Assert
    expect(page).to have_field('Code')
    expect(page).to have_field('Start date')
    expect(page).to have_field('Deadline')
    expect(page).to have_field('Minimum value')
    expect(page).to have_button 'Salvar'
  end

  context 'admin register a new batch' do
    it 'sucessfully' do
      # Arrange
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      product_category = Category.create!(name: 'Informática')
      eletrodomestico = Category.create!(name:'Eletrodoméstico')
      produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
      produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                                depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)

      # Act
      visit root_path
      within('nav') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Aprovar lote'
      click_on 'Cadastrar Lote'
      check 'Microondas'
      fill_in 'Code', with: 'ABC123456'
      fill_in 'Start date', with: Date.today
      fill_in 'Deadline', with: 3.days.from_now
      fill_in 'Minimum value', with: 1.99
      click_on 'Salvar'
      # Assert
      expect(page).to have_link('ABC123456')
      expect(page).to have_content 'Lotes Cadastrados Aguardando Aprovação'
      expect(page).to have_content 'Status:'
      expect(page).to have_content 'wait_approve'
      expect(page).to have_button 'Aprovar'
    end
    it 'unsucessfully' do
      # Arrange
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      # Act
      visit root_path
      within('nav') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Aprovar lote'
      click_on 'Cadastrar Lote'
      fill_in 'Code', with: ''
      fill_in 'Start date', with: ''
      fill_in 'Deadline', with: 2.days.from_now
      fill_in 'Minimum value', with: 1.99
      click_on 'Salvar'
      # Assert
      expect(page).to have_content('Nao foi possível cadastrar o lote.')
    end
  end
end