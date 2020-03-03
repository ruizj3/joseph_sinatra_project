class CreateMeds < ActiveRecord::Migration[6.0]
  def change
    create_table :meds do |t|
      t.text :name
      t.integer :price
      t.integer :num_pills
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
