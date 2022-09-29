# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                address: 'Praça Sen. Salgado Filho', cep: '20021340',
                description: 'Galpão destinado a cargas pequenas')

Warehouse.create(name: 'São Paulo', code: 'GRU', city: 'São Paulo', area: 100_000,
								address: 'Av. São Paulo', cep: '20021340',
								description: 'Galpão destinado a cargas grandes')


@supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                cnpj:'47960950000127',address: 'VOLUNTARIOS DA FRANCA, 28',
                email: 'magalu@email.com', telephone: '08007733838')

@supplier_b = Supplier.create(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
                cnpj:'95960950000125',address: 'Av Paulista, 28',
                email: 'per@email.com', telephone: '4000095')

ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth:10,
                  sku:'TV-32-SAMSU-XPTO-500', supplier: @supplier)

ProductModel.create!(name: 'Monitor 18', weight: 3000, width: 50, height: 15, depth:20,
                  sku:'MOB-32-SAMSU-XPTO-500', supplier: @supplier_b)