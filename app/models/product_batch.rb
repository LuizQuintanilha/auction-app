class ProductBatch < ApplicationRecord
  belongs_to :created_by, class_name: 'Admin', foreign_key: 'created_by_id'
  belongs_to :approved_by, class_name: 'Admin', foreign_key: 'approved_by_id', optional: true
  has_many :product_batch_items
  has_many :products, through: :product_batch_items
  has_many :bids, dependent: :destroy
  has_many :users, through: :bids
  
  enum status: { wait_approve: 0, approve: 2}
  enum expired: { wait_finish: 0, finished: 2 }

  validates :start_date, :deadline, :minimum_value, :minimal_difference, presence: true
  validates_format_of :code, with: /\A[a-zA-Z]{3}[a-zA-Z0-9]{6}\z/
  validates :code, uniqueness: true
  before_save :remove_unchecked_products
  validate :created_by_different_from_approved_by
  validate :present_or_future?
  validate :date_validator
  


  def date_validator
    if self.start_date.present? && self.start_date < Date.today
      self.errors.add(:start_date,  "A data não pode ser inferior a data atual")
    end
    if self.deadline.present? && self.deadline < self.start_date
      self.errors.add(:deadline, 'A data inválida')
    end
  end

  def present_or_future?
    if self.start_date.present? &&  self.start_time <= Time.current && self.deadline.present? && self.end_time > Time.current
      'Lote em Andamento'
    elsif self.start_date.present? && self.start_date >= Date.current &&  self.start_time > Time.current
      'Lote Futuro'
    else self.deadline.present? && self.deadline < Time.current && self.end_time < Time.current
      'Lote Expirado'
    end
  end

  def close_batch!
    self.expired = 2
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

end
