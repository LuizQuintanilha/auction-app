require 'rails_helper'

describe 'Admin view all products' do
  it 'from the homepage' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    produto = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)
    produto.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'microondas.png')), filename: 'microondas.png')
    produto.save                          

    login_as(admin, :scope => :admin)
    visit root_path
    within('header') do
      click_on 'Produtos Cadastrados'
    end
      
    expect(current_path).to eq products_path
    expect(page).to have_content 'Leilão de Estoque'
    expect(page).to have_content 'Produtos Cadastrados'
    expect(page).to have_content 'Produto:'
    expect(page).to have_link 'Mouse'
  end

  it 'and dont exist products registered' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Produtos Cadastrados'

    expect(current_path).to eq products_path
    expect(page).to have_content 'Sem produtos cadastrados.'
  end
end