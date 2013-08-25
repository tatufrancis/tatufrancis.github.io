$ ->

  $('body').on 'click', '.checklist li', ->
    if $(@).attr('data-checked') == "true"
      $(@).attr('data-checked', "false")
    else
      $(@).attr('data-checked', "true")
