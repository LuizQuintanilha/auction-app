admin = Admin.create!(email: 'vando@leilaodogalpao.com.br', password: '123456', cpf: '53366189347')
admin_dois = Admin.create!(email: 'edna@leilaodogalpao.com.br', password: '123456', cpf: '38125120505')
user = User.create!(email: 'deise@email.com', password: '123456', cpf: '25706733406')
User.create!(email: 'luna@email.com', password: '123456', cpf: '12661055142')

informatica = Category.create!(name:'Informática')
eletronico = Category.create!(name:'Eletrônico')
acessorio = Category.create!(name:'Acessório')
moveis = Category.create!(name:'Móveis')
eletrodomestico = Category.create!(name:'Eletrodoméstico')

mouse = 'MOUSE OFFICE TGT P90'
microondas = 'Microondas 20 Litros'
geladeira = 'Geladeira Eletrulux 130L'
tv = 'Smart-Tv 42 polegadas Samsung'
sofa = 'Sofa 3 lugares Loreal Cinza Grafite'

mouse_product = Product.new(name:'Mouse', weight: 90, width: 12, height: 4, 
                          depth: 6, description: mouse, category: informatica)
microondas_product = Product.new(name:'Microondas', weight: 90, width: 12, height: 4, 
                            depth: 6, description: microondas, category: eletrodomestico)
geladeira_product = Product.new(name:'Geladeira', weight: 90, width: 12, height: 4, 
                              depth: 6, description: geladeira, category: eletrodomestico)
tv_product = Product.new(name:'SMARTV', weight: 90, width: 12, height: 4, 
                                depth: 6, description: tv, category: eletronico)
sofa_product = Product.new(name:'Sofa', weight: 90, width: 12, height: 4, 
                                  depth: 6, description: sofa, category: moveis)

mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
microondas_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'microondas.png')), filename: 'microondas.png')
geladeira_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'geladeira.webp')), filename: 'geladeira.webp')
tv_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'tv.webp')), filename: 'tv.webp')
sofa_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'sofa.webp')), filename: 'sofa.webp')
mouse_product.save
microondas_product.save
geladeira_product.save
tv_product.save
sofa_product.save


lote = ProductBatch.create!(product_ids: 1, admin_id: 1, created_by: admin,
  code: 'ACB112233', start_date: Date.today,  
  deadline: 10.hours.from_now, minimum_value: 622, minimal_difference: 17, approved_by: admin_dois)

ProductBatch.create!(product_ids: 2, admin_id: 1, created_by: admin,
  code: 'ACB321654', start_date: 5.hours.ago,  
  deadline: 1.day.from_now, minimum_value: 698, minimal_difference: 3, approved_by: admin_dois)

lote_dois = ProductBatch.new(product_ids: 3, admin_id: 1, created_by: admin,
  code: 'ACB112244', start_date: Date.today,  
  deadline: 3.hour.from_now, minimum_value: 600, minimal_difference: 8, approved_by: admin_dois)
lote_dois.approve!

lote_tres = ProductBatch.new(product_ids: 4, admin_id: 1, created_by: admin,
  code: 'ACB112255', start_date: 5.hours.ago,  
  deadline: 3.hours.from_now, minimum_value: 1200, minimal_difference: 15, approved_by: admin_dois)
lote_tres.approve!

lote_quatro = ProductBatch.new(product_ids: 5, admin_id: 1, created_by: admin,
  code: 'ACB112210', start_date: 1.hour.from_now,  
  deadline: 1.day.from_now, minimum_value: 600, minimal_difference: 8, approved_by: admin_dois)
lote_quatro.approve!

ProductBatch.create!(product_ids: 2, admin_id: 1, created_by: admin,
  code: 'ACB112277', start_date: Date.today,  
  deadline: 10.hours.from_now, minimum_value: 622, minimal_difference: 17, approved_by: admin_dois)