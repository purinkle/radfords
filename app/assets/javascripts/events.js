$(function() {
  var date, day, element, formattedDate, month, year;
  element = $('body.events input#event_takes_place_on');
  date = new Date();
  if (!element.val()) {
    day = ('0' + date.getDate()).slice(-2);
    month = ('0' + (date.getMonth() + 1)).slice(-2);
    year = date.getFullYear();
    formattedDate = [day, month, year].join('/');
    element.val(formattedDate);
  }
  return element.datepicker();
});
