# Browserify entry point for the global.js bundle (yay CoffeeScript!)
$ = require 'jquery'

$('.flip-container').on 'click', ->
  flip_times = 6
  unless $('.flipper').hasClass('flip')
    flip_times+= 1
  flip flip_times, (result) ->
    console.log result
    setTimeout ->
      $('.result').text(result)
    , 400

flip = (times, complete) ->
  $('.result').text('...')
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
