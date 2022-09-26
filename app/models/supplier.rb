class Supplier < ApplicationRecord
  validates :name, :company_name, :address, :cnpj, :telephone, presence: true
  validates :email, presence: true, email: true
	validates :cnpj, numericality: { only_integer: true }
  validates :cnpj, length: { is: 14 }
  validates :cnpj, uniqueness: true
end
