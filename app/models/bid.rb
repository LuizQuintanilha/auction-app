class Bid < ApplicationRecord
  belongs_to :product_batch
  belongs_to :user
  validates :value, presence: true, numericality: { greater_than: 0 }
  validate :validate_value

  private

  def validate_value
    highest_bid = @product_batch.bids.maximum(:value) || @product_batch.minimum_value
    minimum_difference = @product_batch.minimal_difference

    if value > highest_bid + minimal_difference
      @current_value = current_value
    elsif value < @product_batch.minimum_value
      errors.add(:value, 'Bid insufficient')
    end
  end
end
