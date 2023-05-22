class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  
  validates :content, presence: true
  validates :content, length: {minimum: 6}
end
