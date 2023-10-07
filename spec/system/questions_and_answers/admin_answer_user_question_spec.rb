require 'rails_helper'

describe 'From the homepage' do
  it 'admin view the question' do
    User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
    lote.approve!
    question = Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Responder'

    expect(page).to have_content 'Responder Usuário:'
    expect(page).to have_content "Usuário: #{question.user.email}"
    expect(page).to have_content question.content.to_s
    expect(page).to have_content 'Formas de envio do produto!'
    expect(page).to have_field 'Digite sua resposta'
    expect(page).to have_button 'Enviar Resposta'
  end
  it 'admin answer a question' do
    User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
    lote.approve!
    Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Responder'
    fill_in 'Digite sua resposta',
            with: 'Envio será realizado pela Transportadora JSTransportes no prazo de até 10 dias úteis'
    click_on 'Enviar Resposta'

    expect(page).to have_content 'Resposta enviada com sucesso.'
    expect(page).not_to have_content 'Sem perguntas a serem respondidas"'
  end
  it "admin can't answer the question" do
    User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
    lote.approve!
    Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Responder'
    fill_in 'Digite sua resposta', with: ''
    click_on 'Enviar Resposta'

    expect(page).to have_content 'A resposta não pode estar em branco ou ter menos que 6 caracteres.'
  end
  it " answer can't less the 6 letters" do
    User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
    lote.approve!
    Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Responder'
    fill_in 'Digite sua resposta', with: 'Sim'
    click_on 'Enviar Resposta'

    expect(page).to have_content 'A resposta não pode estar em branco ou ter menos que 6 caracteres.'
  end
  it ' admin delete a question' do
    User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                                deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
    lote.approve!
    Question.create!(user_id: 1, product_batch_id: 1, content: 'Formas de envio do produto!', hidden: false)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Caixa de Perguntas'
    click_on 'Excluir Pergunta'

    expect(page).to have_content 'Pergunta excluída com sucesso.'
  end
end
