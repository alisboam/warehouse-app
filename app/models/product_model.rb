class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :supplier_id, :weight, :width, :height, :depth, :sku, presence: true
  validates :weight, :width, :height, :depth, numericality: { only_integer: true }
  validates :weight, :width, :height, :depth, comparison: { greater_than: 0 }
  validates :sku, length: { is: 20 }
  validates :sku, uniqueness: true
end
