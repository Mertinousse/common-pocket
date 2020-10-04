class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  scope :income, -> { where('amount > 0') }
  scope :expenses, -> { where('amount < 0') }
  scope :ordered, -> { order(created_at: :desc) }
  scope :this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }

  before_create :set_sign

  private

  def set_sign
    if category == Category.income && amount < 0 || category != Category.income && amount > 0
      self.amount = -amount
    end
  end
end
