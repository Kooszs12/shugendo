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

// 選択された画像を即反映させる
// turbolinks:load イベントが発火したときに実行されるコード
$(document).on('turbolinks:load', () => {
  // コンソールに 'hello' と出力する
  console.log('hello');
  // 画像の選択フィールドの変更イベントが発生したときに実行されるコード
  $('#imageField').on('change', (e) => {
    // 選択されたファイルを取得
    const file = e.target.files[0];
    // FileReader オブジェクトを生成
    var reader = new FileReader();
    // ファイルの読み込みが完了したときの処理
    reader.onload = (f) => {
      // 読み込んだデータをビューに表示するために、src 属性を設定
      $('#imagePreview').attr('src', f.target.result);
    }
    // 選択されたファイルをデータ URL として読み込む
    reader.readAsDataURL(file);
  });
});

//能動的なセレクトボックス
// turbolinks:load イベントが発火したときに実行されるコード
$(document).on('turbolinks:load', () => {
  // 地方選択セレクトボックスと都道府県選択セレクトボックスの要素を取得
  const areaSelect = document.getElementById('area-select');
  const prefectureSelect = document.getElementById('prefecture-select');
  // 都道府県データをJSON形式で持っている要素からデータを取得してパースする
  const prefecturesByArea = JSON.parse($(prefectureSelect).attr('data-json'));
  // 都道府県選択肢を更新する関数
  const updatePrefectureOptions = () => {
    // 選択されている地方を取得
    const selectedArea = areaSelect.value;
    // 選択された地方に属する都道府県をフィルタリング
    const prefectures = prefecturesByArea.filter((o) => o.area_id == selectedArea);
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

$(function(){
    //地域を選択
    $('.area_btn').click(function(){
        $('.area_overlay').show();
        $('.pref_area').show();
        var area = $(this).data('area');
        $('[data-list]').hide();
        $('[data-list="' + area + '"]').show();
    });

    //レイヤーをタップ
    $('.area_overlay').click(function(){
        prefReset();
    });

    //都道府県をクリック
    $('.pref_list [data-id]').click(function(){
        if($(this).data('id')){
            var id = $(this).data('id');
            //このidを使用して行いたい操作をしてください
            //都道府県IDに応じて別ページに飛ばしたい場合はこんな風に書く↓
            //window.location.href = 'https://kinocolog.com/pref/' + id;

            prefReset();
        }
    });

    //表示リセット
    function prefReset(){
        $('[data-list]').hide();
        $('.pref_area').hide();
        $('.area_overlay').hide();
    }
});