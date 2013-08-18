###
 *
 *  jQuery ResponsiveNavigation by Gary Hepting
 *  
 *  Open source under the MIT License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
###

responsiveNavigationIndex = 0
delayNavigationClose = []

class ResponsiveNavigation

  constructor: (el) ->
    @index = responsiveNavigationIndex++
    @el = $(el)
    @init()

  init: ->
    @defaultLabel()
    @setupMarkers()
    @hamburgerHelper()
    @touchBindings()
    unless Modernizr.touch
      @mouseBindings()

  defaultLabel: ->
    if @el.attr('title') == undefined
      @el.attr('title', 'Menu')

  setupMarkers: ->
    @el.find('li').each ->
      if $(@).find('ul').length
        $(@).addClass('menu')

  hamburgerHelper: ->
    @el.prepend('<button><i class="icon-list-ul" /></button>')

  mouseBindings: ->
    $('body').on 'mouseenter', 'li.menu', ->
      unless $(@).parents('.nav').find('button').is(':visible')
        clearTimeout(delayNavigationClose[@index])
        $(this).siblings().children('ul').removeClass('open')
        $(@).children('ul').addClass('open')

    $('body').on 'mouseleave', 'li.menu, ul.open', ->
      unless $(@).parents('.nav').find('button').is(':visible')
        delayNavigationClose[@index] = setTimeout( =>
          $(@).find('ul').removeClass('open')
        , 500)

  touchBindings: ->
    $('body').on 'click', 'li.menu > a', (e) ->
      $(this).closest('.menu').children('ul').toggleClass('open')
      $(this).closest('.menu').toggleClass('on')
      unless $(this).closest('.menu').hasClass('on')
        $(this).closest('.menu').find('.menu').removeClass('on')
        $(this).closest('.menu').find('ul').removeClass('open')
      e.preventDefault()
      false

$ ->

  responsiveNavigationElements = []

  $('.nav').each ->
    responsiveNavigationElements.push( new ResponsiveNavigation(@) )

  $('body').on 'click', '.nav button', (e) ->
    list = $(this).siblings('ul')
    list.toggleClass('open')
    unless list.hasClass('on')
      list.find('.menu').removeClass('on')
      list.find('ul').removeClass('open')
    e.preventDefault()
    false
