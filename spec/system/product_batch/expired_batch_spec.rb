require 'rails_helper'

describe 'From the homepage' do
  it 'admin view the expireds batches' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    mouse = 'MOUSE OFFICE TGT P90'
    informatica = Category.create!(name: 'Informática')
    mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                depth: 6, description: mouse, category: informatica)
    file_path = Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')
    file = File.open(file_path)
    mouse_product.photo.attach(io: file, filename: 'mouse_red.jpg')
    mouse_product.save
    mouse_product.save
    lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB440055', start_date: Time.zone.today,
                            deadline: Time.zone.today, minimum_value: 600, minimal_difference: 50,
                            start_time: 5.hours.ago, end_time: 2.hours.ago, approved_by: luiz)
    lote.save(validate: false)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Lotes Expirados'

    expect(current_path).to eq expired_batches_path
    expect(page).to have_content 'Lotes Expirado'
    expect(page).to have_content 'Código: ACB440055'
    expect(page).to have_content 'Lote sem Lance'
    expect(page).to have_button 'Excluir Lote'
  end
  it "and there'n no batches" do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Lotes Expirados'

    expect(current_path).to eq expired_batches_path
    expect(page).to have_content 'Lotes Expirado'
    expect(page).to have_content 'Não existem lotes expirados'
  end
  it 'admin delete a batch with no bids' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: 3.days.ago,
                            deadline: 1.day.ago, minimum_value: 600, minimal_difference: 50,
                            start_time: 1.hour.ago, end_time: 2.hours.ago, approved_by: luiz)
    lote.save(validate: false)

    login_as(admin, scope: :admin)
    visit expired_batches_path
    click_on 'Excluir Lote'

    expect(page).to have_content 'Lote excluído com sucesso'
  end
  it 'admin approve a batch with a bid' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
    mouse = 'MOUSE OFFICE TGT P90'
    informatica = Category.create!(name: 'Informática')
    mouse_product = Product.new(name: 'Mouse', weight: 90, width: 12, height: 4,
                                depth: 6, description: mouse, category: informatica)
    file_path = Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')
    file = File.open(file_path)
    mouse_product.photo.attach(io: file, filename: 'mouse_red.jpg')
    mouse_product.save
    lote = ProductBatch.create!(product_ids: 1, admin_id: 1, created_by: admin,
                                code: 'ACB112233', start_date: Time.zone.today,
                                deadline: Time.zone.today, minimum_value: 600, minimal_difference: 50,
                                start_time: 1.hour.ago, end_time: 1.minute.ago, approved_by: luiz)
    lote.approve!
    Bid.create!(user_id: 1, value: '1000', product_batch_id: 1)

    login_as(admin, scope: :admin)
    visit expired_batches_path
    click_on 'Encerrar'

    expect(page).to have_content 'Código: ACB112233'
    expect(page).to have_content 'Lote encerrado com sucesso'
    expect(page).not_to have_button 'Encerrar'
  end
  it 'admin view the winners' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
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
                                start_time: 1.hour.ago, end_time: 1.minute.ago, approved_by: luiz)

    lote.approve!
    Bid.create!(user_id: 1, value: '1000', product_batch_id: 1)
    login_as(admin, scope: :admin)
    visit expired_batches_path
    click_on 'Encerrar'
    click_on 'Lotes Vencedores'

    expect(page).to have_content 'Resultado dos Vencedores'
    expect(page).to have_content 'Código do Lote: ACB112233'
  end
end
