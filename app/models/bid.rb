class Bid < ApplicationRecord
  belongs_to :product_batch
  belongs_to :user
  validates :value, presence: true
  validate :validate_value?

  def validate_value?
    return false unless product_batch && value.present?
    max_bid = product_batch.bids.maximum(:value)
    if max_bid.nil? || value >= max_bid + product_batch.minimal_difference
      if persisted?
        Bid.create(value: value, product_batch: product_batch, user: user)
      else
        self.product_batch.bids.build(value: value, user: user)
      end
      true
    elsif value >= product_batch.minimum_value
      errors.add(:value, 'Valor do lance deve ser maior que o último lance.')
      false
    else
      errors.add(:value, 'Valor do lance insuficiente')
      false
    end
  end

end