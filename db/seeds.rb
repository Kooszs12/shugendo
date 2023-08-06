# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#二回目rails db:seedするときは、元々登録してた記述をコメントアウトする
#Admin.create!(
  #email: 'niryuhogo@mbox.re',
  #password: '202306'
#)

#地方と都道府県の配列
area_prefectures = [
  ["北海道地方", ["北海道"]],
  ["東北地方", ["青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県"]],
  ["関東信越地方", ["茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "山梨県", "長野県"]],
  ["北陸東海地方", ["富山県", "石川県", "福井県", "岐阜県", "静岡県", "愛知県", "三重県"]],
  ["近畿地方", ["滋賀県", "京都府", "大阪府", "兵庫県", "奈良県"]],
  ["中国地方", ["和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県"]],
  ["四国地方", ["徳島県", "香川県", "愛媛県", "高知県"]],
  ["九州地方", ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県"]],
  ["沖縄地方", ["沖縄県"]]
]

#h配列からデータ取得、地方と都道府県のペア組んで保存
area_prefectures.each do |area_prefecture|
  # area_prefecture配列から地方名と都道府県名のペアを取得
  area_name = area_prefecture[0]
  # 地方レコードを作成し、データベースに保存する
  area = Area.create!(name: area_name)
  # 都道府県名の配列を取得
  prefecture_names = area_prefecture[1]
  # 各都道府県名を処理
  prefecture_names.each do |prefecture_name|
    # 都道府県レコードを作成し、対応する地方に紐付けてデータベースに保存する
    area.prefectures.create!(name: prefecture_name)
  end
end