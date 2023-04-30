require 'rails_helper'

describe 'Admin authenticate itself' do 
  it 'sucessely' do
    #arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456')
    #act
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    #assert
    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Login'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'luiz@leilaodogalpao.com.br'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'and logout' do 
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    click_on 'Sair'

    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_link 'Login'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'luiz@leilaodogalpao.com.br'
  end
end