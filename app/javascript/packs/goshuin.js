$(document).ready(function() {
  //寺社選択でセレクトボックスの中身変更
  // デフォルトで表示されているセレクトボックスの表示を消す
  init();
  //$('#otera').hide();　//.hide();で表示されているセレクトボックスを消す
  // ラジオボタンをデフォルトでチェックされているようにする
   //'input[name="goshuin[category]"でラジオボタンを選択、[value="shrine"]デフォルトの値を持ってきて、.prop('checked', true)これでどんなことをさせるか決めた
  //$('input[name="goshuin[category]"][value="shrine"]').prop('checked', true);
  //$('#otera').show(); .show();次のセレクトボックスを表示させる
  // ラジオボタンの変更を監視
  $('input[type="radio"][name="goshuin[category]"]').change(function() {
    // 変数定義のようなもの
    var selectedValue = $(this).val();
    // ラジオボタンの選択に応じてセレクトボックスを更新
    // selectedValuehに入っているデータがshrine（カラム）と一緒なら
    if (selectedValue === 'shrine') { //ラジオボタンを神社選択した場合
      console.log('じんじゃ');
      // お寺セレクトボックスを消して
      $('#otera').hide(); // viewで設定したID
      // 神社のセレクトボックス表示
      $('#zinzya').show(); // viewで設定したID
      // 神社が選択された場合のセレクトボックスの更新
    } else if (selectedValue === 'temple') { //お寺を選択した場合
      console.log('お寺');
      // お寺セレクトボックスを表示
      $('#otera').show(); // viewで設定したID
      // 神社セレクトボックスを消す
      $('#zinzya').hide(); // viewで設定したID
    }
  });
  // 初期値
  function init(){
    // 変数定義のようなもの
    var shrine_checked = $('#goshuin_category_shrine').attr('checked');
    var temple_checked = $('#goshuin_category_temple').attr('checked');
    // ラジオボタンの選択に応じてセレクトボックスを更新
    // selectedValuehに入っているデータがshrine（カラム）と一緒なら
    if (shrine_checked === 'checked') { //ラジオボタンを神社選択した場合
      console.log('じんじゃ');
      // お寺セレクトボックスを消して
      $('#otera').hide(); // viewで設定したID
      // 神社のセレクトボックス表示
      $('#zinzya').show(); // viewで設定したID
      // 神社が選択された場合のセレクトボックスの更新
    } else if (temple_checked === 'checked') { //お寺を選択した場合
      console.log('お寺');
      // お寺セレクトボックスを表示
      $('#otera').show(); // viewで設定したID
      // 神社セレクトボックスを消す
      $('#zinzya').hide(); // viewで設定したID
    }
    }
  
});