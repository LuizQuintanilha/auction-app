class ProductBatch < ApplicationRecord
  belongs_to :created_by, class_name: 'Admin'
  belongs_to :approved_by, class_name: 'Admin', optional: true
  has_many :product_batch_items
  has_many :products, through: :product_batch_items
  has_many :bids, dependent: :destroy
  has_many :users, through: :bids
  has_many :questions
  has_many :answers, class_name: 'Answer'
  has_many :favorites, dependent: :destroy
  enum status: { wait_approve: 0, approve: 2 }
  enum expired: { wait_finish: 0, finished: 2 }

  validates :start_date, :deadline, :minimum_value, :minimal_difference, presence: true
  validates :code, format: { with: /\A[a-zA-Z]{3}[a-zA-Z0-9]{6}\z/ }, on: :create
  validates :code, uniqueness: true, if: -> { code.present? }
  before_save :remove_unchecked_products
  validate :created_by_different_from_approved_by
  validate :present_or_future?
  validate :date_validator

  def date_validator
    if start_date.present? && start_date < Date.current
      errors.add(:start_date, 'A data não pode ser inferior a data atual')
    end
    return unless deadline.present? && deadline < start_date

    errors.add(:deadline, 'A data inválida')
  end

  def waiting_finish?
    self.expired = 0
  end

  def close_batch!
    self.expired = 2
    save(validate: false)
  end

  def present_or_future?
    if start_date < Time.now
      'Lote em Andamento'
    elsif start_date > Time.current && deadline > Time.current
      'Lote Futuro'
    else
      deadline < Time.current
      'Lote Expirado'
    end
  end

  def bids
    Bid.where(product_batch_id: id)
  end

  def skip_date_validation?
    skip_date_validation || false
  end

  private

  def remove_unchecked_products
    product_ids.reject!(&:blank?)
  end

  def created_by_different_from_approved_by
    return unless created_by_id == approved_by_id

    errors.add(:approved_by_id, 'Não poder ser o mesmo admin.')
  end
end
