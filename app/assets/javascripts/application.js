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

/* 会員一覧無限スクロール */
/* global $ */
$(window).on('scroll', function() {
  var scrollHeight = $(document).height();
  var scrollPosition = $(window).height() + $(window).scrollTop();
  if (document.URL.match("customers/men") || document.URL.match("customers/women")) {
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
      $('.jscroll').jscroll({
        loadingHtml: '<i class="fa fa-spinner fa-pulse"></i>',
        contentSelector: '.scroll-list',
        nextSelector: 'span.next:last a'
      });
    }
  }
});

/* コミュニティ詳細無限スクロール */
$(window).on('scroll', function() {
  var scrollHeight = $(document).height();
  var scrollPosition = $(window).height() + $(window).scrollTop();
  if (document.URL.match(/communities\/+\d/)) {
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.1) {
      $('.jscroll').jscroll({
        loadingHtml: '<i class="fa fa-spinner fa-pulse"></i>',
        contentSelector: '.scroll-list',
        nextSelector: 'span.next:last a'
      });
    }
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