class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.date :date
      t.text :description
      t.float :value
      t.integer :user_id

      t.timestamps
    end
  end
end
