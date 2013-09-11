$ ->

  $('.tabs').each ->
    activeTab = $(@).children('ul').children('li.active')
    if activeTab.length
      tabs = activeTab.parents('.tabs')
      tabs.find(activeTab.attr('aria-controls')).addClass('active')
    else
      $(@).children('ul').children('li').first().addClass('active')
      $(@).children('div').first().addClass('active')

  $('body').on 'click', '.tabs > ul li', (e) ->
    tab = $(@).addClass('active')
    tabs = tab.parents('.tabs')
    tab.siblings('li').removeClass('active')
    tabs.find('> div, > ul > div').hide()
    tabs.find(tab.attr('aria-controls')).show()
    e.preventDefault()

  transformTabs = ->
    viewport = $(window).width()
    if viewport <= 480
      restoreTabStructure('.tabs.accordion.mobile')
      convertToAccordion('.tabs:not(.accordion):not(.mobile)')
    else if viewport < 768
      restoreTabStructure('.tabs.accordion.mobile, .tabs.accordion.small-tablet')
      convertToAccordion('.tabs:not(.accordion):not(.mobile):not(.small-tablet)')
    else if viewport <= 1024
      restoreTabStructure('.tabs.accordion.mobile, .tabs.accordion.small-tablet, .tabs.accordion.ipad')
      convertToAccordion('.tabs:not(.accordion):not(.mobile):not(.small-tablet):not(.ipad)')
    else if viewport > 1024
      restoreTabStructure('.tabs.accordion')

  convertToAccordion = (tabTypes) ->
    tabTypes = $(tabTypes)
    tabTypes.each ->
      tabs = $(@)
      tabs.addClass('accordion')
      tabs.find('> div').each ->
        tabpanel = $(@).clone()
        tabs.find('li[aria-controls="#'+tabpanel.attr('id')+'"]').after(tabpanel)
        $(@).remove()

  restoreTabStructure = (tabTypes) ->
    $(tabTypes).each ->
      tabs = $(@)
      tabs.removeClass('accordion')
      if tabs.hasClass('vertical')
        adjustVerticalTabs(tabs)
      tabs.children('ul').children('div').each ->
        tabpanel = $(@).clone()
        tabs.append(tabpanel)
        $(@).remove()

  # adjustHorizontalTabs = (tabs) ->
  #   tabs = $(tabs)
  #   unless tabs.length
  #     tabs = $('.tabs:not(.vertical)')
  #   tabs.each ->

  adjustVerticalTabs = (tabs) ->
    tabs = $(tabs)
    unless tabs.length
      tabs = $('.tabs.vertical')
    tabs.each ->
      if $(@).hasClass('vertical')
        $(@).children('ul').css
          'min-height': '0px'
        unless $(@).hasClass('accordion')
          $(@).children('[role="tabpanel"]').css
            'padding-left': $(@).children('ul').width() + 10 + 'px'
          $(@).children('ul').css
            'min-height': $(@).height() + 'px'

  $(window).resize ->
    clearTimeout(window.delayedAdjustTabs)
    window.delayedAdjustTabs = setTimeout( ->
      transformTabs()
      adjustVerticalTabs()
    , 50)

  $(window).load ->
    transformTabs()
    adjustVerticalTabs()

