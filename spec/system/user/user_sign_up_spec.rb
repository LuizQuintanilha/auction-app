require 'rails_helper'

describe 'User create a count' do
  it 'sucessfully' do
    visit root_path
    within('nav.user') do
      click_on 'Usuário'
    end
    click_on 'Sign up'
    fill_in 'Cpf', with: '12662381744'
    fill_in 'Email', with: 'luiz@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  context 'unsucessfully' do
    it 'when cpf is invalid' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '12662381700'
      fill_in 'Email', with: 'luiz@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page).to have_content 'CPF inválido'
    end
    it 'when cpf is is already in use' do
      User.create!(email: 'luana@email.com', password: '123456', cpf: '12662381744')
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luiz@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page).to have_content 'Cpf has already been taken'
    end
    it 'when email is already been taken' do
      User.create!(email: 'luana@email.com', password: '123456', cpf: '12662381744')
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '13008408784'
      fill_in 'Email', with: 'luana@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page).to have_content 'Email has already been taken'
    end
    it 'when email is the domain: leilaodogalpão.com.br' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page).to have_content "Can't be the exclusive domain 'leilaodogalpão.com'"
    end
    it 'when email has not domain' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luana'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page).to have_content 'Email is invalid'
    end
    it 'when password is less than six' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luana@email.com'
      fill_in 'Password', with: '12345'
      fill_in 'Password confirmation', with: '12345'
      click_on 'Sign up'
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end
    it 'when password is differente from password confirmation' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Sign up'
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luana@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '654321'
      click_on 'Sign up'
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end
