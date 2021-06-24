// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require chartkick
//= require Chart.bundle

/* フォームバリデーション */
(function() {
  window.addEventListener('turbolinks:load', function() {
    var forms = document.getElementsByClassName('needs-validation');
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();

/* 無限スクロール */
/* global $ */
$(window).on('scroll', function() {
  var scrollHeight = $(document).height();
  var scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.5) {
    $('.jscroll').jscroll({
      loadingHtml: '<i class="fa fa-spinner fa-pulse"></i>',
      contentSelector: '.scroll-list',
      nextSelector: 'span.next:last a'
    });
  }
});

/* チャット時のみスクロール最下部で表示 */
$(document).on('turbolinks:load',function scrollToEnd() {
  if(document.URL.match(/chat\/+\d/)){
    var messagesArea = document.getElementById('scroll-inner');
    messagesArea.scrollTop = messagesArea.scrollHeight;
  }
});

function clickRemoveAlert() {
  $('.js-message-errors').empty();
}

/* トップページ横スクロール */
$(function(){
  $('.slide').slick({
    autoplay: true, //自動でスクロール
    autoplaySpeed: 0, //自動再生のスライド切り替えまでの時間を設定
    speed: 4500, //スライドが流れる速度を設定
    cssEase: "linear", //スライドの流れ方を等速に設定
    slidesToShow: 5, //表示するスライドの数
    swipe: false, // 操作による切り替えはさせない
    arrows: false, //矢印非表示
    pauseOnFocus: false, //スライダーをフォーカスした時にスライドを停止させるか
    pauseOnHover: false, //スライダーにマウスホバーした時にスライドを停止させるか
    responsive: [
      {
        breakpoint: 750,
        settings: {
          slidesToShow: 5, //画面幅750px以下でスライド5枚表示
        }
      }
    ]
  });
});

/* コミュニティ一覧（Masonry） */
$(document).on('turbolinks:load',function () {
  var $demo1 = $('.js-masonry');   //コンテナとなる要素を指定
  $demo1.imagesLoaded(function(){ //imagesLoadedを使用し、画像が読み込みまれた段階でMasonryの関数を実行させる
    //Masonryの関数↓
    $demo1.masonry({              //オプション指定箇所
      itemSelector: '.js-item',   //コンテンツを指定
      columnWidth: 1,           //カラム幅を設定
      fitWidth: true,             //コンテンツ数に合わせ親の幅を自動調整
    });
  });
});