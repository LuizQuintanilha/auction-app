require 'rails_helper'

describe 'Admin approve a batch' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
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
    ProductBatch.create!(admin_id: 1, created_by: luana, code: 'ACB112233', start_date: Date.today,
                                deadline: 5.days.from_now, minimum_value: 600,
                                minimal_difference: 50)

    login_as(admin, scope: :admin)
    visit root_path
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
