@load_baidu_map = () ->
  map = new BMap.Map("baidu_map")          # 创建地图实例
  my_geo = new BMap.Geocoder()
  #my_geo.getPoint("上海市广富林路1188弄144号", (point) ->
  my_geo.getPoint("ljsldjfjsldf", (point) ->
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
    transit.search("上海市松江大学城", "上海市松江新城")
  )

    
