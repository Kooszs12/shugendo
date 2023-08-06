// 地方セレクトボックスを指定したら都道府県セレクトボックスの中身が変わる

// app/assets/javascripts/custom.js

document.addEventListener('DOMContentLoaded', function() {
  const areaSelect = document.getElementById('area-select');
  const prefectureSelect = document.getElementById('prefecture-select');
  const prefecturesByArea = JSON.parse('<%= raw @prefectures_by_area.to_json %>');

  function updatePrefectureOptions() {
    const selectedArea = areaSelect.value;
    const prefectures = prefecturesByArea[selectedArea];

    // 都道府県のセレクトボックスを更新します
    prefectureSelect.innerHTML = '<option value="">都道府県を選択してください</option>';
    prefectures.forEach(function(prefecture) {
      prefectureSelect.innerHTML += `<option value="${prefecture.id}">${prefecture.name}</option>`;
    });
  }

  // 初期状態で都道府県のセレクトボックスを更新します
  updatePrefectureOptions();

  // 地方が変更されたときに都道府県のセレクトボックスを更新します
  areaSelect.addEventListener('change', function() {
    updatePrefectureOptions();
  });
});
