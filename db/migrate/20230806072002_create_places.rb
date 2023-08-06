class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|

      t.references :area, null: false, foreign_key: true
      t.integer :user_id #拡張性を考慮
      t.integer :admin_id #拡張性を考慮
      t.integer :type, null: false # enum
      t.string :name, null: false
      t.string :address, null: false
      t.string :postcode
      t.string :phone_number
      t.string :got
      t.string :sect
      t.integer :goshuin_status, null: false
      t.integer :pet_status, null: false

      t.timestamps
    end
  end
end
