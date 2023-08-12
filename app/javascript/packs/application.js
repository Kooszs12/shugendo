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

// 日本地図の地方文字をクリックすると都道府県が表示される仕組み
// 選択された画像を即反映させる
// turbolinks:load イベントが発火したときに実行されるコード
$(document).on('turbolinks:load', () => {
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
    function prefReset(){ //まとめて消す為に変数として定義e
        $('[data-list]').hide();
        $('.pref_area').hide();
        $('.area_overlay').hide();
    }

  // 画像の選択フィールドの変更イベントが発生したときに実行されるコード
  $('#imageField').on('change', (e) => {
    // 選択されたファイルを取得
    var file = e.target.files[0];
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

// チェックボックスINセレクトボックス
jQuery(function(){
  jQuery('.checkbox-toggle').on('click', function(){
    jQuery('.checkboxes').slideToggle();
    // チェックボックスのスタイルにdisplay: flex;を付与する処理を追加
    jQuery('.checkboxes').css('display', 'flex');
  });
});
