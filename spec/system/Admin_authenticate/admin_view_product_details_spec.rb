require 'rails_helper'

describe 'Admin view products details' do
  it 'from the homepage' do
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return 'luizab1234'
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Mouse'

    expect(page).to have_content 'Mouse'
    expect(page).to have_content 'luizab1234'
    expect(page).to have_content '3x4'
    expect(page).to have_content '90g'
    expect(page).to have_content '12cm'
    expect(page).to have_content '4cm'
    expect(page).to have_content '6cm'
    expect(page).to have_content 'MOUSE OFFICE TGT P90'
    expect(page).to have_content 'Informática'
    expect(page).to have_link 'Voltar'
  end
  it 'and back to homepage' do
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return 'luizab1234'
    Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12662381744')
    mouse = 'MOUSE OFFICE TGT P90'
    product_category = Category.create!(name: 'Informática')
    produto = Product.create!(name: 'Mouse', photo: '3x4', weight: 90, width: 12, height: 4,
                              depth: 6, description: mouse, category: product_category)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'Email', with: 'luiz@leilaodogalpao.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Mouse'
    click_on 'Voltar'
    expect(current_path).to eq root_path
  end
end