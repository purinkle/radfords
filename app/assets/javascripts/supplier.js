/* global google */

$(function() {
  var supplierClasses = [
    'body.suppliers form.new_supplier',
    'body.suppliers form.edit_supplier'
  ].join(', ');

  return $(supplierClasses).submit(function(event) {
    var form, geocoder, params;
    event.preventDefault();
    geocoder = new google.maps.Geocoder();
    params = {
      address: $('input#supplier_address').val(),
      region: 'uk'
    };
    form = this;
    return geocoder.geocode(params, function(results, status) {
      var latLng;
      if (status === google.maps.GeocoderStatus.OK) {
        latLng = results[0].geometry.location;
        $('input#supplier_latitude').val(latLng.lat());
        $('input#supplier_longitude').val(latLng.lng());
      }
      return form.submit();
    });
  });
});
