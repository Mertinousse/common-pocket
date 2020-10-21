class AddRecurringToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :recurring, :boolean, default: false
    add_reference :transactions, :parent, index: true
  end
end
