require 'rails_helper'

describe 'From the homepage' do
  context 'authenticated user view the batches informations' do
    context 'when the batches are still in progress' do
      context 'sucessfully' do
        it "and the bid's field" do
          user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
          luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
          luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')

          lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                      minimum_value: 600, minimal_difference: 80)
          lote.approve!

          login_as(user, scope: :user)
          visit root_path

          click_on 'Lotes Cadastrados'
          click_on 'ACB112233'
          click_on 'Fazer Lance'

          expect(page).to have_content 'Fazer Lances'
          expect(page).to have_field 'Value'
          expect(page).to have_button 'Dar Lance'
          expect(page).to have_content 'Diferença mínima entre lances: R$80.0'
          expect(page).to have_content 'Valor atual do lote: R$600.0'
        end
        it 'and do a bid when its the first bid' do
          user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
          luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
          luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
          lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                      minimum_value: 600, minimal_difference: 80)
          lote.approve!

          login_as(user, scope: :user)
          visit root_path
          click_on 'Lotes Cadastrados'
          click_on 'ACB112233'
          click_on 'Fazer Lance'
          fill_in 'Value', with: '601'
          click_on 'Dar Lance'

          expect(page).to have_content 'Lance criado com sucesso'
          expect(page).to have_content "Valor atual do lote: R$#{lote.bids.last&.value}"
        end
        it 'and do a bid when the bid its not first' do
          user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '53366189347')
          luna = User.create!(email: 'luna@email.com', password: '123456', cpf: '38125120505')
          luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '25706733406')
          luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
          lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                      minimum_value: 600, minimal_difference: 35)
          lote.approve!
          bid = Bid.create!(user: luna, product_batch: lote, value: '615')

          login_as(user, scope: :user)
          visit root_path
          click_on 'Lotes Cadastrados'
          click_on 'ACB112233'
          click_on 'Fazer Lance'
          fill_in 'Value', with: '650'
          click_on 'Dar Lance'

          expect(page).to have_content 'Lance criado com sucesso'
          expect(page).to have_content "Valor atual do lote: R$#{lote.bids.last&.value}"
        end
      end
      context 'unsucessfully' do
        it 'when the bids is invalid' do
          user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
          luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
          luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
          lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                      minimum_value: 600, minimal_difference: 80)
          lote.approve!

          login_as(user, scope: :user)
          visit root_path
          click_on 'Lotes Cadastrados'
          click_on 'ACB112233'
          click_on 'Fazer Lance'
          fill_in 'Value', with: '590'
          click_on 'Dar Lance'

          expect(page).to have_content 'Deve ser maior que valor inicial'
          expect(page).to have_content 'Valor atual do lote: R$600.0'
        end
        it 'when the bids is not the first bid' do
          user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '53366189347')
          luna = User.create!(email: 'luna@email.com', password: '123456', cpf: '38125120505')
          luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '25706733406')
          luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
          lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                      minimum_value: 600, minimal_difference: 35)
          lote.approve!
          bid = Bid.create!(user: luna, product_batch: lote, value: '600')

          login_as(user, scope: :user)
          visit root_path
          click_on 'Lotes Cadastrados'
          click_on 'ACB112233'
          click_on 'Fazer Lance'
          fill_in 'Value', with: '601'
          click_on 'Dar Lance'

          expect(page).to have_content 'Novo lance deve ser maior que o valor atual somado com o valor de diferença'
          expect(page).to have_content "Valor atual do lote: R$#{lote.bids.last&.value}"
        end
      end
    end
    context 'when the batch is not in progress' do
      it 'and can not view the bid field' do
        user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
        luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
        luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
        lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: 2.hours.from_now, deadline: 5.days.from_now,
                                    minimum_value: 600, minimal_difference: 80)
        lote.approve!

        login_as(user, scope: :user)
        visit root_path
        click_on 'Lotes Cadastrados'
        click_on 'ACB112233'

        expect(current_path).to eq '/product_batches/1'
        expect(page).to have_content 'Lote Futuro'
      end
    end
  end

  context 'User no authenticated' do
    it 'has np acess to the bid field' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')

      lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2,
                                  code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                  minimum_value: 600, minimal_difference: 80,
                                 )
      lote.approve!

      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'

      expect(current_path).to eq '/product_batches/1'
    end
  end
end
