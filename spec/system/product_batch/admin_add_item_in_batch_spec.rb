require 'rails_helper'

describe 'Admin add item for batch' do
  it 'sucessfully' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    product_category = Category.create!(name: 'Informática')
    eletrodomestico = Category.create!(name:'Eletrodoméstico')
    produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
    produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                              depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar Lote'
    check 'Mouse'
    check 'Microondas'
    fill_in 'Code', with: 'ABC112233'
    fill_in 'Start date', with: Date.today
    fill_in 'Deadline', with: 3.days.from_now
    fill_in 'Minimum value', with: 1000
    click_on 'Salvar'

    expect(current_path).to eq aprove_path
    expect(page).to have_content 'Código do lote: ABC112233'
    expect(page).to have_content 'Status: wait_approve'
    expect(page).to have_button 'Aprovar'
  end
end