class Question < ApplicationRecord
  belongs_to :user
  belongs_to :product_batch
  has_many :answers, through: :product_batch

  validates :content, presence: true
  validates :content, length: {minimum: 10}
  enum hidden: {hide: false, visible: true}

  def hide
    update(hidden: true)
  end

end