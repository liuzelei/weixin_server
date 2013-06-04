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

# jquery.base64.js
#encoded_entry_uri = (bucket,uuid) ->
#  entry_uri = $.base64.encode("#{bucket}:#{uuid}")
#  urlsafe(entry_uri)


@auto_show_news_toolbar = () ->
  #$(".news_toolbar").hover (-> $(".news_toolbar a").show()), (-> $(".news_toolbar a").hide())
  $(".thumbnail").hover (-> $(this).find(".news_toolbar a").show()), (-> $(this).find(".news_toolbar a").hide())

@auto_show_item_toolbar = () ->
  $(".news_items_table tr").hover (-> $(this).find(".item_toolbar a").show()), (-> $(this).find(".item_toolbar a").hide())

@news_waterfall = () ->
  opt={
    column_width:310,
    cell_selector:'.thumbnail'
  }
  $('.news_waterfall').waterfall(opt)

@upload_news_pic = () ->
  uploader_ele = $('.news_fileupload')
  bucket = uploader_ele.data("bucket")
  uploader_ele.fileupload (
    done: (e, data) ->
      pic_uuid = data.result.key
      pic_url_origin = "http://#{bucket}.qiniudn.com/#{pic_uuid}"
      pic_url_mobile = pic_url_origin + '-mobile'
      pic_url_large = pic_url_origin + '-large'
      $(this).siblings(".hidden").find("input").val(pic_uuid)
      $(this).after("<img src=\"#{pic_url_large}\" alt='' width='200px' height='100px'/><p>#{pic_url_mobile}</p>")
      $("#preview_news_pic").find("img").remove()
      $("#preview_news_pic").find("p").hide()
      $("#preview_news_pic").append("<img src=\"http://#{bucket}.qiniudn.com/#{pic_uuid}-large\"  alt='' />")
      $(this).hide()
  )
@upload_news_item_pic = () ->
  uploader_ele = $('.news_fileupload')
  bucket = uploader_ele.data("bucket")
  uploader_ele.fileupload
    done: (e, data) ->
      pic_uuid = data.result.key
      pic_url_origin = "http://#{bucket}.qiniudn.com/#{pic_uuid}"
      pic_url_mobile = pic_url_origin + '-mobile'
      pic_url_large = pic_url_origin + '-large'
      $(this).siblings(".hidden").find("input").val(pic_uuid)
      $(this).after("<img src=\"#{pic_url_large}\" alt='' width='200px' height='100px'/><p>#{pic_url_mobile}</p>")
      $(".preview_item_pic").last().find("img").remove()
      $(".preview_item_pic").last().find("p").hide()
      $(".preview_item_pic").last().append("<img src=\"http://#{bucket}.qiniudn.com/#{pic_uuid}-small\"  alt='' />")
      $(this).hide()
@upload_common_audio = () ->
  uploader_ele = $('.audio_fileupload')
  bucket = uploader_ele.data("bucket")
  uploader_ele.fileupload
    done: (e, data) ->
      uuid = data.result.key
      audio_url_origin = "http://#{bucket}.qiniudn.com/#{uuid}"
      #audio_url_mobile = audio_url_origin + '-mobile'
      $(this).siblings(".hidden").find("input").val(uuid)
      $(this).after("<audio controls='controls'> <source src=\"#{audio_url_origin}\" /> </audio>")
      $(this).hide()
@upload_common_pic = () ->
  uploader_ele = $('.news_fileupload')
  bucket = uploader_ele.data("bucket")
  uploader_ele.fileupload
    done: (e, data) ->
      pic_uuid = data.result.key
      pic_url_origin = "http://#{bucket}.qiniudn.com/#{pic_uuid}"
      pic_url_mobile = pic_url_origin + '-mobile'
      $(this).siblings(".hidden").find("input").val(pic_uuid)
      $(this).after("<img src=\"#{pic_url_mobile}\" alt='' width='200px' height='100px'/><p>#{pic_url_mobile}</p>")
      $(this).hide()
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


sync_news_title = () ->
  str = $("#news_title").val()
  $("#preview_news_title").text(str)
sync_news_desc = () ->
  str = $("#news_desc").val()
  $("#preview_news_desc").text(str)


sync_news_item_title = (obj) ->
  #index_item_title = $(".news_item_title").index obj
  title = obj.val()
  #preview_item_title = $(".preview_item_title").eq(index_item_title)
  preview_item_title = $(".preview_item_title").last()
  preview_item_title.text(title)

@auto_preview_news = () ->
  # 预览大图文标题
  $("#news_title").keyup (event, ui) -> sync_news_title()
  $("#news_title").change (event, ui) -> sync_news_title()

  # 预览大图文描述
  $("#news_desc").keyup (event, ui) -> sync_news_desc()
  $("#news_desc").change (event, ui) -> sync_news_desc()

  # 预览子图文标题
  $("body").on "keyup", ".news_item_title", () -> sync_news_item_title($(this))
  $("body").on "change", ".news_item_title", () -> sync_news_item_title($(this))

###
  # 添加子图文
  $("#add_news_item").click (event, ui) ->
    item_html = "<tr> <td><a href='#nogo' class='preview_item_title'>文</a></td> <td>图</td> </tr>"
    $(".news_items_table").append item_html
    upload_news_item_pic()
    #$('.fields').not(':hidden').length

  # 删除子图文
  $("body").on 'click',".rm_news_item", (event) ->
    index_rm_btn = $(".rm_news_item").index $(this)
    $(".news_items_table tr").eq(index_rm_btn).hide()
###

