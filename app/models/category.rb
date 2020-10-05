class Category < ApplicationRecord
  has_many :transactions, dependent: :nullify

  scope :expenses, -> { where.not(name: 'Bevétel') }

  def self.income
    find_by(name: 'Bevétel')
  end
end
