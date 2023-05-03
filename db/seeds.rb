# Admin seed

Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')

product_category = Category.create!(name:'Informática')
product_category = Category.create!(name:'Eletrônico')
product_category = Category.create!(name:'Acessório')
product_category = Category.create!(name:'Móveis')
product_category = Category.create!(name:'Genérico')

mouse = 'MOUSE OFFICE TGT P90'
produto = Product.create!(name:'Mouse', photo: '3x4', weight: 90, width: 12, height: 4, 
                          depth: 6, description: mouse, category: product_category)
