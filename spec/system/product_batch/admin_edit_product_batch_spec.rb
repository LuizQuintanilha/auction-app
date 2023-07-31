require 'rails_helper'

describe 'Admin edit batch' do
  it 'and add a new item' do
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
    ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233',
                                start_date: Date.today, deadline: 5.days.from_now,
                                minimum_value: 600, minimal_difference: 80,
                                start_time: Time.current, end_time: 1.hour.from_now)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Aprovar lote'
    click_on 'Editar'
    uncheck 'Mouse'
    check 'Microondas'
    fill_in 'Code', with: 'ACD111222'
    fill_in 'Start date', with: Time.zone.today
    fill_in 'Deadline', with: 5.days.from_now
    fill_in 'Minimum value', with: 1500
    click_on 'Salvar'
    expect(page).to have_content 'Lote editado com sucesso.'
    expect(mouse_product.status).to eq 'available'
    expect(microondas_product.reload.status).not_to eq 'available'
  end
end
