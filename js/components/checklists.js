(function() {
  $(function() {
    return $('body').on('click', '.checklist li', function() {
      if ($(this).attr('data-checked') === "true") {
        return $(this).attr('data-checked', "false");
      } else {
        return $(this).attr('data-checked', "true");
      }
    });
  });

}).call(this);
