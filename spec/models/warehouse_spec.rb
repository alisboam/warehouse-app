require 'rails_helper'

RSpec.describe Warehouse, type: :model do
	#hashtag indica método de instância
	
	describe '#valid?' do
		context 'presence' do
			
			it 'false when name is empty' do
				# arrange
				warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
					address: 'Praça Sen. Salgado Filho', cep: '20021340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end
	
			it 'false when code is empty' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', area: 60_000,
					address: 'Praça Sen. Salgado Filho', cep: '20021340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end
	
			it 'false when city is empty' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: '', area: 60_000,
					address: 'Praça Sen. Salgado Filho', cep: '20021340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end
	
			it 'false when area is empty' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'RJ', area: '',
					address: 'Praça Sen. Salgado Filho', cep: '20021340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end
	
			it 'false when address is empty' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro', area: 60_000,
					address: '', cep: '20021340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end
	
				it 'false when cep is empty' do
					# arrange
					warehouse = Warehouse.new(name: 'rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
						address: 'Praça Sen. Salgado Filho', cep: '',
						description: 'Galpão destinado a cargas pequenas')
					# act
					result = warehouse.valid?
					# assert
					expect(result).to eq false
				end
	
					it 'false when description is empty' do
						# arrange
						warehouse = Warehouse.new(name: 'rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
							address: 'Praça Sen. Salgado Filho', cep: '20021340',
							description: '')
						# act
						result = warehouse.valid?
						# assert
						expect(result).to eq false
					end
		end
		context 'uniqueness' do
				it 'false when code is already in use' do
					# arrange
					first_warehouse = Warehouse.create(name: 'rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
																			address: 'Praça Sen. Salgado Filho', cep: '20021340',
																			description: 'Galpao do RJ')
					second_warehouse = Warehouse.create(name: 'Niteroi', code: 'SDU', city: 'Niteroi', area: 60_000,
																			address: 'Niteroi', cep: '20021-000',
																			description: 'Galpa de Niteroi')
					# act
					result = second_warehouse.valid?
					# assert
					expect(result).to eq false
				end
		end
		context 'characters' do
			it 'false when code quantity is not equal to 3' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: 'SD', city: 'Rio de Janeiro', area: 60_000,
					address: 'Praça Sen. Salgado Filho', cep: '20021340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end

			it 'false when cep quantity is not equal to 8' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
					address: 'Praça Sen. Salgado Filho', cep: '20021-340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end

			it 'false when cep is not a number' do
				# arrange
				warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
					address: 'Praça Sen. Salgado Filho', cep: '20021-340',
					description: 'Galpão destinado a cargas pequenas')
				# act
				result = warehouse.valid?
				# assert
				expect(result).to eq false
			end
		end
	end
end
