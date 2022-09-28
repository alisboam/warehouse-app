require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
		context 'presence' do
			it 'false when name is empty' do
				supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
          cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
          email: 'magalu@email.com', telephone: '08007733838')
        product = ProductModel.create(name: '', weight: 8000, width: 70, height: 45, depth:10,
            sku:'TV-32-SAMSU-XPTO', supplier: supplier)

				expect(product.valid?).to eq false
			end

			it 'false when sku is empty' do
				supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
          cnpj:'47960950000121',address: 'VOLUNTARIOS DA FRANCA, 28',
          email: 'magalu@email.com', telephone: '08007733838')
        product = ProductModel.create(name: 'Magalu', weight: 8000, width: 70, height: 45, depth:10,
            sku:'', supplier: supplier)

				expect(product.valid?).to eq false
			end

    end
  end
end
