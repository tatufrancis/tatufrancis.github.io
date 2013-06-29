###
 *
 *  jQuery truncateLines by Gary Hepting - https://github.com/ghepting/truncateLines
 *  
 *  Open source under the MIT License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
###

class TruncatedLines

  constructor: (el) ->
    @el = el
    $(@el).attr('data-text', $(@el).text())                 # store original text
    @words = $(@el).attr('data-text').trim().split(" ")     # split string into array of words
    @lines = parseInt($(@el).attr('data-truncate'))         # store maximum number of lines
    @truncate()
    @adjustOnResize()

  truncate: ->
    @reset()
    @measure()
    @setContent()

  reset: ->
    $(@el).text($(@el).attr('data-text')).css('max-height', 'none')
        .attr('data-truncated', 'false')

  measure: ->
    @empty()                                              # set element to have single line
    $(@el).html(".")
    i = 1
    while i++ < @lines                                    # set element to have the maximum number of lines
      $(@el).append("<br>.")
    @maxLinesHeight = $(@el).outerHeight()                  # store the height of the element when it is at the max number of lines
    @empty()
  
  empty: ->
    $(@el).html("")                                         # clear the element

  setContent: ->
    i = 0
    while i++ < @words.length                               # loop through all of the words
      $(@el).append(" " + @words[i])                        # append word to element
      if $(@el).outerHeight() > @maxLinesHeight              # see if word caused element to wrap past maximum number of lines
        i = @words.length                                 # limit hit, stop looping
        @finalWords = $(@el).text().trim().split(" ")       # store the words that will fit in the new space
        @finalWords.pop()                                 # remove the last word that caused wrapping beyond the maxLinesHeight
        # strip punctuation from end of last word
        @finalWords[@finalWords.length - 1] = @finalWords[@finalWords.length - 1].replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]$/, '')
        $(@el).html("")                                     # clear the element
        j = 0
        while j < @finalWords.length                      # append the final set of words to the element
          $(@el).append(" " + @finalWords[j])
          j++
        $(@el).css('max-height', @maxLinesHeight + 'px')    # set the max height
        $(@el).attr('data-truncated', 'true')               # set element truncation state
      i++

  adjustOnResize: ->
    $(window).on 'resize', =>
      @truncate()

(($) ->

  truncateInitialized = false

  $.fn.truncateLines = ->
    unless truncateInitialized
      # add CSS for the ellipsis (just so there are no additional file dependencies)
      $('head').append('<style type="text/css"> [data-truncated="true"] { overflow: hidden; } [data-truncated="true"]:after { content: "..."; position: absolute; } </style>')

    @each ->
      new TruncatedLines(@)

) jQuery


$("[data-truncate]").truncateLines()
