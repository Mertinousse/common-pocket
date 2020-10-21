class User < ApplicationRecord
  has_many :transactions

  validates :name, presence: true, uniqueness: true

  def recurrence_pending?
    transactions.recurring.where.not(id: transactions.this_month).exists? && !transactions.this_month.recurred.exists?
  end
end
