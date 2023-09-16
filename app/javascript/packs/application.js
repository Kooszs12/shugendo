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

import "./a_side"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on('turbolinks:load', function() {
  // 対象を指定して（セレクター)、イベントを設定
  // var scrollTopButton = document.getElementById('js-scroll-top');
  $('#js-scroll-top').click(function(e){
    // メソッド定義（functionはdefみたいなもの）
    function scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth' // スムーススクロールを有効にする
      });
    }
    // メソッド名を記述して実行（）
    scrollToTop();
  });

  // 画像アップロードフィールドの変更イベントが発生したときの処理
  $('#imageField').on('change', (e) => {
    // 選択されたファイルを取得
    var file = e.target.files[0];
    // FileReaderオブジェクトを作成
    var reader = new FileReader();
    // 読み込み完了時の処理
    reader.onload = (f) => {
      // プレビュー画像のsrc属性を選択した画像ファイルのDataURLに設定
       $('#imagePreview').attr('src', f.target.result)
      // .addClass('profile-img');
    }
    // 画像ファイルをDataURL形式で読み込む
    reader.readAsDataURL(file);
  });

  $('.hum-menu, .sp-menu').click(function () {
    $('.sp-menu').toggleClass('d-none');
  })

});
