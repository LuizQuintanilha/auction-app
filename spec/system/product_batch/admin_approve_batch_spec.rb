require 'rails_helper'

describe 'Admin approve a batch' do
  it 'sucessfully' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    product_category = Category.create!(name: 'Informática')
    eletrodomestico = Category.create!(name:'Eletrodoméstico')
    produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
    produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                              depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
    lote = ProductBatch.create!(code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now, minimum_value: 600)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Aprovar lote'
    click_on 'Aprovar'

    expect(page).to have_content 'Iten(s) para Leilão'
    expect(page).to have_content 'Aprovado'
    expect(page).to have_content 'Início'
    expect(page).to have_content 'Término'
    expect(page).to have_content 'Lance Mínimo:'
    expect(page).to have_content 'Término'

  end
end