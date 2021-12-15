class CreatePostres < ActiveRecord::Migration[6.1]
  def change
    create_table :postres do |t|
      t.string :name
      t.string :price
      t.string :stock
      t.string :img
      t.string :url
      t.timestamps
      t.column :deleted_at, :datetime, :limit => 6
    end
  end
end
