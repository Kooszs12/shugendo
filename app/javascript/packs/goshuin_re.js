// 御朱印新規投稿
$(document).ready(function() {
  //寺社選択でセレクトボックスの中身変更
  // デフォルトで表示されているセレクトボックスの表示を消す
  $('#otera').hide();　//.hide();で表示されているセレクトボックスを消す
  // ラジオボタンをデフォルトでチェックされているようにする
   //'input[name="goshuin[category]"でラジオボタンを選択、[value="shrine"]デフォルトの値を持ってきて、.prop('checked', true)これでどんなことをさせるか決めた
  $('input[name="goshuin[category]"][value="shrine"]').prop('checked', true);
  //$('#otera').show(); .show();次のセレクトボックスを表示させる
  // ラジオボタンの変更を監視
  $('input[type="radio"][name="goshuin[category]"]').change(function() {
    // 変数定義のようなもの
    var selectedValue = $(this).val();
    // ラジオボタンの選択に応じてセレクトボックスを更新
    // selectedValuehに入っているデータがshrine（カラム）と一緒なら
    if (selectedValue === 'shrine') { //ラジオボタンを神社選択した場合
      // console.log('じんじゃ');
      // お寺セレクトボックスを消して
      $('#otera').hide(); // viewで設定したID
      // 神社のセレクトボックス表示
      $('#zinzya').show(); // viewで設定したID
      // 神社が選択された場合のセレクトボックスの更新
    } else if (selectedValue === 'temple') { //お寺を選択した場合
      // console.log('お寺');
      // お寺セレクトボックスを表示
      $('#otera').show(); // viewで設定したID
      // 神社セレクトボックスを消す
      $('#zinzya').hide(); // viewで設定したID
    }
    searchPlaces(); // セレクトボックスが変更取れたら「都道府県検索のAjax通信」呼び出し
  });

  $('#prefectures_prefectures').change(function () {
    searchPlaces(); // 都道府県が変更されたら「都道府県検索のAjax通信」呼び出し
  });
});

// 都道府県検索のAjax通信
function searchPlaces() {
  var cat = $('input:radio[name="goshuin[category]"]:checked').val(); // 神社かお寺かの選択肢
  var pref = $('#prefectures_prefectures').val(); // 都道府県の選択肢

  $.ajax('/places_json', // places_jsonにリクエスト
          {
            type: 'get', // getメソッド
            data: { cat: cat, pref: pref }, // GETパラメーターを付与
            dataType: 'json' // データタイプはjson
          }
        )
        .done(function(data) { // 成功した時
          var elem = cat === 'shrine' ? $('#goshuin_place_id') : $('#place_id2') // カテゴリが神社かお寺でエレメントの指定を変える
          elem.empty(); // エレメントを空にする

          // 初期値
          if (data.length === 0) {
            elem.append(`<option value>お手数ですが寺社投稿お願いします</option>`); // 神社・お寺が0件の場合
          } else {
            elem.append(`<option value>選択してください</option>`); // 神社・お寺が0件でない場合
          }

          // ループで、セレクトボックスにappend(追加)
          data.forEach(function (d) {
            elem.append(`<option value="${d.id}">${d.name}</option>`);
          })
        })
        .fail(function() { // 失敗した時
          window.alert('正しい結果を得られませんでした。');
        });
}