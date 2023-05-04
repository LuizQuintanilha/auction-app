require 'rails_helper'

describe 'Admin view all product batch registred' do
  it 'from the homepage' do
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
    # Assert
    expect(current_path).to eq product_batches_path
    expect(page).to have_content 'Lotes Cadastrados'
    expect(page).to have_link 'Cadastrar Lote'
  end
  it "don't have batch's register" do
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
    # Assert
    expect(page).to have_content 'Não existem lotes cadastrados'
  end
end