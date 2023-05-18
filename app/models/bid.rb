class Bid < ApplicationRecord
  belongs_to :product_batch
  belongs_to :user
  validates :value, presence: true
  validate :validate_value?

  def validate_value?
    return false unless product_batch && value.present?
    max_bid = product_batch.bids.last&.value || product_batch.minimum_value
    if max_bid.nil?
      if value > product_batch.minimum_value
        create_bid
        true
      else
        errors.add(:value, 'Valor do lance deve ser maior que valor inicial.')
        false
      end
    elsif max_bid.nil? || value >= max_bid + product_batch.minimal_difference
      create_bid
      true
    else
      errors.add(:value, 'Valor do lance deve ser maior que o último lance.')
      false
    end
  end

  def create_bid
    if persisted?
      Bid.create(value: value, product_batch: product_batch, user: user)
    else
      self.product_batch.bids.build(value: value, user: user)
    end
  end
end
