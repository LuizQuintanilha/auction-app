require 'rails_helper'

describe 'Admin view all product batch registered' do
  context 'with status' do
    
    it 'approved' do
      # Arrange
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.create!(ccode: 'ACB112233', start_date: Date.today, 
                                  deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
      
      # Act
      login_as(admin, :scope => :admin)
      visit root_path
      click_on 'Aprovar lote'
      # Assert
      expect(current_path).to eq aprove_path
      expect(page).to have_content 'Lotes Cadastrados Aguardando Aprovação'
      expect(page).to have_content 'ACB112233'
    end

    it 'wait_approve' do
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.create!(created_by: admin, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
      visit root_path
      within('nav') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Aprovar lote'

      expect(page).to have_content 'Lotes Cadastrados Aguardando Aprovação'
      expect(page).to have_content 'ACB112233'
      expect(page).to have_content 'Status:'
      expect(page).to have_content 'wait_approve'
      expect(page).to have_button 'Aprovar'
    end
  end

  it "don't have batch's register" do
    # Arrange
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Lotes Cadastrados'
    # Assert
    expect(page).to have_content 'Não existem lotes cadastrados'
  end
end
