class Product < ApplicationRecord
  belongs_to :category
  before_create :code_generator
  validates :name, :weight, :height, :width, :depth, :description, presence: true

  def code_generator
    self.code = SecureRandom.alphanumeric(10)
  end
end
