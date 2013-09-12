$ ->

  $body = $('body')

  # init
  $('.dropdown').each ->
    unless $(@).attr('aria-pressed') == 'true'
      $(@).attr('aria-pressed', 'false')
      $(@).children('ul').attr
        'aria-expanded': 'false'
        'aria-hidden': 'true'
        'role': 'menu'

  $body.on 'dropdown', (e) ->
    $target = $(e.target)
    $('.dropdown').not($target).attr('aria-pressed', 'false')
    $('.dropdown').children('ul').attr
      'aria-expanded': 'false'
      'aria-hidden': 'true'
    $target.attr('aria-pressed', (if $target.attr('aria-pressed') == 'true' then 'false' else 'true'))
    $target.children('ul').attr
      'aria-expanded': (if $target.attr('aria-pressed') == 'true' then 'true' else 'false')
      'aria-hidden': (if $target.attr('aria-pressed') == 'true' then 'false' else 'true')

  $body.on 'click', '.dropdown', (e) ->
    $target = $(e.currentTarget)
    if not ($target.is('a') || $target.is('button'))
      e.stopPropagation()
    if !$target.hasClass('focused')
      $target.trigger('dropdown')
    else
      $target.removeClass('focused')

  $body.on 'click', ->
    $dropdown = $('.dropdown[aria-pressed="true"]')
    if $dropdown.length
      $dropdown.attr('aria-pressed', 'false')

  $body.on 'focusout', '.dropdown li:last-child a, .dropdown li:last-child button', (e) ->
    $('.dropdown[aria-pressed="true"]').attr('aria-pressed', 'false')
