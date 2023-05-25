  class Question < ApplicationRecord
    belongs_to :user
    belongs_to :product_batch
    has_one :answer, through: :product_batch

    validates :content, presence: true
    validates :content, length: {minimum: 10}
    enum hidden_status: {hide: false, visible: true}

    def mark_as_hidden
      update(hidden_status: :hide)
    end

  end