$ ->
  element = $('body.events input#event_takes_place_on')
  date = new Date
  if !element.val()
    element.val ('0' + date.getDate()).slice(-2) + '/' +
      ('0' + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear()
  element.datepicker()