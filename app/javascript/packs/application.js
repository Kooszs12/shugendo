// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// ブートストラップ
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on('turbolinks:load', () => {
  console.log('hello')
  $('#imageField').on('change', (e) => {
    const file = e.target.files[0];
    var reader = new FileReader();
    reader.onload = (f) => {
      $('#imagePreview').attr('src', f.target.result);
    }
    reader.readAsDataURL(file)
  })
})

//能動的なセレクトボックス
$(document).on('turbolinks:load', () => {
  const areaSelect = document.getElementById('area-select');
  const prefectureSelect = document.getElementById('prefecture-select');
  console.log($(prefectureSelect).attr('data-json'))
  const prefecturesByArea = JSON.parse($(prefectureSelect).attr('data-json'));

  const updatePrefectureOptions = () => {
    const selectedArea = areaSelect.value;
    const prefectures = prefecturesByArea.filter((o)=> o.area_id == selectedArea);

    // 都道府県のセレクトボックスを更新します
    prefectureSelect.innerHTML = '<option value="">都道府県を選択してください</option>';
    prefectures.forEach(function(prefecture) {
      prefectureSelect.innerHTML += `<option value="${prefecture.id}">${prefecture.name}</option>`;
    });
  }

  // 地方が変更されたときに都道府県のセレクトボックスを更新します
  areaSelect.addEventListener('change', function() {
    updatePrefectureOptions();
  });
})