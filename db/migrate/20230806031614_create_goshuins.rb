class CreateGoshuins < ActiveRecord::Migration[6.1]
  def change
    create_table :goshuins do |t|

      #referencesでFKが自動生成され
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.string :message
      t.integer :price, null: false
      t.date :visit_day

      t.timestamps
    end
  end
end
