$(function() {

  var i, j, len, len1, map, marker, markers, markersGroup, moveBoxes, non_wheel_chair_stations, normal, notFound, points, pop, resetAllLayers, result, showStation, validMarkers, validMarkersGroup, wheel_chair, wheelchair_stations;
  if ($('#city').length !== 0 && $('#map').length) {
    normal = L.icon({
      iconUrl: $('#image_marker1').val(),
      iconSize: [15, 15],
      popupAnchor: [0, -15]
    });
    wheel_chair = L.icon({
      iconUrl: $('#image_marker2').val(),
      iconSize: [17, 17],
      popupAnchor: [0, -15]
    });
    wheelchair_stations = $("#map").data("wheelchairStations");
    non_wheel_chair_stations = $("#map").data("withoutWheelchairStations");
    map = L.map("map");
    L.tileLayer('http://{s}.tiles.mapbox.com/v3/yoyostile.j66f39do/{z}/{x}/{y}.png', {
      attribution: "<a href='https://www.mapbox.com/about/maps/' target='_blank'>Maps &copy; Mapbox &copy; OpenStreetMap</a>",
      maxZoom: 16,
      detectRetina: true
    }).addTo(map);
    points = [];
    markers = [];
    for (i = 0, len = wheelchair_stations.length; i < len; i++) {
      result = wheelchair_stations[i];
      marker = L.marker(result.geo, {
        icon: wheel_chair,
        station_id: result.number
      });
      pop = L.popup({
        'className': 'box'
      }).setContent("<img src=" + $('#image_rollstuhl').val() + " style='margin-left:10px;float:right'> <h3>Wahllokalnummer: " + result.number + "</h3> Gebäude: " + result.name + " <br> Adresse: " + result.street + " <br> Telefon: " + result.phone);
      marker.bindPopup(pop);
      points.push(result.geo);
      markers.push(marker);
    }
    for (j = 0, len1 = non_wheel_chair_stations.length; j < len1; j++) {
      result = non_wheel_chair_stations[j];
      marker = L.marker(result.geo, {
        icon: normal,
        station_id: result.number
      });
      pop = L.popup({
        'className': 'box'
      }).setContent("<h3>Wahllokalnummer: " + result.number + "</h3> Gebäude: " + result.name + " <br> Adresse: " + result.street + " <br> Telefon: " + result.phone);
      marker.bindPopup(pop);
      points.push(result.geo);
      markers.push(marker);
    }
    markersGroup = L.layerGroup(markers);
    markersGroup.addTo(map);
    if (points.length > 0) {
      map.fitBounds(points);
    } else {
      map.setView([50.938056, 6.956944], 13);
    }
    validMarkers = [];
    validMarkersGroup = L.layerGroup([]);
    $('form').on('submit', map, function(event) {
      var number;
      event.preventDefault();
      number = parseInt($('form input#number').val());
      if (isNaN(number)) {
        console.log('number= ' + number)
        return $.get('/search/' + '?c=' + $('form input#city').val() + '&q=' + $('form input#number').val(), function(data) {
          console.log('data= ' + data)
          if (data && data.vote_district_id !== void 0) {
            return showStation(data.vote_district_id);
          } else {
            ga('send', 'event', 'search', 'error', $('form input#number').val());
            return notFound("Bitte geben sie Straße Hausnummer.");
          }
        });
      } else {
        return showStation(number);
      }
    });
  }
  $('.leaflet-marker-icon').on('click', function(e) {
    return moveBoxes();
  });
  showStation = function(number) {
    var k, l, len2, len3, results;
    validMarkers = [];
    for (k = 0, len2 = markers.length; k < len2; k++) {
      marker = markers[k];
      if (marker.options.station_id === number) {
        validMarkers.push(marker);
      }
    }
    if (validMarkers.length > 0) {
      $('#slogan').hide();
      moveBoxes();
      markersGroup.clearLayers();
      validMarkersGroup = L.layerGroup(validMarkers);
      validMarkersGroup.addTo(map);
      map.setView(validMarkers[0]._latlng, 20);
      ga('send', 'event', 'search', 'success');
      results = [];
      for (l = 0, len3 = validMarkers.length; l < len3; l++) {
        marker = validMarkers[l];
        results.push(marker.openPopup());
      }
      return results;
    } else {
      ga('send', 'event', 'search', 'error', number);
      return notFound();
    }
  };
  moveBoxes = function() {
    var newPos;
    newPos = $('.headline').position().top + $('headline').height();
    $('#search-wrapper').animate({
      top: newPos
    });
    return $('#search-wrapper .box').animate({
      'margin-left': 30,
      'margin-top': 30
    });
  };
  resetAllLayers = function() {
    validMarkersGroup.clearLayers();
    markersGroup.clearLayers();
    validMarkers = [];
    markersGroup = L.layerGroup(markers);
    markersGroup.addTo(map);
    return map.fitBounds(points);
  };
  notFound = function(text) {
    text = text !== '' ? text : 'Kein passendes Wahllokal gefunden.';
    $('#slogan .slogan').hide();
    $('#slogan .not-found').html(text);
    $('#slogan .not-found').show();
    $('#slogan .not-found').animate({
      color: "#ff0000"
    }, 300).animate({
      color: "#fff"
    }, 600);
    $('#slogan').fadeIn();
    if (validMarkers.length > 0) {
      return resetAllLayers();
    }
  };
  return $('#logo a').on('click', function() {
    return $('#search-form form').submit();
  });
});
