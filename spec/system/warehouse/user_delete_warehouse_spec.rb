require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Praça Sen. Salgado Filho', cep: '20021340',
      description: 'Galpão destinado a cargas pequenas')

    visit(root_path)
    click_on('Aeroporto RJ')
    click_on('Excluir')

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão excluído com sucesso'
    expect(page).not_to have_content 'Aeroporto RJ'
  end

  it 'e não apaga outros galpões' do
    first_warehouse = Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Praça Sen. Salgado Filho', cep: '20021340',
      description: 'Galpao do RJ')
    second_warehouse = Warehouse.create!(name: 'Niteroi', code: 'NIT', city: 'Niteroi', area: 60_000,
      address: 'Niteroi', cep: '20021000',
      description: 'Galpa de Niteroi')

    visit(root_path)
    click_on('Aeroporto RJ')
    click_on('Excluir')

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão excluído com sucesso'
    expect(page).to have_content 'Niteroi'
    expect(page).not_to have_content 'Aeroporto RJ'
  end
end