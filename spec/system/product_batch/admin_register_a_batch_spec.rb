require 'rails_helper'

describe 'From the homepage' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Aprovar lote'
    click_on 'Cadastrar Lote'

    expect(page).to have_field('Código')
    expect(page).to have_field('Início')
    expect(page).to have_field('Término')
    expect(page).to have_field('Diferença mínima')
    expect(page).to have_button 'Salvar'
  end

  context 'admin register a new batch' do
    it 'sucessfully' do
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
      check 'Microondas'
      fill_in 'Código', with: 'ABC123456'
      fill_in 'Início', with: Time.zone.today
      fill_in 'Término', with: 3.days.from_now
      fill_in 'Valor inicial', with: 500
      fill_in 'Diferença mínima', with: 80
      click_on 'Salvar'

      expect(page).to have_content 'Lotes Cadastrados '
      expect(page).to have_link('ABC123456')
      expect(page).to have_content 'Estatus:'
      expect(page).to have_content 'wait_approve'
      expect(page).to have_button 'Aprovar'
    end
    it 'unsucessfully' do
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Aprovar lote'
      click_on 'Cadastrar Lote'
      fill_in 'Código', with: ''
      fill_in 'Início', with: ''
      fill_in 'Término', with: 2.days.from_now
      fill_in 'Valor inicial', with: 1.99
      click_on 'Salvar'

      expect(page).to have_content('Deve ser selecionado pelo menos um produto.')
    end
  end
end
