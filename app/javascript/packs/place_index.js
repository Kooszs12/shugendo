// タブ機能
// ページが読み込まれたときに現在のタブを復元
$(document).ready(function() {
  var activeTab = localStorage.getItem('activeTab');
  if (activeTab) {
    $('.js-tab-link').removeClass('active');
    $('.tab-pane').removeClass('show active');
    $('#' + activeTab).addClass('show active');
    $('a[href="#' + activeTab + '"]').addClass('active');
  }
});

// タブがクリックされたときにタブの状態を保存
$('.js-tab-link').click(function() {
  var tabId = $(this).attr('href').substr(1); // クリックされたタブのIDを取得
  localStorage.setItem('activeTab', tabId);
  const currentUrl = new URL(window.location);
  currentUrl.searchParams.set('page', 1);
  window.location.href = currentUrl.toString();
});