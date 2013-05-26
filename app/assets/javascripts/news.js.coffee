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

@generate_uuid = ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = if c is 'x' then r else (r & 0x3|0x8)
    v.toString(16)
  )

@urlsafe = (original_str) ->
  original_str.replace("+","-").replace("/","_")

encoded_entry_uri = (bucket,uuid) ->
  entry_uri = $.base64.encode("#{bucket}:#{uuid}")
  urlsafe(entry_uri)


@auto_show_news_toolbar = () ->
  #$(".news_toolbar").hover (-> $(".news_toolbar a").show()), (-> $(".news_toolbar a").hide())
  $(".thumbnail").hover (-> $(this).find(".news_toolbar a").show()), (-> $(this).find(".news_toolbar a").hide())


@news_waterfall = () ->
  opt={
    column_width:310,
    cell_selector:'.thumbnail'
  }
  $('.news_waterfall').waterfall(opt)

sync_news_title = () ->
  title = $("#news_title").val()
  $("#preview_news_title").text(title)

@upload_file = () ->
  uploader_ele = $('#news_fileupload')
  bucket = uploader_ele.data("bucket")
  uploader_ele.fileupload (
    done: (e, data) ->
      pic_uuid = data.result.key
      $(this).siblings(".hidden").find("input").val(pic_uuid)
      $(this).after("<img src=\"http://#{bucket}.qiniudn.com/#{pic_uuid}\"  alt='' width='200px' height='100px'/>")
      $("#preview_news_pic").find("img").remove()
      $("#preview_news_pic").find("p").hide()
      $("#preview_news_pic").append("<img src=\"http://#{bucket}.qiniudn.com/#{pic_uuid}\"  alt='' />")
      $(this).hide()
  )
###
    formData: [
      {name: "a",value: "aa"},
      {name: "b",value: "bb"}
    ]
  $("#news_upload_btn").click (event, ui) ->
    file_field = $(this).siblings(".hidden").find("#news_fileupload")
    file_field.click()
###
  #$("#news_fileupload").change () ->
  #  console.log "c..."


@auto_preview_news = () ->
  $("#news_title").keyup (event, ui) -> sync_news_title()
  $("#news_title").change (event, ui) -> sync_news_title()
