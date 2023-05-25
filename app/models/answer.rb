class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :product_batch
  
  #validates :content, presence: true
  #validates :content, length: {minimum: 6}
end


