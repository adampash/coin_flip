# Browserify entry point for the global.js bundle (yay CoffeeScript!)
$ = require 'jquery'
call = null
post = "http://gawker.com/quiz-heads-or-tails-1691195516"
flipping = false

responses =
  heads:
    index: 0
    responses: [
      "You are confident, honest, and direct, a natural leader with high standards."
      "You are bold but conscientious, willing to make big plans and back them up."
      "You own who you are, and you never feel any need to hide behind some sort of alternative persona."
    ]
  tails:
    index: 0
    responses: [
      "You are curious about the less-known aspects of life and willing to try the unexpected."
      "You don't worry about status symbols or what other people think is up or down."
      "You are detail-oriented yet free-spirited, able to conceive of new ideas and make them happen."
    ]

coin =
  heads: "tails"
  tails: "heads"
$('.call h3 a').on 'click', ->
  return if flipping
  call = $(@).data('call')
  if responses[call].index > 2
    responses[call].index = 0
  # $(".call .#{coin[call]}").hide()
  $('.result').text("You chose #{call.toUpperCase()}.")
  flip_times = 6
  unless $('.flipper').hasClass('flip')
    flip_times+= 1
  flip flip_times, (result) ->
    console.log result
    setTimeout ->
      $('.share').show()
      $(".call .coin").show()
      # debugger
      message = responses[call].responses[responses[call].index]
      responses[call].index = responses[call].index + 1
      if call is result
        success = '<span class="win">And YOU WIN.</span>'
      else
        success = '<span class="lose">But YOU LOSE.</span>'
      result_text = "You chose #{call.toUpperCase()}. #{message} #{success}"
      $('.result').html(result_text)
    , 400
  return false

flip = (times, complete) ->
  flipping = true
  $('.share').hide()
  random = Math.round(Math.random() * 1)
  if times % 2
    $('.flipper').addClass('flip')
  else
    $('.flipper').removeClass('flip')
  times--
  if times > random
    setTimeout ->
      flip(times, complete)
    , 350
  else
    flipping = false
    complete if times is 1 then "heads" else "tails"



$('.share a').on 'click', ->
  name = $('.name').val()
  if $(@).hasClass('tw_share')
    text = $('.result').text()
    if text.length > 92
      text = text.replace(/\s(but|and) you (lose|win)\./i, '')
      text += " #HeadsOrTails" if text.length < 106
    link = "https://twitter.com/home?status=#{encodeURIComponent "#{text} "}%20#{encodeURIComponent post}"
  else
    share_link = encodeURIComponent post
    link = "https://www.facebook.com/sharer/sharer.php?u=#{share_link}"
  # window.open link
  window.open(link, 'share', 'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no')

  return false
