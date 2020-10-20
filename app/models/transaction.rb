class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  scope :income, -> { where('amount > 0') }
  scope :expenses, -> { where('amount < 0') }
  scope :ordered, -> { order(created_at: :desc) }
  scope :months_before, ->(offset) { where(created_at: month_range(offset)) }
  scope :recurring, -> { where(recurring: true) }

  validates :amount, presence: true

  before_create :set_sign

  private

  def self.month_range(offset)
    (Time.current - offset.months).then { |timestamp| timestamp.beginning_of_month..timestamp.end_of_month }
  end

  def set_sign
    if category == Category.income && amount < 0 || category != Category.income && amount > 0
      self.amount = -amount
    end
  end
end
