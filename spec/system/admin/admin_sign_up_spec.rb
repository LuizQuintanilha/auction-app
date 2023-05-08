require 'rails_helper'

describe 'Admin sign up' do
  it 'successfully' do

    visit root_path
    within('nav.admin') do
      click_on 'Admin'
    end
    click_on 'Criar Conta'
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
  context 'unsuccessfully' do
    it 'when cpf is invalid' do

      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      click_on 'Criar Conta'
      within('form') do
        fill_in 'Cpf', with: '12662381700'
        fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_on 'Criar'
      end

      expect(page).to have_content 'error prohibited this admin from being saved:'
      expect(page).to have_content 'CPF inválido'
    end
    it 'when cpf is already in used' do
      Admin.create!(cpf: 12662381744, email: 'luiz@leilaodogalpao.com.br', password: '123456', password_confirmation: '123456')
      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      click_on 'Criar Conta'
      within('form') do
        fill_in 'Cpf', with: '12662381744'
        fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_on 'Criar'
      end

      expect(page).to have_content 'error prohibited this admin from being saved:'
      expect(page).to have_content 'Cpf has already been taken'
    end
    it 'when email is invalid' do

      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      click_on 'Criar Conta'
      within('form') do
        fill_in 'Cpf', with: '12662381744'
        fill_in 'Email', with: 'luana@email'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_on 'Criar'
      end

      expect(page).to have_content 'error prohibited this admin from being saved:'
      expect(page).to have_content 'Email Precisa pertencer ao domínio @leilaodogalpao.com.br'
    end
    it 'when password is too short' do

      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      click_on 'Criar Conta'
      within('form') do
        fill_in 'Cpf', with: '12662381744'
        fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
        fill_in 'Password', with: '12345'
        fill_in 'Password confirmation', with: '12345'
        click_on 'Criar'
      end

      expect(page).to have_content 'error prohibited this admin from being saved:'
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end

  end
end
