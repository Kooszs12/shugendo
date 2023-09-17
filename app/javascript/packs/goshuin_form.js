/* 御朱印投稿、編集（ラジオボタン＆セレクトボックスの能動的セレクトボックス） */
$(document).on('turbolinks:load', (e) => {

  // チェックボックスの初期値を取得
  const category_checkbox = $('input[name="goshuin[category]"]');
  if (category_checkbox.val() === '') {
    var category = 'shrine'; // 初期値がない場合、神社
  } else {
    var category = category_checkbox.val(); // 初期値がある場合は、選択されたものの値を優先
  }

  // #placeSelectFormのフォームに付属しているdata-jsonというラベルのデータをplaceDataに保存
  const placesData = () => {
    return $('#placeSelectForm').data('json') // データを取り出して返す(return)
  }

  // 寺社名のフォームの中身を変更する
  const replacePlaces = (result) => {
    const target = $('#placeSelectForm') // セレクタ(※)
    target.empty() // 一旦消去する
    if (result.length >= 1) {
      // 寺社名が1件以上あれば…
      target.append('<option value>選択してください</option>')
    } else {
      // 寺社名何もなければ…
      target.append('<option value>該当するものがありません</option>')
    }

    // 寺社名をセレクタ(※)に追加する
    result.forEach((o) => {
      target.append(`
        <option value=${o.id}>${o.name}</option>
      `)
    })
  }

  // 都道府県選択フォーム
  const replacePrefectures = () => {
    const target = $('#prefectureSelectForm')
    const result = target.data('json') // #prefectureSelectFormについているdata-jsonを取得
    // console.log(result)
    target.empty() // 一旦消去する
    target.append('<option value>都道府県を選択してください</option>') // 都道府県の初期値
    result.forEach((o) => { // 都道府県をフォームに展開
      target.append(`
        <option value=${o.id}>${o.name}</option>
      `)
    })
  }

  // $('#categoryCheckBoxes').trigger('change');

  $('#categoryCheckBoxes').on('change', (e) => {
    // 都道府県リセット
    const prefSF = $('#prefectureSelectForm')
    prefSF.empty() // 一旦消去する
    prefSF.append('<option value>選択してください</option>') // 初期値

    // 神社・お寺リセット
    const pSF = $('#placeSelectForm')
    pSF.empty()  // 一旦消去する
    pSF.append('<option value>選択してください</option>') // 初期値

    // if (prefSF.val() != '') {
      const places = placesData(); // 寺社名を変数に格納
      const target = e.target // 自分自身の状態を変数に格納
      category = target.value // カテゴリーにお寺または神社を格納

      // console.log($('input[name="goshuin[category]"]').val());
      const result = places[category] // カテゴリーに属すplacesをresultに格納
      replacePlaces(result); // 寺社名のフォームの中身を変更する
      replacePrefectures(); // 都道府県のフォーム生成
    // }
  })

  // 都道府県が変更された場合
  $('#prefectureSelectForm').on('change', (e) => {
    const target = e.target // 自分自身の情報を取得
    const prefecture_id = target.value // 都道府県IDを取得
    const places = placesData(); // 寺社名を変数に格納
    const result = places[category].filter( o => o.prefecture_id == prefecture_id ) // 神社・お寺一覧に都道府県フィルターをかけてresultに入れる
    replacePlaces (result); // 寺社名一覧を置き換え
  })
})