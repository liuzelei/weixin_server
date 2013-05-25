# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

###
$(document).on 'nested:fieldAdded', (event) ->
  # this field was just inserted into your form
  field = event.field
  # it's a jQuery object already! Now you can find date input
  ##kindeiitor_field = field.find('.kindeditor')
  # and activate on it
  KindEditor.create('.kindeditor')
###

@auto_show_news_toolbar = () ->
  #$(".news_toolbar").hover (-> $(".news_toolbar a").show()), (-> $(".news_toolbar a").hide())
  $(".thumbnail").hover (-> $(this).find(".news_toolbar a").show()), (-> $(this).find(".news_toolbar a").hide())


@news_waterfall = () ->
  opt={
    column_width:310,
    cell_selector:'.thumbnail'
  }
  $('.news_waterfall').waterfall(opt)
