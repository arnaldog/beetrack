// = require leaflet

var tileLayer = new L.TileLayer(
    'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    {
        attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    }
);

var trackings = L.tileLayer.wms('geoserver/beetrack/wms', {
    layers: 'beetrack:trackings',
    tiled: true,
    format: 'image/png',
    epsg: 4326,
    transparent: true,
    continuousWorld: true,
    display: false
});


$(document).ready(function () {
    var map = new L.Map('map', {
        layers: [tileLayer, trackings]
    });

    var baseMaps = {
        "Open Street Map": tileLayer
    };

    var overlayMaps = {
        "Last Position Tracking": trackings
    };



    L.control.layers(baseMaps, overlayMaps).addTo(map);

    $.getJSON('api/v1/gps/bbox').done(function(data){
        var bounds = [
            [data.min_latitude, data.min_longitude],
            [data.max_latitude, data.max_longitude]
        ];

        map.fitBounds(bounds);
    })
});
