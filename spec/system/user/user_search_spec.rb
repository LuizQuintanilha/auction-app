require 'rails_helper'

describe 'From the homepage' do
  context 'user do a search' do
    it 'sucessfully ' do
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      luna = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
      mouse = 'MOUSE OFFICE TGT P90'
      informatica = Category.create!(name: 'Informática')
      mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                  depth: 6, description: mouse, category: informatica)
      file_path = Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')
      file = File.open(file_path)
      mouse_product.photo.attach(io: file, filename: 'mouse_red.jpg')
      mouse_product.save
      lote = ProductBatch.create!(product_ids: 1, admin_id: 1, created_by: admin, code: 'ACB112233',
                                  start_date: Time.zone.today,
                                  deadline: Time.zone.today, minimum_value: 600, minimal_difference: 50,
                                  approved_by: luiz)

      lote.approve!

      login_as(luna, scope: :user)
      visit root_path
      fill_in 'Buscar Pedido', with: 'Mouse'
      click_on 'Buscar'
      expect(page).to have_content '1 Lote(s) Encontrado(s)'
      expect(page).to have_content 'Código do lote: ACB112233'
      expect(page).to have_content 'Produtos: Mouse'
    end
  end
  it 'unsucessfully' do
    luna = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')

    login_as(luna, scope: :user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'Mouse'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: Mouse'
    expect(page).to have_content 'Nenhum lote encontrado para a busca realizada.'
  end
end
