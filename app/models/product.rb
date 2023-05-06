class Product < ApplicationRecord
  belongs_to :category
  #belongs_to :product_batch
  before_create :code_generator
  validates :name, :weight, :height, :width, :depth, :description, :photo, presence: true

  def code_generator
    self.code = SecureRandom.alphanumeric(10)
  end
end
