// 日本地図の地方文字をクリックすると都道府県が表示される仕組み
// 選択された画像を即反映させる
// turbolinks:load イベントが発火したときに実行されるコード
$(document).on('turbolinks:load', function() {
  $('.area_btn').click(function(e){
    $('.area_overlay').show();
    $('.pref_area').show();
    var area = $(this).data('area');
    $('[data-list]').hide();
    $('[data-list="' + area + '"]').show();
  });

  $('.area_overlay').click(function(){
    prefReset();
  });

  $('.pref_list [data-id]').click(function(){
    if ($(this).data('id')) {
      var id = $(this).data('id');
      // このidを使用して行いたい操作をしてください
      // 都道府県IDに応じて別ページに飛ばしたい場合はこんな風に書く↓
      // window.location.href = 'https://kinocolog.com/pref/' + id;

      //prefReset();
    }
  });

// 表示リセット
  function prefReset(){
    $('[data-list]').hide();
    $('.pref_area').hide();
    $('.area_overlay').hide();
  }

// セレクトボックスの中にチェックボックス
  // クリックしたら発火
  $('.checkbox-toggle').click(function () {
    const targetName = $(this).attr('id')
    if ($(`#${targetName}Checkboxes`).is(':hidden')) {
      $(`#${targetName}Checkboxes`).slideDown();
    } else {
      $(`#${targetName}Checkboxes`).slideUp();
    }

    // $(`#${targetName}Checkboxes`).css('display', 'flex');
  });
});
