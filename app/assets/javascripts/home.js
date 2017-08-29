mapboxgl.accessToken = 'pk.eyJ1IjoieW95b3N0aWxlIiwiYSI6IktMYkRtYWMifQ.GR9h5n3DdQBUIUXVeh2-5A';
var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/yoyostile/cj6xpembf1iab2ulh22v9h5vm'
});

geojson.features.forEach(function(marker) {
  // create lin
  var aHerf = document.createElement('a')
  aHerf.appendChild(document.createTextNode(marker.properties.title))
  aHerf.href='/' + marker.properties.slug
  var el = document.createElement('div');
  el.appendChild(aHerf)
  el.className = 'marker';

  // make a marker for each feature and add to the map
  new mapboxgl.Marker(el, { offset: [0, - 10] })
  .setLngLat(marker.geometry.coordinates)
  .addTo(map);
});
