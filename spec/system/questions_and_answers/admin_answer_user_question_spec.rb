require 'rails_helper'

describe 'From the homepage' do
  it 'admin view the question' do
    luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf:'12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today, 
                                    deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50, start_time: 1.hour.ago, end_time: 2.hour.from_now)
    lote.approve!
    question = Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)

    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Responder'

    expect(page).to have_content 'Responder Usuário:'
    expect(page).to have_content "Usuário: #{question.user.email}"
    expect(page).to have_content "#{question.content}"
    expect(page).to have_content 'Formas de envio do produto!'
    expect(page).to have_field 'Digite sua resposta'
    expect(page).to have_button 'Enviar Resposta'

  end
  it 'admin answer a question' do
    luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf:'12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today, 
                                    deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50, start_time: 1.hour.ago, end_time: 2.hour.from_now)
    lote.approve!
    question = Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)
    
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Responder'
    fill_in 'Digite sua resposta', with: 'Envio será realizado pela Transportadora JSTransportes no prazo de até 10 dias úteis'
    click_on 'Enviar Resposta'
    
    expect(page).to have_content 'Resposta enviada com sucesso.'
  end
end