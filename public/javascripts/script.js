Geocoding = {};

jQuery(function ($) {
    for (key in Geocoding) {
        if (Geocoding.hasOwnProperty(key)) {
            if (typeof Geocoding[key]['init'] === 'function' && $('body').hasClass('with-js-' + key.toLowerCase())) {
                Geocoding[key].init($)
            }
        }
    }
});

var geocoder, map;

Geocoding.geocode = {
    init: function () {
        geocoder = new google.maps.Geocoder();
        var geocode = this;
        var latlng = new google.maps.LatLng(53.203, -2.368);

        var myOptions = {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }

        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

        $('#find').click(function () {
            var address = $('#supplier_address').val().replace(/\n/g, ', ');

            geocoder.geocode({ 'address': address, region: 'uk' }, function (results, status) {
                if (status === google.maps.GeocoderStatus.OK) {
                    map.setCenter(results[0].geometry.location);

                    var marker = new google.maps.Marker({
                        draggable: true,
                        map: map,
                        position: results[0].geometry.location
                    });

                    geocode.markLatLng(results[0].geometry.location);

                    google.maps.event.addListener(marker, 'dragend', function(event) {
                        geocode.markLatLng(event.latLng)
                    });
                }
                else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        })
    },
    markLatLng: function(location) {
        $('#supplier_lat').val(location.lat());
        $('#supplier_lng').val(location.lng());
    }
}