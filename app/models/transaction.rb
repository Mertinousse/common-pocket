class Transaction < ApplicationRecord
  belongs_to :user

  scope :income, -> { where('amount > 0') }
  scope :expense, -> { where('amount < 0') }
end
