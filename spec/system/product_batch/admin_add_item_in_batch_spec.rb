require 'rails_helper'

describe 'Admin add item for batch' do
  it 'sucessfully' do
    Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    product_category = Category.create!(name: 'Informática')
    eletrodomestico = Category.create!(name: 'Eletrodoméstico')
    mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                depth: 6, description: 'MOUSE OFFICE TGT P90', category: product_category)
    mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                               filename: 'mouse_red.jpg')
    microondas_product = Product.new(name: 'Microondas', weight: 90, width: 12, height: 4,
                                     depth: 6, description: 'Microondas 20 Litros', category: eletrodomestico)
    microondas_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'microondas.png')),
                                    filename: 'microondas.png')
    microondas_product.save
    mouse_product.save

    login_as(admin, scope: :admin)
    visit root_path

    click_on 'Cadastrar Lote'
    check 'Mouse'
    check 'Microondas'
    fill_in 'Código', with: 'ABC112233'
    fill_in 'Início', with: Time.now
    fill_in 'Término', with: 3.days.from_now
    fill_in 'Valor inicial', with: 1000
    fill_in 'Diferença mínima', with: 100
    click_on 'Salvar'
   
    expect(current_path).to eq aprove_path
    expect(page).to have_content 'Código do lote: ABC112233'
    expect(page).to have_content 'Estatus: wait_approve'
    expect(page).to have_button 'Aprovar'
  end
end
