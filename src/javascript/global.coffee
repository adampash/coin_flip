# Browserify entry point for the global.js bundle (yay CoffeeScript!)
$ = require 'jquery'
call = null
post = "http://gawker.com/take-the-pledge-i-will-not-have-sex-with-anyone-who-we-1690368564"

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
      $('.share').show()
      $(".call .coin").show()
      if call is result
        success = '<span class="win">And YOU WIN.</span>'
      else
        success = '<span class="lose">But YOU LOSE.</span>'
      result_text = "You picked #{call.toUpperCase()}. You are curious about the hidden aspects of life and willing to try the unexpected. #{success}"
      $('.result').html(result_text)
    , 400
  return false

flip = (times, complete) ->
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
    complete if times is 1 then "heads" else "tails"



$('.share a').on 'click', ->
  name = $('.name').val()
  text = "Heads or tails?"
  if $(@).hasClass('tw_share')
    link = "https://twitter.com/home?status=#{encodeURIComponent text}%20#{encodeURIComponent post}"
  else
    share_link = encodeURIComponent post
    link = "https://www.facebook.com/sharer/sharer.php?u=#{share_link}"
  # window.open link
  window.open(link, 'share', 'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no')

  return false
