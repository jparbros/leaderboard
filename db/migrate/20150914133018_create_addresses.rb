class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :address_2
      t.string :country_code
      t.string :region_code
      t.string :city
      t.string :zip_code
      t.integer :organization_id

      t.timestamps null: false
    end
  end
end
