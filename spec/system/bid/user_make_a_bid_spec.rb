require 'rails_helper'

describe 'From the homepage' do
  context 'authenticated user view the bids informations' do
    it "and the bid's field" do 
      user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')

      lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now, 
                                  minimum_value: 600, minimal_difference: 80, start_time: Time.current, end_time: 1.hour.from_now)
      lote.approve!

      login_as(user, :scope => :user)
      visit root_path

      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Lance'
      
     
      expect(page).to have_field 'Value'
      expect(page).to have_content 'Valor inicial do lote: R$600'
      expect(page).to have_content 'Valor atual do lote: R$600.0'
    end
    it "and do a bid" do 
      user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')

      lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now, 
                                  minimum_value: 600, minimal_difference: 80, start_time: Time.current, end_time: 1.hour.from_now)
      lote.approve!
    
      login_as(user, :scope => :user)
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Lance'
      fill_in 'Value', with: '681'
      click_on 'Dar Lance'
    
      expect(page).to have_content "Valor atual do lote: R$681"
      expect(page).to have_content 'Lance criado com sucesso'
    end
    it 'and the bid is not valid' do
      user = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')

      lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now, 
                                  minimum_value: 600, minimal_difference: 80, start_time: Time.current, end_time: 1.hour.from_now)
      lote.approve!
    
      login_as(user, :scope => :user)
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Lance'
      fill_in 'Value', with: '599'
      click_on 'Dar Lance'
    
      expect(page).to have_content 'Novo lance deve ser maior que o valor atual somado com o valor de diferença.'
      expect(page).to have_content "Valor atual do lote: R$599"

    end
  end
end 