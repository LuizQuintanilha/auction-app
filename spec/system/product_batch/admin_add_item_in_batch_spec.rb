require 'rails_helper'

describe 'Admin add item for batch' do
  it 'sucessfully' do
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    product_category = Category.create!(name: 'Informática')
    eletrodomestico = Category.create!(name:'Eletrodoméstico')
    mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                              depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
    mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
    microondas_product = Product.new(name:'Microondas',  weight: 90, width: 12, height: 4, 
                              depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
    microondas_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'microondas.png')), filename: 'microondas.png')
    microondas_product.save
    mouse_product.save

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