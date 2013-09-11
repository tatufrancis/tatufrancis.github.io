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

  defaultLabel: ->
    if @el.attr('title') == undefined
      @el.attr('title', 'Menu')

  setupMarkers: ->
    @el.find('li').each ->
      if $(@).find('ul').length
        $(@).addClass('menu')

  hamburgerHelper: ->
    @el.prepend('<button class="hamburger"></button>')

$ ->

  mouseBindings = -> # need a little more <3
    $('body').on 'mouseenter', 'li.menu', ->
      unless $(@).parents('.nav').find('button.hamburger').is(':visible')
        clearTimeout(delayNavigationClose[@index])
        $(@).siblings().children('ul').removeClass('open')
        $(@).children('ul').addClass('open')

    $('body').on 'mouseleave', 'li.menu, ul.open', ->
      unless $(@).parents('.nav').find('button.hamburger').is(':visible')
        delayNavigationClose[@index] = setTimeout( =>
          $(@).find('ul').removeClass('open')
        , 500)

  touchBindings = ->
    $('body').on 'click', 'li.menu > a, li.menu > button', (e) ->
      $(@).closest('.menu').children('ul').toggleClass('open')
      $(@).closest('.menu').toggleClass('on')
      unless $(@).closest('.menu').hasClass('on')
        $(@).closest('.menu').find('.menu').removeClass('on')
        $(@).closest('.menu').find('ul').removeClass('open')
      e.preventDefault()

  responsiveNavigationElements = []

  $('.nav').each ->
    responsiveNavigationElements.push( new ResponsiveNavigation(@) )

  $('body').on 'click', '.nav button.hamburger', (e) ->
    $(@).toggleClass('open')
    list = $(@).siblings('ul')
    list.toggleClass('open')
    unless list.hasClass('on')
      list.find('.menu').removeClass('on')
      list.find('ul').removeClass('open')
    e.preventDefault()

  # initialize bindings
  touchBindings()
  unless Modernizr.touch
    mouseBindings()
