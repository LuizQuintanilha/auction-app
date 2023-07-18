class Bid < ApplicationRecord
  belongs_to :product_batch
  belongs_to :user
  validates :value, presence: true
  validate :validate_value?

  def validate_value?
    return false unless product_batch && value.present?

    max_bid = product_batch.bids.last&.value || product_batch.minimum_value
    if product_batch.bids.empty?
      if value >= product_batch.minimum_value
        create_bid
        true
      else
        false
      end
    elsif product_batch.bids.length >= 1 && value >= max_bid + product_batch.minimal_difference
      create_bid
      true
    else
      false
    end
  end

  def create_bid
    product_batch.bids.build(value: value, user: user)
  end
end
