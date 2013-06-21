@load_baidu_map_and_navigate = () ->
  map = new BMap.Map("baidu_map")          # 创建地图实例

  wx_text_content = purl().param('wx_text_content')
  from_address = wx_text_content.replace("，",",").split(',')[1]
  to_address = wx_text_content.replace("，",",").split(',')[2]
  my_geo = new BMap.Geocoder()
  my_geo.getPoint(to_address, (point) ->
    if point and from_address and to_address
      map.centerAndZoom(point, 15)

      transit = new BMap.TransitRoute(map, { renderOptions: {map: map, panel: "map_results"} })
      transit.search(from_address, to_address)
    else
      $("#baidu_map").append("很抱歉没有找到地址，输入更详细的地址试试呢？<br/>格式：关键词,起始地址,终点地址")
  )


@load_baidu_map = () ->
  map = new BMap.Map("baidu_map")          # 创建地图实例
  my_geo = new BMap.Geocoder()
  #my_geo.getPoint("上海市广富林路1188弄144号", (point) ->
  my_geo.getPoint("上海市人民广场", (point) ->
    if point
      map.centerAndZoom(point, 15)
    else
      point = new BMap.Point(116.404, 39.915)  # 创建点坐标
      #map.centerAndZoom(point, 15)
    marker = new BMap.Marker(point)
    map.addOverlay marker

    marker.setAnimation(BMAP_ANIMATION_BOUNCE)
    infoWindow = new BMap.InfoWindow("<p>xxx路xxx号</p>", {width: 250, height: 100, title: "<h3>xxxx店</h3>"});       # 创建信息窗口对象    
    map.openInfoWindow(infoWindow, map.getCenter());       # 打开信息窗口    

    transit = new BMap.TransitRoute(map, {
       renderOptions: {map: map}
    })
    transit.search("人民广场", "静安寺")
  )

