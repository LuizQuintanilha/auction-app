require 'rails_helper'

describe 'Admin authenticate itself' do
  it 'successfully' do
    # arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    # act
    login_as(admin, scope: :admin)
    visit root_path
    # assert
    expect(page).not_to have_link 'Admin'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'luiz@leilaodogalpao.com.br'
  end
  it 'and logout' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Sair'

    # expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_link 'Admin'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'luiz@leilaodogalpao.com.br'
  end
end
