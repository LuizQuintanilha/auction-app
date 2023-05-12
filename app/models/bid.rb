class Bid < ApplicationRecord
  belongs_to :product_batch
  belongs_to :user
  validates :value, presence: true, numericality: { greater_than: 0}
  validate :validate_value?

  def validate_value?(last_bid)
    bids = [product_batch.minimum_value, last_bid].max

    if value.present? && value >= product_batch.minimum_value + bids + product_batch.minimal_difference
      return true
    else
      errors.add(:value, 'Valor do lance insuficiente')
      return false
    end
  end
end