require 'rails_helper'

describe 'User visit homepage' do
  context 'without authenticate' do
    it 'and see informations' do
      visit root_path
      click_on 'Leilão de Estoque'
      expect(current_path).to eq root_path
      within('header') do
        expect(page).to have_link 'Leilão de Estoque'
        expect(page).to have_link 'Produtos Cadastrados'
        expect(page).to have_link 'Lotes Cadastrados'
      end
    end
    it 'view all products registered' do
      informatica = Category.create!(name: 'Informática')
      mouse = 'MOUSE OFFICE TGT P90'
      mouse_product = Product.new(name: 'Mouse',
                                  weight: 90,
                                  width: 12,
                                  height: 4,
                                  depth: 6,
                                  description: mouse,
                                  category: informatica)
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg' )),
                                filename: 'mouse_red.jpg' )
      mouse_product.save
      visit root_path
      click_on 'Produtos Cadastrados'
      expect(current_path).to eq products_path
      expect(page).to have_content 'Produtos Cadastrados'
      expect(page).to have_content 'Produto:'
      expect(page).to have_link 'Mouse'
    end
    it 'and has no product registered' do
      visit root_path
      click_on 'Produtos Cadastrados'
      expect(current_path).to eq products_path
      expect(page).to have_content 'Produtos Cadastrados'
      expect(page).to have_content 'Sem produtos cadastrados.'
    end
    it 'and view all future batches ' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br',
                            password: '123456', 
                            cpf: '13008409784')
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br',
                            password: '123456', 
                            cpf: '12662381744')
      informatica = Category.create!(name: 'Informática')
      mouse = 'MOUSE OFFICE TGT P90'
      mouse_product = Product.new(name: 'Mouse',
                                  weight: 90,
                                  width: 12,
                                  height: 4,
                                  depth: 6,
                                  description: mouse,
                                  category: informatica
                                )
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), 
                                 filename: 'mouse_red.jpg')
      mouse_product.save
      future_batch = ProductBatch.new(admin_id: 1,
                                      code: 'ABD332211',
                                      start_date: 2.days.from_now,
                                      deadline: 5.days.from_now,
                                      minimum_value: 800,
                                      minimal_difference: 100,
                                      created_by: luiz,
                                      approved_by: luana,
                                      start_time: 1.hour.from_now,
                                      end_time: 2.hour.from_now
                                    )
      future_batch.approve!
      visit root_path
      click_on 'Lotes Cadastrados'
      expect(page).to have_content 'Lote Futuro'
      expect(page).to have_link 'ABD332211'
    end
    it 'and view all currently batches ' do
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br',
                              password: '123456',
                              cpf: '13008409784'
                            )
      luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br',
                            password: '123456',
                            cpf: '12662381744'
                          )
      informatica = Category.create!(name: 'Informática')
      mouse = 'MOUSE OFFICE TGT P90'
      mouse_product = Product.new(name: 'Mouse',
                                    weight: 90,
                                    width: 12,
                                    height: 4,
                                    depth: 6,
                                    description: mouse,
                                    category: informatica
                                  )
      mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg' )),
                                filename: 'mouse_red.jpg')
      mouse_product.save
      current_batch = ProductBatch.new( 
                                        admin_id: 1,
                                        code: 'ABD332211',
                                        start_date: Time.current,
                                        deadline: Time.current,
                                        minimum_value: 800,
                                        minimal_difference: 100,
                                        created_by: luiz,
                                        approved_by: luana,
                                        start_time: Time.current,
                                        end_time: 1.hour.from_now
                                      )
      current_batch.approve!
      visit root_path
      click_on 'Lotes Cadastrados'
      expect(page).to have_content 'Lote em Andamento'
      expect(page).to have_link 'ABD332211'
    end
    it 'and there no batches registered' do
      visit root_path
      click_on 'Lotes Cadastrados'
      expect(page).to have_content 'Lotes Cadastrados'
      expect(page).to have_content 'Não existem lotes em andamento'
    end
  end
end
