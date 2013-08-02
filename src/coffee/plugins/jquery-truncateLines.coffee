###
 *
 *  jQuery truncateLines by Gary Hepting - https://github.com/ghepting/jquery-truncate-lines
 *  
 *  Open source under the MIT License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
###

delayedAdjustTruncation = []
truncateIndex = 0

class TruncateLines

  constructor: (el) ->
    @el = el
    @index = truncateIndex++
    @text = $(@el).text()
    $(@el).attr('data-text',@text)
    @words = @text.trim().split(" ")                # store words in array
    @lines = parseInt($(@el).attr('data-truncate'))         # store maximum number of lines
    @truncate()
    @adjustOnResize()

  truncate: ->
    @measure()
    @setContent()

  reset: ->
    $(@el).text(@text)
      .css('max-height', 'none')
      .attr('data-truncated', 'false')

  measure: ->
    @reset()                                              # reset element state
    $(@el).html(".")                                      # set element to have single line
    @singleLineHeight = $(@el).outerHeight()
    i = 1
    while i++ < @lines                                    # set element to have the maximum number of lines
      $(@el).append("<br>.")
    @maxLinesHeight = $(@el).outerHeight()                # store the height of the element when it is at the max number of lines

  empty: ->
    $(@el).html("")                                       # clear the element

  setContent: ->
    @reset()                                              # reset element state
    truncated = false                                     # reset truncated state
    @addWords(@words.length)
    if @tooBig()
      # binary build-up the string -- Thanks @BananaNeil  :]
      @addNumberWordsThatFit()
      $(@el).css('max-height', @maxLinesHeight + 'px')    # set the max height
      $(@el).attr('data-truncated', true)            # set element truncation state

  addNumberWordsThatFit: ->
    cant = @words.length
    can = 0
    mid = Math.floor(@words.length/2)
    while can+1 != cant
      @addWords(can + mid)
      if @tooBig()
        cant = can + mid
      else
        can = can + mid
      mid = Math.floor(mid/2) || 1
    @addWords(can)
    $(@el).html( @trimTrailingPunctuation( $(@el).html() ) ) # trim trailing punctuation

  addWords: (num) ->
    $(@el).html(@words.slice(0,num).join(" "))

  tooBig: ->
    $(@el).outerHeight() > @maxLinesHeight

  adjustOnResize: ->
    $(window).on 'resize', =>
      clearTimeout(delayedAdjustTruncation[@index])
      delayedAdjustTruncation[@index] = setTimeout(=>
        @truncate()
      , 20)

  trimTrailingPunctuation: (str) ->
    str.replace(/(,$)|(\.$)|(\:$)|(\;$)|(\?$)|(\!$)/g, "")

(($) ->

  truncateInitialized = false
  truncatedLineElements = []

  $.fn.truncateLines = ->

    unless truncateInitialized
      # add CSS for the ellipsis (just so there are no additional file dependencies)
      $('head').append('<style type="text/css"> [data-truncated="true"] { overflow: hidden; } [data-truncated="true"]:after { content: "..."; position: absolute; } </style>')

    @each ->
      truncatedLineElements.push( new TruncateLines(@) )

) jQuery

$(window).load ->
  $("[data-truncate]").truncateLines()
  # $('[data-truncated="true"]').on 'mouseenter', ->
  #   $(this).html($(this).attr('data-text')).attr('data-truncated', 'false')
  #   stopScrolling($(this))
  #   $(this).animate(scrollTop: $(this)[0].scrollHeight, ($(this)[0].scrollHeight * 120))
  # $('[data-truncated="true"]').on 'mouseleave', ->
  #   $(this).stop().animate(scrollTop: 0, ($(this)[0].scrollHeight * 5), ->
  #     $(this).truncateLines()
  #   )
  # $('[data-truncated="true"]').on 'mousedown', ->
  #   stopScrolling($(this))
  # $('[data-truncated="true"]').on 'mousewheel', ->
  #   stopScrolling($(this))

# stopScrolling = ($el) ->
#   $el.stop().css('overflow','auto')
