require 'rails_helper'

describe 'Admin view all product batch registered' do
  context 'with status' do
    it 'approved' do
      Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      lote = ProductBatch.new(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                              deadline: 5.days.from_now, minimum_value: 600,
                              minimal_difference: 50)
      lote.save
      lote.approve!

      login_as(admin, scope: :admin)
      visit root_path
      click_on 'Lotes Cadastrados'

      expect(current_path).to eq product_batches_path
      expect(page).to have_content 'Lotes Cadastrados'
      expect(page).to have_content 'ACB112233'
    end

    it 'wait_approve' do
      admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
      ProductBatch.create!(admin_id: 1, created_by: admin, code: 'ACB112233', start_date: Time.zone.today,
                           deadline: 5.days.from_now, minimum_value: 600, minimal_difference: 50)
      visit root_path
      within('nav.admin') do
        click_on 'Admin'
      end
      within('form') do
        fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Aprovar lote'

      expect(page).to have_content 'Lotes Cadastrados'
      expect(page).to have_content 'ACB112233'
      expect(page).to have_content 'Estatus:'
      expect(page).to have_content 'wait_approve'
      expect(page).to have_button 'Aprovar'
    end
  end

  it "don't have batch's register" do
    admin = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Aprovar lote'

    expect(page).to have_content 'Não existem lotes cadastrados'
  end
end
