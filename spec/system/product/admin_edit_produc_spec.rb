require 'rails_helper'

describe 'Admin edit a product' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    Category.create!(name: 'Eletrônico')
    product_category = Category.create!(name: 'Informática')
    produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                          depth: 6, description: mouse, category: product_category)
    produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                         filename: 'mouse_red.jpg')
    produto.save

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Produtos Cadastrados'
    click_on 'Mouse'
    click_on 'Editar'
    fill_in 'Nome', with: 'Mouse LG'
    attach_file 'Foto', Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')
    select 'Eletrônico', from: 'Categoria do Produto'
    click_on 'Salvar'

    expect(page).to have_content 'Mouse LG'
    expect(page).to have_content 'Produto atualizado com sucesso.'
  end
  it 'unsucessfully' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    second_product_category = Category.create!(name: 'Eletrônico')
    produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                          depth: 6, description: mouse, category: product_category)
    produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')),
                         filename: 'mouse_red.jpg')
    produto.save

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Produtos Cadastrados'
    click_on 'Mouse'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    select 'Eletrônico', from: 'Categoria do Produto'
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar dados do produto.'
  end
end
