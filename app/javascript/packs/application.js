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

$(document).on('turbolinks:load', function() {
  // 画像アップロードフィールドの変更イベントが発生したときの処理
  $('#imageField').on('change', (e) => {
    // 選択されたファイルを取得
    var file = e.target.files[0];
    // FileReaderオブジェクトを作成
    var reader = new FileReader();
    // 読み込み完了時の処理
    reader.onload = (f) => {
      // プレビュー画像のsrc属性を選択した画像ファイルのDataURLに設定
      $('#imagePreview').attr('src', f.target.result);
    }
    // 画像ファイルをDataURL形式で読み込む
    reader.readAsDataURL(file);
  });

  $('.hum-menu, .sp-menu').click(function () {
    $('.sp-menu').toggleClass('d-none');
  })

});