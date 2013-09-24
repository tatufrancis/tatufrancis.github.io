$ ->

  $body = $ 'body'
  $body.on 'click', [
      '.error input'
      '.error textarea'
      '.invalid input'
      '.invalid textarea'
      'input.error'
      'textarea.error'
      'input.invalid'
      'textarea.invalid'
    ].join(','), ->
    $(@).focus().select()

  $('.select select').each ->
    setSelectState(@)

  $body.on 'change', '.select select', ->
    setSelectState(@)

  setSelectState = (el) ->
    $el = $(el)
    firstOptionVal = $el.children('option').first().val()
    firstOptionSelected = $el.children('option').first().attr('selected')
    if firstOptionVal == '' and firstOptionSelected
      $el.addClass('unselected')
    else
      $el.removeClass('unselected')
