require 'rails_helper'

describe 'User from the homepage' do
  context 'has acess' do
    it 'to the homepage' do

      visit root_path
      click_on 'Leilão de Estoque'

      expect(current_path).to eq root_path
      within('header') do
        expect(page).to have_link 'Leilão de Estoque'
        expect(page).to have_link 'Produtos Cadastrados'
        expect(page).to have_link 'Lotes Cadastrados'
      end
    end
    it 'to all products registered' do
      visit root_path
      click_on 'Produtos Cadastrados'

      expect(current_path).to eq products_path
      expect(page).to have_content 'Produtos Cadastrados'
    end
    it 'to all batches registered' do
      visit root_path
      click_on 'Lotes Cadastrados'

      expect(current_path).to eq product_batches_path
      expect(page).to have_content 'Lotes Cadastrados'
    end
    it 'fill-in all the fields to login' do 
    end
  end
end