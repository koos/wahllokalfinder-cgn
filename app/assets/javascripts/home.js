if (typeof mapboxgl !== 'undefined') {
  mapboxgl.accessToken = 'pk.eyJ1IjoicmFpbHNsb3ZlIiwiYSI6ImNqNzdoa21xeDE3dnAyd3AzenlldHNtc3gifQ.-9GLlN1W1ua9UR6ZXW24JQ';
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/railslove/cj7h9lgfa49a42stqt9jg2cbw',
  });
  geojson.features.forEach(function(marker) {
    var aHerf = document.createElement('a')
    aHerf.appendChild(document.createTextNode(marker.properties.title))
    aHerf.href='/' + marker.properties.slug
    var containerDiv = document.createElement('div');
    var markerDiv = document.createElement('div');
    markerDiv.appendChild(containerDiv)
    containerDiv.appendChild(aHerf)
    markerDiv.className = 'marker';
    containerDiv.id = marker.properties.slug + '-link';
    containerDiv.setAttribute('data-slug', marker.properties.slug)
    containerDiv.className = 'link city-llink';
    new mapboxgl.Marker(markerDiv, { offset: [0, 0] })
    .setLngLat(marker.geometry.coordinates)
    .addTo(map);
  });

}

$('.city-llink').hover(
  function() {
    var cityMarkerSelector = $('#' + $(this).attr('data-slug') + '-link')
    cityMarkerSelector.removeClass('label-hidden');
    cityMarkerSelector.addClass('label-visible');
    cityMarkerSelector.parent().css('z-index', '1009');
  }, function() {
    if (map.getZoom() < 7) {
      var cityMarkerSelector = $('#' + $(this).attr('data-slug') + '-link')
      cityMarkerSelector.addClass('label-hidden');
      cityMarkerSelector.removeClass('label-visible');
      cityMarkerSelector.parent().css('z-index', '1');
    }
  }
);

function handleLabelVisible(link) {
  if (!link.hasClass('label-visible')) {
    link.addClass('label-visible')
    link.removeClass('label-hidden')
  }
}

function handleLabelHidden(link) {
  if (link.hasClass('label-visible') || !link.hasClass('label-hidden')) {
    link.removeClass('label-visible')
    link.addClass('label-hidden')
  }
}

function doResizeMap(){
  // console.log($(window).width(),$(window).height())
}

function mapZoomEdge(){
  var currentZoom = map.getZoom()
  var markersLink = $('.link')
  var citiesList = $('#cities-list')
  var footer = $('#footer')

  if (currentZoom >= 7){
    handleLabelVisible(markersLink)
    citiesList.addClass('cities-list-box-hidden')
    footer.addClass('hidden-footer')
  } else {
    handleLabelHidden(markersLink)
    citiesList.removeClass('cities-list-box-hidden')
    footer.removeClass('hidden-footer')
  }
}

$(window).bind('resize', function() {
  doResizeMap()
});

if (typeof map === 'object'){

  map.on('load', function () {
    doResizeMap()
  });
  map.on('zoom', function () {
    mapZoomEdge()
  });

}
