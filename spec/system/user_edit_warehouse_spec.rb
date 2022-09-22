require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de editar' do
    #Arrange 
    
    Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Praça Sen. Salgado Filho', cep: '20021340',
      description: 'Galpão destinado a cargas pequenas')

    #act - visitar a tela inicial
    visit(root_path)
    click_on('Aeroporto RJ')
    click_on('Editar')

    # assert
  end
end