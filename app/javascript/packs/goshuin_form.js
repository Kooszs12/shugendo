/*global $*/
$(document).on('turbolinks:load', (e) => {
  var category = "shrine"
  const placesData = () => {
    return $('#placeSelectForm').data('json')
  }

  const replacePlaces = (result) => {
    const target = $('#placeSelectForm')
    target.empty()
    if (result.length >= 1) {
      target.append('<option value>選択してください</option>')
    } else {
      target.append('<option value>該当するものがありません</option>')
    }

    result.forEach((o) => {
      target.append(`
        <option value=${o.id}>${o.name}</option>
      `)
    })
  }
  
  const replacePrefectures = () => {
    const target = $('#prefectureSelectForm')
    const result = target.data('json')
    console.log(result)
    target.empty()
    target.append('<option value>都道府県を選択してください</option>')
    result.forEach((o) => {
      target.append(`
        <option value=${o.id}>${o.name}</option>
      `)
    })
  }

  $('#categoryCheckBoxes').on('change', (e) => {
    const places = placesData();
    const target = e.target
    category = target.value
    const result = places[category]
    replacePlaces(result);
    replacePrefectures();
  })

  $('#prefectureSelectForm').on('change', (e) => {
    const target = e.target
    const prefecture_id = target.value
    const places = placesData();
    const result = places[category].filter( o => o.prefecture_id == prefecture_id )
    replacePlaces (result);
  })
})