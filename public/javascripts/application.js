Radfords = {}

jQuery(function($) {
    for (key in Radfords) {
        if (Radfords.hasOwnProperty(key)) {
            if (typeof Radfords[key]['init'] === 'function' && $('body').hasClass('with-js-' + key.toLowerCase())) {
                Radfords[key].init($)
            }
        }
    }
});