require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) {FactoryBot.create(:user) }
  context '#balance' do
    it 'calculate correct balance for user' do
      inc_arr = Array.new(10) { "#{rand(999)}.#{rand(99)}".to_d }
      exp_arr = Array.new(10) { "#{rand(999)}.#{rand(99)}".to_d }
      inc_arr_sum = inc_arr.sum
      exp_arr_sum = exp_arr.sum
      inc_arr.each { |el|  FactoryBot.create(:income, user: user, amount: el) }
      exp_arr.each { |el|  FactoryBot.create(:expense, user: user, amount: el) }

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

  context '#monthly_income_sum' do
    it 'return correct monthly income for 20 Incomes with random time and random amount' do
      arr_now  = Array.new(20) { "#{rand(999)}.#{rand(99)}".to_d }

      arr_now.each do |amount|
        FactoryBot.create(
          :income,
          user:user,
          amount: amount,
          created_at: Faker::Time.between(Time.current.beginning_of_month, Time.current))
      end

      arr_now.each do |amount|
        FactoryBot.create(
          :income,
          user:user,
          amount: amount,
          created_at: Faker::Time.between(Time.current.months_ago(2), Time.current.beginning_of_month - 1))
      end

      expect(user.monthly_income_sum).to eq(arr_now.sum.to_d)
    end
    it 'return income in range from the beginning of the current month to the current time' do
      FactoryBot.create(:income, user:user, amount: 100)
      FactoryBot.create(:income, user:user, amount: 10, created_at:Time.current.months_ago(1))

      expect(user.monthly_income_sum).to eq 100
    end
  end

  context '#monthly_expense_sum' do
    it 'return correct monthly expense for 20 Expenses with random time and random amount' do
      arr_now  = Array.new(20) { "#{rand(999)}.#{rand(99)}".to_f }

      arr_now.each { |amount|
        FactoryBot.create(
          :expense,
          user:user,
          amount: amount,
          created_at: Faker::Time.between(Time.current.beginning_of_month, Time.current))
      }

      arr_now.each { |amount|
        FactoryBot.create(
          :expense,
          user:user,
          amount: amount,
          created_at: Faker::Time.between(Time.current.months_ago(1), Time.current.beginning_of_month - 1))
      }

      expect(user.monthly_expense_sum).to eq(arr_now.sum.to_d)
    end

    it 'return expense in range from the beginning of the current month to the current time ' do
      FactoryBot.create(:expense, user:user, amount: 100)
      FactoryBot.create(:expense, user:user, amount: 10, created_at:Time.current.months_ago(1))

      expect(user.monthly_expense_sum).to eq 100
    end
  end
end
