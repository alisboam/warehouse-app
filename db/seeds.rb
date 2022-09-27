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


Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
                email: 'magalu@email.com', telephone: '08007733838')

Supplier.create(name: 'Pernambucanas', company_name: 'Pernambucanas S/A',
                cnpj:'95960950000121',address: 'Av Paulista, 28',
                email: 'per@email.com', telephone: '4000095')