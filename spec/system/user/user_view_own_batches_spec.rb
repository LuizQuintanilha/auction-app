require 'rails_helper'

describe 'From the homepage' do
  context 'authenticate user view the user space' do
    context 'then do a bid in a batch and win it' do
      it "and receive a individual congratulations " do
        admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
        luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
        User.create!(email: 'luiz@email.com', password: '123456', cpf: '53366189347')
        user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
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
        Bid.create!(user_id: 1, value: '610', product_batch_id: 1)
        Bid.create!(user: user, value: '700', product_batch_id: 1)
        lote.finished!
        lote.close_batch!

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meus Lotes'

        expect(current_path).to eq user_space_path
        expect(page).to have_content 'Parabéns!!!'
        expect(page).to have_content "Você é o vencedor do Lote: #{lote.code}"
        expect(page).to have_content "Produto(s) Adquirido(s): #{mouse_product.description}"
        expect(page).to have_content "Valor final do lote: R$#{lote.bids.maximum(:value)}"
      end
    end
    context 'and do a bid but the bid is not the bigger' do
      it 'and receive the information about the finished batch' do
        admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
        luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
        User.create!(email: 'luiz@email.com', password: '123456', cpf: '53366189347')
        user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')
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
        Bid.create!(user: user, value: '700', product_batch_id: 1)
        Bid.create!(user_id: 1, value: '720', product_batch_id: 1)
        lote.finished!
        lote.close_batch!

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meus Lotes'

        expect(current_path).to eq user_space_path
        expect(page).not_to have_content  "Você é o vencedor do Lote: #{lote.code}"
      end
    end
  end 
  it "and there's no batches" do
    user = User.create!(email: 'luna@email.com', password: '123456', cpf: '15171561737')

    login_as(user, scope: :user)
    visit user_space_path

    expect(page).to have_content 'Meus Lotes'
    expect(page).to have_content 'Nenhum lote adquirido'
  end
end
