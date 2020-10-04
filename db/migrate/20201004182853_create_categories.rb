class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :key
      t.timestamps
    end

    add_reference :transactions, :category, foreign_key: true
  end
end
