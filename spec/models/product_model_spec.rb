require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                    cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                    email: 'magalu@email.com', telephone: '08007733838')
        product = ProductModel.create(name: '', weight: 8000, width: 70, height: 45, depth: 10,
                                      sku: 'TV-32-SAMSU-XPTO', supplier: supplier)

        expect(product.valid?).to eq false
      end

      it 'false when sku is empty' do
        supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                    cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                    email: 'magalu@email.com', telephone: '08007733838')
        product = ProductModel.create(name: 'Magalu', weight: 8000, width: 70, height: 45, depth: 10,
                                      sku: '', supplier: supplier)

        expect(product.valid?).to eq false
      end

      context 'uniqueness' do
        it 'false when sku is already in use' do
          supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                      cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                      email: 'magalu@email.com', telephone: '08007733838')
          product_a = ProductModel.create(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                          sku: 'TV-32-SAMSU-XPTO-500', supplier: supplier)
          product_b = ProductModel.create(name: 'Caixa de Som', weight: 1000, width: 20, height: 35, depth: 10,
                                          sku: 'TV-32-SAMSU-XPTO-500', supplier: supplier)
          expect(product_b.valid?).to eq false
        end
      end

      context 'characters' do
        it 'false when weight is not a number' do
          supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                      cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                      email: 'magalu@email.com', telephone: '08007733838')
          product = ProductModel.create(name: 'TV 32', weight: 'b', width: 70, height: 45, depth: 10,
                                        sku: 'TV-32-SAMSU-XPTO-500', supplier: supplier)
          expect(product.valid?).to eq false
        end
        it 'false when weight is equal to zero' do
          supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                      cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                      email: 'magalu@email.com', telephone: '08007733838')
          product = ProductModel.create(name: 'TV 32', weight: 0, width: 70, height: 45, depth: 10,
                                        sku: 'TV-32-SAMSU-XPTO-500', supplier: supplier)
          expect(product.valid?).to eq false
        end
        it 'false when weight is less than zero' do
          supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                      cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                      email: 'magalu@email.com', telephone: '08007733838')
          product = ProductModel.create(name: 'TV 32', weight: -1, width: 70, height: 45, depth: 10,
                                        sku: 'TV-32-SAMSU-XPTO-500', supplier: supplier)
          expect(product.valid?).to eq false
        end
        it 'false when sku is less than 20 chars' do
          supplier = Supplier.create!(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                      cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                      email: 'magalu@email.com', telephone: '08007733838')
          product = ProductModel.create(name: 'TV 32', weight: 20, width: 70, height: 45, depth: 10,
                                        sku: 'TV-32', supplier: supplier)
          expect(product.valid?).to eq false
        end
      end
    end
  end
end
