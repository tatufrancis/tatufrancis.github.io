(function() {
  $(function() {
    var $body;
    $body = $('body');
    $('.dropdown').each(function() {
      if ($(this).attr('aria-pressed') !== 'true') {
        $(this).attr('aria-pressed', 'false');
        return $(this).children('ul').attr({
          'aria-expanded': 'false',
          'aria-hidden': 'true',
          'role': 'menu'
        });
      }
    });
    $body.on('dropdown', function(e) {
      var $target;
      $target = $(e.target);
      $('.dropdown').not($target).attr('aria-pressed', 'false');
      $('.dropdown').children('ul').attr({
        'aria-expanded': 'false',
        'aria-hidden': 'true'
      });
      $target.attr('aria-pressed', ($target.attr('aria-pressed') === 'true' ? 'false' : 'true'));
      return $target.children('ul').attr({
        'aria-expanded': ($target.attr('aria-pressed') === 'true' ? 'true' : 'false'),
        'aria-hidden': ($target.attr('aria-pressed') === 'true' ? 'false' : 'true')
      });
    });
    $body.on('click', '.dropdown', function(e) {
      var $target;
      $target = $(e.currentTarget);
      if (!($target.is('a') || $target.is('button'))) {
        e.stopPropagation();
      }
      if (!$target.hasClass('focused')) {
        return $target.trigger('dropdown');
      } else {
        return $target.removeClass('focused');
      }
    });
    $body.on('click', function() {
      var $dropdown;
      $dropdown = $('.dropdown[aria-pressed="true"]');
      if ($dropdown.length) {
        return $dropdown.attr('aria-pressed', 'false');
      }
    });
    return $body.on('focusout', '.dropdown li:last-child a, .dropdown li:last-child button', function(e) {
      return $('.dropdown[aria-pressed="true"]').attr('aria-pressed', 'false');
    });
  });

}).call(this);
