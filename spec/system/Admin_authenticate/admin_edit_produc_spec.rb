require 'rails_helper'

describe 'Admin edit a product' do
  it 'sucessfully' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    second_product_category = Category.create!(name: 'Eletrônico')
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
    click_on 'Mouse'
    click_on 'Editar'
    fill_in 'Name', with: 'Mouse LG'  
    fill_in 'Photo', with: '8x16'  
    select 'Eletrônico', from: 'Category'
    click_on 'Salvar'

    expect(page).to have_content 'Mouse LG'
    expect(page).to have_content 'Produto atualizado com sucesso.'
  end
  it 'unsucessfully' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    second_product_category = Category.create!(name: 'Eletrônico')
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
    click_on 'Mouse'
    click_on 'Editar'
    fill_in 'Name', with: ''  
    fill_in 'Photo', with: '8x16'  
    select 'Eletrônico', from: 'Category'
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar dados do produto.'
  end
end