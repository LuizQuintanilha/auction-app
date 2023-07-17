require 'rails_helper'

describe 'From the home page' do
  context 'sucessfully' do
    it 'user favorite a lote' do
      user = User.create!(email: 'user@gmail.com', password: '123456', cpf: '25706733406' )
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today, 
                                  deadline: 5.days.from_now, minimum_value: 600, 
                                  minimal_difference: 50, start_time: 1.hour.from_now, end_time: 2.hour.from_now)
      lote.approve!
      login_as(user, :scope => :user)                   
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'Favoritar'

      expect(page).to have_content "Lote #{lote.code} favoritado com sucesso"
      expect(page).not_to have_button 'Favoritar'
    end
    it 'and view you favorites batches' do
      user = User.create!(email: 'user@gmail.com', password: '123456', cpf: '25706733406' )
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today, 
                                  deadline: 5.days.from_now, minimum_value: 600, 
                                  minimal_difference: 50, start_time: 1.hour.from_now, end_time: 2.hour.from_now)
      lote.approve!
      login_as(user, :scope => :user)                   
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'Favoritar'
      click_on 'Favoritos'

      expect(current_path).to eq "/favorite_table"
      expect(page).to have_content lote.code
      expect(page).to have_button 'Desfavoritar'
    end
    it 'and unfavorite a batch' do
      user = User.create!(email: 'user@gmail.com', password: '123456', cpf: '25706733406' )
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today, 
                                  deadline: 5.days.from_now, minimum_value: 600, 
                                  minimal_difference: 50, start_time: 1.hour.from_now, end_time: 2.hour.from_now)
      lote.approve!
      login_as(user, :scope => :user)                   
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'Favoritar'
      click_on 'Favoritos'
      click_on 'Desfavoritar'
  
      expect(current_path).to eq "/favorite_table"
      expect(page).to have_content "Lote desfavoritado com sucesso"
      expect(page).to have_content 'Lista de Favoritos está vazia'
    end
  end

 
  context 'has no acess' do
    it 'to another user favorite batches' do
      user = User.create!(email: 'user@gmail.com', password: '123456', cpf: '25706733406' )
      luna = User.create!(email: 'luna@email.com', password: '123456', cpf: '38125120505')
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Date.today, 
                                  deadline: 5.days.from_now, minimum_value: 600, 
                                  minimal_difference: 50, start_time: 1.hour.from_now, end_time: 2.hour.from_now)
      lote.approve!
      login_as(user, :scope => :user)                   
      visit root_path
      click_on 'Lotes Cadastrados'
      click_on 'Favoritar'
      click_on 'Sair'

      login_as(luna, :scope => :user)
      visit root_path
      click_on 'Favoritos'

      expect(current_path).to eq favorite_table_path
      expect(page).to have_content 'Lista de Favoritos está vazia'
    end
  end
end