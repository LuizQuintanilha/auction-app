require 'rails_helper'

describe 'Admin sign up' do
  it 'successfully' do

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    click_on 'Criar conta'
    within('form') do
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Criar'
    end

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'luana@leilaodogalpao.com.br'
    expect(page).to have_button 'Sair'
    admin = Admin.last
    expect(admin.cpf).to eq '12662381744'
  end
  it 'unsuccessfully' do

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    click_on 'Criar conta'
    within('form') do
      fill_in 'Cpf', with: '12662381700'
      fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Criar'
    end
    
    expect(page).to have_content 'error prohibited this admin from being saved:'
  end
end
