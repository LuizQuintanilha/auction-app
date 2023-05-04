require 'rails_helper'

describe 'From the homepage' do 
  it 'admin view the form for register' do
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
    click_on 'Lotes Cadastrados'
    click_on 'Cadastrar Lote'
    # Assert
    expect(page).to have_field('Code')
    expect(page).to have_field('Start date')
    expect(page).to have_field('Deadline')
    expect(page).to have_field('Minimum value')
    expect(page).to have_field('Minimal difference')
    expect(page).to have_content('Status')
    expect(page).to have_button 'Salvar'
  end
  context 'admin register a new batch' do
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
      click_on 'Lotes Cadastrados'
      click_on 'Cadastrar Lote'
      fill_in 'Code', with: 'ABC12345'
      fill_in 'Start date', with: '08/05/2023'
      fill_in 'Deadline', with: '09/05/2023'
      fill_in 'Minimum value', with: 1.99
      fill_in 'Minimal difference', with: 3.99
      click_on 'Salvar'
      # Assert
      expect(page).to have_content('ABC12345')
      expect(page).to have_content('2023-05-08')
      expect(page).to have_content ('2023-05-09')
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
      click_on 'Lotes Cadastrados'
      click_on 'Cadastrar Lote'
      fill_in 'Code', with: ''
      fill_in 'Start date', with: ''
      fill_in 'Deadline', with: '09/05/2023'
      fill_in 'Minimum value', with: 1.99
      fill_in 'Minimal difference', with: 3.99
      click_on 'Salvar'
      # Assert
      expect(page).to have_content('Nao foi possível cadastrar o lote.')
    end
  end
end