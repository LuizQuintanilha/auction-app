require 'rails_helper'

describe 'User create a count' do
  it 'sucessfully' do
    visit root_path
    within('nav.user') do
      click_on 'Usuário'
    end
    click_on 'Criar conta'
    fill_in 'CPF', with: '12662381744'
    fill_in 'Email', with: 'luiz@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '123456'
    click_on 'Criar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end

  context 'unsucessfully' do
    it 'when cpf is invalid' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '12662381700'
      fill_in 'Email', with: 'luiz@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Criar'

      expect(page).to have_content 'CPF inválido'
    end
    it 'when cpf is is already in use' do
      User.create!(email: 'luana@email.com', password: '123456', cpf: '12662381744')
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '12662381744'
      fill_in 'Email', with: 'luiz@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Criar'

      expect(page).to have_content 'CPF já está em uso'
    end
    it 'when email is already been taken' do
      User.create!(email: 'luana@email.com', password: '123456', cpf: '12662381744')
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '13008408784'
      fill_in 'Email', with: 'luana@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Criar'
      expect(page).to have_content 'Email já está em uso'
    end
    it 'when email is the domain: leilaodogalpão.com.br' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '12662381744'
      fill_in 'Email', with: 'luana@leilaodogalpao.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Criar'
      expect(page).to have_content 'Email Domínio exclusivo'
    end
    it 'when email has not domain' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '12662381744'
      fill_in 'Email', with: 'luana'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Criar'
      expect(page).to have_content 'Email não é válido'
    end
    it 'when password is less than six' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '12662381744'
      fill_in 'Email', with: 'luana@email.com'
      fill_in 'Senha', with: '12345'
      fill_in 'Confirmação de senha', with: '12345'
      click_on 'Criar'
      expect(page).to have_content 'Senha é muito curto (mínimo: 6 caracteres)'
    end
    it 'when password is differente from password confirmation' do
      visit root_path
      within('nav.user') do
        click_on 'Usuário'
      end
      click_on 'Criar conta'
      fill_in 'CPF', with: '12662381744'
      fill_in 'Email', with: 'luana@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '654321'
      click_on 'Criar'
      expect(page).to have_content "Confirmação de senha não é igual a Senha"
    end
  end
end
