require 'rails_helper'

describe 'From the homepage' do
  context 'after authenticated' do
    it 'user view the question field' do
      luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                  deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50,
                                  start_time: 1.hour.ago, end_time: 2.hours.from_now)
      lote.approve!
      lote.close_batch!

      login_as(luiz, scope: :user)
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Pergunta'

      expect(page).to have_content 'Enviar Pergunta'
      expect(page).to have_field 'Pergunta'
      expect(page).to have_button 'Enviar'
    end
    it 'and do a question' do
      luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                  deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50,
                                  start_time: 1.hour.ago, end_time: 2.hours.from_now)
      lote.approve!
      lote.close_batch!

      login_as(luiz, scope: :user)
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Pergunta'
      fill_in 'Pergunta', with: 'Quero saber as formas de pagamento'
      click_on 'Enviar'

      expect(page).to have_content 'Pergunta enviada com sucesso.'
    end
    it 'and can not do a question' do
      luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                  deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50,
                                  start_time: 1.hour.ago, end_time: 2.hours.from_now)
      lote.approve!
      lote.close_batch!

      login_as(luiz, scope: :user)
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Pergunta'
      fill_in 'Pergunta', with: ''
      click_on 'Enviar'

      expect(page).to have_content 'Erro ao enviar a pergunta.'
    end
  end

  context 'user with no authenticate' do
    it 'do a question' do
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                  deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50,
                                  start_time: 1.hour.ago, end_time: 2.hours.from_now)
      lote.approve!
      lote.close_batch!

      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'ACB112233'
      click_on 'Fazer Pergunta'

      expect(current_path).to eq new_user_session_path
      expect(page).to have_field 'Email'
      expect(page).to have_field 'Password'
    end
  end
end
