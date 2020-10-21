class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :parent, class_name: 'Transaction', optional: true

  scope :income, -> { where('amount > 0') }
  scope :expenses, -> { where('amount < 0') }
  scope :ordered, -> { order(created_at: :desc) }
  scope :months_before, ->(offset) { where(created_at: month_range(offset)) }
  scope :this_month, -> { months_before(0) }
  scope :recurring, -> { where(recurring: true) }
  scope :recurred, -> { where.not(parent: nil) }

  validates :amount, presence: true

  before_create :set_sign
  after_destroy :stop_recurrence, if: :parent

  def self.recur_for(user)
    recurring.where(user: user).each do |transaction|
      original = transaction.created_at
      current = Time.current.change(
        day: [original.day, Time.current.end_of_month.day].min,
        hour: original.hour,
        min: original.min,
        sec: original.sec
      )
      transaction.dup.update(recurring: false, parent: transaction, created_at: current)
    end
  end

  def recurred?
    parent.present?
  end

  private

  def self.month_range(offset)
    (Time.current - offset.months).then { |timestamp| timestamp.beginning_of_month..timestamp.end_of_month }
  end

  def set_sign
    if category == Category.income && amount < 0 || category != Category.income && amount > 0
      self.amount = -amount
    end
  end

  def stop_recurrence
    parent.update(recurring: false)
  end
end
