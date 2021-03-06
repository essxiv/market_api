class Order < ActiveRecord::Base
  belongs_to :user

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates_with EnoughProductsValidator

  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = 0 
    placements.each do |p|
        self.total += p.product.price * p.quantity
    end
  end

  def order_params
    params.require(:order).premit(:product_ids => [])
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity # [1,5]

      self.placements.build(product_id: id, quantity: quantity)
    end
  end
end
