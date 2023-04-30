require 'rails_helper'

describe 'Admin sign up' do
  it 'successfully' do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'
    within('form') do
      fill_in 'Cpf', with: '12662381744'
      fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
    end
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'luana@leilaodogalpao.com.br'
    expect(page).to have_button 'Sair'
    admin = Admin.last
    expect(admin.cpf).to eq '12662381744'
  end
end
