//能動的なセレクトボックス
$(document).ready(function() {
  // 地方選択セレクトボックスと都道府県選択セレクトボックスの要素を取得
  var areaSelect = document.getElementById('area-select');
  var prefectureSelect = document.getElementById('prefecture-select');
  // 都道府県データをJSON形式で持っている要素からデータを取得してパースする
  var prefecturesByArea = JSON.parse($(prefectureSelect).attr('data-json'));
  // 都道府県選択肢を更新する関数
  var updatePrefectureOptions = () => {
    // 選択されている地方を取得
    var selectedArea = areaSelect.value;
    // 選択された地方に属する都道府県をフィルタリング
    var prefectures = prefecturesByArea.filter((o) => o.area_id == selectedArea);
    // 都道府県のセレクトボックスを初期化して、デフォルトの選択肢を追加
    prefectureSelect.innerHTML = '<option value="">都道府県を選択してください</option>';
    // 選択された地方に属する都道府県をセレクトボックスに追加
    prefectures.forEach(function(prefecture) {
      prefectureSelect.innerHTML += `<option value="${prefecture.id}">${prefecture.name}</option>`;
    });
  }

  // 地方選択セレクトボックスの値が変更されたときに都道府県選択肢を更新する
  areaSelect.addEventListener('change', function() {
    updatePrefectureOptions();
  });
});
