class ProductBatch < ApplicationRecord
  belongs_to :created_by, class_name: 'Admin', foreign_key: 'created_by_id'
  belongs_to :approved_by, class_name: 'Admin', foreign_key: 'approved_by_id', optional: true
  enum status: { wait_approve: 0, approve: 2}
  has_many :product_batch_items
  has_many :products, through: :product_batch_items
  validates :start_date, :deadline, :minimum_value, presence: true
  validates_format_of :code, with: /\A[a-zA-Z]{3}[a-zA-Z0-9]{6}\z/
  validates :code, uniqueness: true
  before_save :remove_unchecked_products
  validate :created_by_different_from_approved_by


  def date_validator
    if self.start_date.present? && self.start_date >= Date.today
      self.errors.add(:start_date,  "A data não pode ser inferior a data atual")
    end
  end

  private

  def remove_unchecked_products
    self.product_ids.reject!(&:blank?)
  end

  def created_by_different_from_approved_by
    if created_by_id == approved_by_id
      errors.add(:approved_by_id, "Não poder ser o mesmo admin.")
    end
  end

  def difference_validator(minimal_difference)
    minimal_difference = initial_batch - ultimate_batch
    if ultimate_batch < minimum_value
      product_batch.errors.add(:minimal_difference, "Valor de lance não pode ser inferior ao Lance Inicial do item.")
    end
  end
end
