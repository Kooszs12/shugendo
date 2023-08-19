class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

       #referencesでFKが自動生成され
      # Userとのアソシエーション
      t.references :user, null: false, foreign_key: true
      # Placeとのアソシエーション
      t.references :goshuin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
