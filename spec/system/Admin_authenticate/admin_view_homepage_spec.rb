require 'rails_helper'

describe 'Admin view all products registered' do
  it 'from the homepage' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end
    
    expect(current_path).to eq root_path
    expect(page).to have_content 'Leilão de Estoque'
    expect(page).to have_content 'Produto:'
    expect(page).to have_link 'Mouse'
  end
  it 'and dont exist products registered' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'Sem produtos cadastrados.'
  end
end