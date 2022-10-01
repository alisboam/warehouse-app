require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        supplier = Supplier.create(name: '', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magalu@email.com', telephone: '08007733838')
        expect(supplier.valid?).to eq false
      end

      it 'false when company_name is empty' do
        supplier = Supplier.create(name: 'Magalu', company_name: '',
                                   cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magalu@email.com', telephone: '08007733838')
        expect(supplier.valid?).to eq false
      end

      it 'false when cnpj is empty' do
        supplier = Supplier.create(name: 'Magalu', company_name: '',
                                   cnpj: '', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magalu@email.com', telephone: '08007733838')
        expect(supplier.valid?).to eq false
      end

      it 'false when address is empty' do
        supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: '47960950000121', address: '',
                                   email: 'magalu@email.com', telephone: '08007733838')
        expect(supplier.valid?).to eq false
      end

      it 'false when email is empty' do
        supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: '', telephone: '08007733838')
        expect(supplier.valid?).to eq false
      end

      it 'false when telephone is empty' do
        supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magalu@email.com', telephone: '')
        expect(supplier.valid?).to eq false
      end
    end
    context 'uniqueness' do
      it 'false when cnpj is already in use' do
        first_supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                         cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                         email: 'magalu@email.com', telephone: '08007733838')

        second_supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                          cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                          email: 'magalu@email.com', telephone: '08007733838')

        expect(second_supplier.valid?).to eq false
      end
    end

    context 'characters' do
      it 'false when cnpj quantity is not equal to 14' do
        supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: '479', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magalu@email.com', telephone: '0800773383')
        expect(supplier.valid?).to eq false
      end

      it 'false when cnpj is not a number' do
        supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: 'abcdefghijklmn', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magalu@email.com', telephone: '0800773383')
        expect(supplier.valid?).to eq false
      end

      it 'false when email is not valid' do
        supplier = Supplier.create(name: 'Magalu', company_name: 'MAGAZINE LUIZA S/A',
                                   cnpj: '47960950000121', address: 'VOLUNTARIOS DA FRANCA, 28',
                                   email: 'magaluemail.com', telephone: '0800773383')
        expect(supplier.valid?).to eq false
      end
    end
  end
end
