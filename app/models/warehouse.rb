class Warehouse < ApplicationRecord
	validates :name, :code, :description, :address, :cep, :area, presence: true
	validates :code, length: { is: 3}
	
end
