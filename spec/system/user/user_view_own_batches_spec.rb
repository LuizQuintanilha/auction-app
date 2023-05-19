require 'rails_helper'

describe 'From the homepage' do
  context 'authenticate user view the user_space'
  it "and there's one batch" do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
    mouse = 'MOUSE OFFICE TGT P90'
    informatica = Category.create!(name:'Informática')
    mouse_product = Product.new(name:'Mouse', weight: 90, width: 12, height: 4, 
                                depth: 6, description: mouse, category: informatica)
    mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
    mouse_product.save
    lote = ProductBatch.create!(product_ids: 1, admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today,  
                                  deadline: Date.today, minimum_value: 600, minimal_difference: 50, 
                                  start_time: 1.hour.ago, end_time: 1.minutes.ago, approved_by: luiz)
    lote.approve!     
    bid = Bid.create!(user_id: 1, value: '1000', product_batch_id: 1)
    lote.close_batch!

    login_as(user, :scope => :user)                   
    visit root_path
    click_on 'Meus Lotes'

    expect(current_path).to eq user_space_path
    expect(page).to have_content 'Código do lote: ACB112233'
    expect(page).to have_content 'Produtos: Mouse'
  end
  it "and there's no batches" do
    user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')

    login_as(user, :scope => :user)                   
    visit user_space_path

    expect(page).to have_content 'Meus Lotes'
    expect(page).to have_content 'Nenhum lote adquirido'
  end
end