$ ->

  $body = $('body')

  # dropdown buttons
  $body.on 'dropdown', (e) ->
    $target = $(e.target)

    $('.dropdown').not($target).removeClass('on')

    $target[if $target.hasClass('on') then 'removeClass' else 'addClass']('on')

    return

  $body.on 'click', '.dropdown', (e) ->
    $target = $(e.currentTarget)

    if !$target.is('a')
      e.stopPropagation()

    if !$target.hasClass('focused')
      $target.trigger('dropdown')
    else
      $target.removeClass('focused')

    return

  $body.on 'click', ->
    $dropdown = $('.dropdown.on')
    if $dropdown.length
      $dropdown.removeClass('on')

    return

  # keyboard accessibility
  $body.on 'focus', '.dropdown', (e) ->
    $target = $(e.currentTarget)

    if not $(e.target).is('a')
      if $target.hasClass('dropdown')
        $target.addClass('focused').trigger('dropdown')
    else
      e.stopPropagation()

    return

  $body.on 'focusout', '.dropdown li:last-child a', (e) ->
    $('.dropdown.on').removeClass('on')
