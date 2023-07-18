require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Admim answer a question' do
    it 'and the answer has less than six letters' do
      user_luana = User.create!(email: 'luaba@email.com', password: '123456', cpf: '35614708820')
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '73429012961')
      lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                  minimum_value: 600, minimal_difference: 80, start_time: Time.current, end_time: 1.hour.from_now)

      answer = Answer.new(user_id: 1, product_batch_id: 1, question_id: 1, content: 'Sim')
      result = answer.valid?

      expect(result).to eq false
    end
    it 'and the answer is empty' do
      user_luana = User.create!(email: 'luaba@email.com', password: '123456', cpf: '35614708820')
      luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '73429012961')
      lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                  minimum_value: 600, minimal_difference: 80, start_time: Time.current, end_time: 1.hour.from_now)

      answer = Answer.new(user_id: 1, product_batch_id: 1, question_id: 1, content: '')
      result = answer.valid?

      expect(result).to eq false
    end
  end
end
