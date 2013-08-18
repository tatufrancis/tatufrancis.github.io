(function() {
  $(function() {
    var $body;
    $body = $('body');
    $body.on('dropdown', function(e) {
      var $target;
      $target = $(e.target);
      $('.dropdown').not($target).removeClass('on');
      $target[$target.hasClass('on') ? 'removeClass' : 'addClass']('on');
    });
    $body.on('click', '.dropdown', function(e) {
      var $target;
      $target = $(e.currentTarget);
      if (!$target.is('a')) {
        e.stopPropagation();
      }
      if (!$target.hasClass('focused')) {
        $target.trigger('dropdown');
      } else {
        $target.removeClass('focused');
      }
    });
    $body.on('click', function() {
      var $dropdown;
      $dropdown = $('.dropdown.on');
      if ($dropdown.length) {
        $dropdown.removeClass('on');
      }
    });
    $body.on('focus', '.dropdown', function(e) {
      var $target;
      $target = $(e.currentTarget);
      if (!$(e.target).is('a')) {
        if ($target.hasClass('dropdown')) {
          $target.addClass('focused').trigger('dropdown');
        }
      } else {
        e.stopPropagation();
      }
    });
    return $body.on('focusout', '.dropdown li:last-child a', function(e) {
      return $('.dropdown.on').removeClass('on');
    });
  });

}).call(this);
