(function() {
  $(function() {
    var $body, setSelectState;
    $body = $('body');
    $body.on('click', ['.error input', '.error textarea', '.invalid input', '.invalid textarea', 'input.error', 'textarea.error', 'input.invalid', 'textarea.invalid'].join(','), function() {});
    $(this).focus().select();
    $('.select select').each(function() {
      return setSelectState(this);
    });
    $body.on('change', '.select select', function() {
      return setSelectState(this);
    });
    return setSelectState = function(el) {
      var $el, firstOptionSelected, firstOptionVal;
      $el = $(el);
      firstOptionVal = $el.children('option').first().val();
      firstOptionSelected = $el.children('option').first().attr('selected');
      if (firstOptionVal === '' && firstOptionSelected) {
        return $el.addClass('unselected');
      } else {
        return $el.removeClass('unselected');
      }
    };
  });

}).call(this);
