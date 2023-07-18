class Question < ApplicationRecord
  belongs_to :user
  belongs_to :product_batch
  has_one :answer, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { minimum: 10 }

  def hidden
    update(hidden: :true)
  end
end
