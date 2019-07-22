require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) {FactoryBot.create(:user) }
  context '#balance' do
     it 'calculate correct balance for user' do
      inc_arr = Array.new(10) { Faker::Commerce.price }
      exp_arr = Array.new(10) { Faker::Commerce.price }
      inc_arr_sum = inc_arr.sum
      exp_arr_sum = exp_arr.sum
      inc_arr.each do |el|
        FactoryBot.create(:income, user: user, amount: el)
      end
      exp_arr.each do |el|
        FactoryBot.create(:expense, user: user, amount: el)
      end

      expect(user.balance).to eq(inc_arr_sum - exp_arr_sum)
    end

    it 'calculate correct balance only for selected user' do
      #user
      FactoryBot.create(:income, user: user, amount: 1000)
      FactoryBot.create(:expense, user: user, amount: 900)
      #user2
      FactoryBot.create(:income, user: user2, amount: 55.22)
      FactoryBot.create(:expense, user: user2, amount: 5.22)

      expect(user.balance).to eq(100)
      expect(user2.balance).to eq(50)
    end

    it 'calculate negative balance' do
      FactoryBot.create(:expense, user: user, amount: 10.2)

      expect(user.balance).to eq(-10.2)
    end

  end
end
