class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      # 通報内容
      t.string :reason
      # 対応状況
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
