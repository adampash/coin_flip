# Browserify entry point for the global.js bundle (yay CoffeeScript!)
$ = require 'jquery'
call = null

coin =
  heads: "tails"
  tails: "heads"
$('.call h3 a').on 'click', ->
  call = $(@).data('call')
  $(".call .#{coin[call]}").hide()
  $('.result').text("You picked #{call.toUpperCase()}.")
  flip_times = 6
  unless $('.flipper').hasClass('flip')
    flip_times+= 1
  flip flip_times, (result) ->
    console.log result
    setTimeout ->
      $(".call .coin").show()
      if call is result
        success = "And YOU WIN"
      else
        success = "But YOU LOSE"
      result_text = "You picked #{call.toUpperCase()}. You are curious about the hidden aspects of life and willing to try the unexpected. #{success}"
      $('.result').html(result_text)
    , 400
  return false

flip = (times, complete) ->
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
    complete if times is 1 then "heads" else "tails"
