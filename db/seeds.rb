# Admin seed

Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')

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

geladeira_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'geladeira.webp')), filename: 'geladeira.webp')
microondas_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'microondas.png')), filename: 'microondas.png')
mouse_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'mouse_red.jpg')), filename: 'mouse_red.jpg')
sofa_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'sofa.webp')), filename: 'sofa.webp')
tv_product.photo.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'file', 'tv.webp')), filename: 'tv.webp')
mouse_product.save
microondas_product.save
geladeira_product.save
tv_product.save
sofa_product.save