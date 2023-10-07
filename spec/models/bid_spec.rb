require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'Authenticated user do a bid' do
    context '#invalid' do
      it 'when the first bid is iqual than the minimum value' do
        user_luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
        luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
        luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
        lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                    minimum_value: 600, minimal_difference: 80)
        lote.approve!
        lance = Bid.new(value: '600', user_id: 2, product_batch_id: 1)

        result = lance.valid?

        expect(result).to eq false
      end
      it 'when the first bid is less than the minimum value' do
        user_luiz = User.create!(email: 'luiz@email.com', password: '123456', cpf: '12662381744')
        luana = Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '13008409784')
        luiz = Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '12661055142')
        lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                    minimum_value: 600, minimal_difference: 80)
        lote.approve!
        lance = Bid.new(value: '580', user_id: 2, product_batch_id: 1)

        result = lance.valid?

        expect(result).to eq false
      end
      it 'when the bid after the first bid has not the minimal difference include' do
        lu = User.create!(email: 'luaba@email.com', password: '123456', cpf: '35614708820')
        User.create!(email: 'luiz@email.com', password: '123456', cpf: '01650085206')
        Admin.create!(email: 'luana@leilaodogalpao.com.br', password: '123456', cpf: '73429012961')
        Admin.create!(email: 'luiz@leilaodogalpao.com.br', password: '123456', cpf: '78116642839')
        lote = ProductBatch.create!(admin_id: 1, created_by_id: 1, approved_by_id: 2, code: 'ACB112233', start_date: Date.today, deadline: 5.days.from_now,
                                    minimum_value: 600, minimal_difference: 80)
        lote.approve!
        Bid.create!(value: '610', user: lu, product_batch: lote)
        lance = Bid.new(value: '650', user_id: 2, product_batch_id: lote)
        result = lance.valid?

        expect(result).to eq false
      end
    end
  end
end
