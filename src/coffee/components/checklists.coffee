$ ->

  $('body').on 'click', '.checklist:not([readonly]) li:not([readonly])', ->
    if $(@).attr('data-checked') == "true"
      $(@).attr('data-checked', "false")
    else
      $(@).attr('data-checked', "true")
