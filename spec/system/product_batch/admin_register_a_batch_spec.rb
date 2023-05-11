require 'rails_helper'

describe 'From the homepage' do 
  it 'sucessfully' do
    # Arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Aprovar lote'
    click_on 'Cadastrar Lote'
    # Assert
    expect(page).to have_field('Code')
    expect(page).to have_field('Start date')
    expect(page).to have_field('Deadline')
    expect(page).to have_field('Minimum value')
    expect(page).to have_button 'Salvar'
  end

  context 'admin register a new batch' do
    it 'sucessfully' do
      # Arrange
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
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

      # Act
      login_as(admin, :scope => :admin)
      visit root_path
      click_on 'Cadastrar Lote'
      check 'Microondas'
      fill_in 'Code', with: 'ABC123456'
      fill_in 'Start date', with: Date.today
      fill_in 'Deadline', with: 3.days.from_now
      fill_in 'Minimum value', with: 500
      fill_in 'Minimal difference', with: 80
      click_on 'Salvar'
      # Assert
      expect(page).to have_content 'Lotes Cadastrados '
      expect(page).to have_link('ABC123456')
      expect(page).to have_content 'Status:'
      expect(page).to have_content 'wait_approve'
      expect(page).to have_button 'Aprovar'
    end
    it 'unsucessfully' do
      # Arrange
      Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      # Act
      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Aprovar lote'
      click_on 'Cadastrar Lote'
      fill_in 'Code', with: ''
      fill_in 'Start date', with: ''
      fill_in 'Deadline', with: 2.days.from_now
      fill_in 'Minimum value', with: 1.99
      click_on 'Salvar'
      # Assert
      expect(page).to have_content('Deve ser selecionado pelo menos um produto.')
    end
  end
end