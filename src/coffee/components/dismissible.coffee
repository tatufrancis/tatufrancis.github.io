$ ->

  $('body').on 'click', '.dismissible', ->
    $(this).hide 150, ->
      $(this).remove()
