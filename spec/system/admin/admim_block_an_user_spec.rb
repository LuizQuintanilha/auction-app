require 'rails_helper'

describe 'From the homepage' do
  it 'admin view all users' do
    # arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
    # act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Bloqueio de Usuário'
    # assert
    expect(current_path).to eq blocked_users_path
    expect(page).to have_content "Email: #{user.email}"
    expect(page).to have_content "CPF: #{user.cpf}"
    expect(page).to have_button 'Bloquear'
    expect(page).not_to have_button 'Desbloquear'
  end
  it 'admin block an user' do
    # arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
    # act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Bloqueio de Usuário'
    click_on 'Bloquear'
    # assert
    expect(page).to have_content "Email: #{user.email}"
    expect(page).to have_content "CPF: #{user.cpf}"
    expect(page).to have_button 'Desbloquear'
    expect(page).not_to have_button 'Bloquear'
    expect(page).to have_content 'Usuário bloqueado com sucesso.'
  end
  it 'admin unblock an user' do
    # arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
    user.update(blocked: true)
    user.reload
  
    # act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Bloqueio de Usuário'
    click_on 'Desbloquear'
  
    expect(page).to have_content "Email: #{user.email}"
    expect(page).to have_content "CPF: #{user.cpf}"
    expect(page).to have_button 'Bloquear'
    expect(page).not_to have_button 'Desbloquear'
    expect(page).to have_content 'Usuário desbloqueado com sucesso.'
  end
  
end