class ProductBatch < ApplicationRecord
  enum status: { wait_approve: 0, approve: 2}
  has_many :product_batch_items
  has_many :products, through: :product_batch_items
  validates :start_date, :deadline, :minimum_value, presence: true
  validates_format_of :code, with: /\A[a-zA-Z]{3}[a-zA-Z0-9]{6}\z/
  validates :code, uniqueness: true

  
  def date_validator
    if self.start_date.present? && self.start_date >= Date.today
      self.errors.add(:start_date,  "A data não pode ser inferior a data atual")
    end
  end

  def difference_validator(minimal_difference)
    minimal_difference = initial_batch - ultimate_batch
    if ultimate_batch < minimum_value
      product_batch.errors.add(:minimal_difference, "Valor de lance não pode ser inferior ao Lance Inicial do item.")
    end
  end
end
