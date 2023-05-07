class Product < ApplicationRecord
  enum status: { unavailable: 0, available: 2 }
  
  belongs_to :category
  has_many :product_batch_items
  #belongs_to :product_batch
  before_create :code_generator
  validates :name, :weight, :height, :width, :depth, :description, :photo, presence: true

  def code_generator
    self.code = SecureRandom.alphanumeric(10)
  end
end
