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

produto = Product.create!(name:'Mouse', photo: '3x4', weight: 90, width: 12, height: 4, 
                          depth: 6, description: mouse, category: informatica)
produto = Product.create!(name:'Microondas', photo: '8x16', weight: 90, width: 12, height: 4, 
                            depth: 6, description: microondas, category: eletrodomestico)
produto = Product.create!(name:'Geladeira', photo: '3x4', weight: 90, width: 12, height: 4, 
                              depth: 6, description: geladeira, category: eletrodomestico)
produto = Product.create!(name:'SMARTV', photo: '8x16', weight: 90, width: 12, height: 4, 
                                depth: 6, description: tv, category: eletronico)
produto = Product.create!(name:'Sofa', photo: '8x16', weight: 90, width: 12, height: 4, 
                                  depth: 6, description: sofa, category: moveis)

lote = ProductBatch.create!(code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now, minimum_value: 600)