var LIGHTBOX = LIGHTBOX || {}

LIGHTBOX.Main = (function() {
  var _$lightbox;
  var _$contents;
  var _$frame;
  var _isHovering;

  function init(contents) {
    _isHovering = false;
    _$contents = contents;
    _setUpContents();
    _voila();
    _setUpClose();

  }

  function _setUpContents() {
    var promise = $('body').append(_$contents).promise();
    promise.done(function() {
      _setUpFrame();
    });
  }

  function _setUpClose() {
    $('.close-toggle').on('click', function() {
      $('#lightbox').remove();
    });
    $('#lightbox .frame').on('mouseenter', function() {
      isHovering = true;
    }).on('mouseleave', function() {
      isHovering = false;
    });
    $('#lightbox').on('click', function() {
      if (!isHovering) {
        $('#lightbox').remove();
      }
    })

  }

  function _voila() {
    $('#lightbox .contents, #lightbox .frame').css({
      visibility: 'visible'
    })
  }


  function _setUpFrame() {
    var windowHeight = $(window).height();
    var windowWidth = $(window).width();
    var contentWidth = _$contents.width() > 800 ? 800 : _$contents.width();
    var contentHeight = $('#lightbox .frame').height();
    console.log(windowHeight, windowWidth, contentWidth, contentHeight);

    $('#lightbox .frame').css({
      top: (windowHeight - contentHeight) / 2 + 'px',
      left: (windowWidth - contentWidth) / 2 + 'px',
    });

  }


  return {
    init: init
  }

})();