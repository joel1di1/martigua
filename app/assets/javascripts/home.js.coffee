# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bind_as_links = () -> 
  $(".as_link[data-url]").click ->
    window.location = $(this).attr("data-url")

jQuery ->
  bind_as_links()

$(document).on "page:load", ->
  bind_as_links()
