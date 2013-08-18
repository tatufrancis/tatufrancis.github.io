(function() {
  $(function() {
    return $('body').on('click', '.dismissible', function() {
      return $(this).hide(150, function() {
        return $(this).remove();
      });
    });
  });

}).call(this);
