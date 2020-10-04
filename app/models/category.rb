class Category < ApplicationRecord
  has_many :transactions, dependent: :nullify

  def self.income
    find_by(name: 'Bevétel')
  end
end
