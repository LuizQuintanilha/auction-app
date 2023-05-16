require 'rails_helper'

describe 'From the homepage' do
  it 'admin view the expireds batches' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    luiz = Admin.create!(email: 'l@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
    lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: 3.days.ago,  
                                  deadline: 1.day.ago, minimum_value: 600, minimal_difference: 50, 
                                  start_time: 1.hour.ago, end_time: 2.hours.ago,   approved_by: luiz)
    lote.save(validate: false)          
   
    login_as(admin, :scope => :admin)                   
    visit root_path
    click_on 'Lotes Expirados'
    
    expect(current_path).to eq expired_batches_path
    expect(page).to have_content 'Lotes Expirado'
    expect(page).to have_content "Código: ACB112233"
  end 
  it 'admin view the expreds batches' do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')    
   
    login_as(admin, :scope => :admin)                   
    visit root_path
    click_on 'Lotes Expirados'
    
    expect(current_path).to eq expired_batches_path
    expect(page).to have_content 'Lotes Expirado'
    expect(page).to have_content "Não existem lotes vencidos"
  end 
end