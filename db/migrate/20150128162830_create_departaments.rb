class CreateDepartaments < ActiveRecord::Migration
  def change
    create_table :departaments do |t|
      t.string :name
      t.integer :organization_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
