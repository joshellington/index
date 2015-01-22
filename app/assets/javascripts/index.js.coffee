# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

L.mapbox.accessToken = 'pk.eyJ1Ijoiam9zaGVsbGluZ3RvbiIsImEiOiIyYWNkWjJ3In0.aJMJy9c6B0OZ-KzghuDFGw'

ready = ->
  centerLat = $('.business').first().attr('data-lat')
  centerLng = $('.business').first().attr('data-lng')
  zoom = $('.listing').first().attr('data-zoom')

  window.map = L.mapbox.map('map').setView([centerLat, centerLng], 15).addLayer(L.mapbox.tileLayer('joshellington.l0lh3h90'))
  window.markers = new L.MarkerClusterGroup()
  
  $('.business').each (i, item) ->
    lat = $(item).attr('data-lat')
    lng = $(item).attr('data-lng')
    title = $(item).find('h4 a').text()
    link = $(item).find('a').attr('href')

    marker = L.marker(new L.LatLng(lat, lng),
      icon: L.mapbox.marker.icon({'marker-symbol': 'circle', 'marker-color': '000000'})
      title: title
    )

    marker.bindPopup('<h3><a href="'+link+'">'+title+'</a></h3>')
    window.markers.addLayer(marker)

  map.addLayer(markers)

$(document).ready(ready)
$(document).on('page:load', ready)