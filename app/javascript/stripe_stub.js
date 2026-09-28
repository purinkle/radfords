// A stand-in for Stripe's remote v2 library, built only for the test
// environment. It answers every call the checkout code makes, so a browser
// spec can drive the payment form without reaching js.stripe.com.
//
// config/webpack/environment.js drops this entry from every other build.

function digitsOnly(value) {
  return String(value == null ? '' : value).replace(/\D/g, '');
}

// Luhn's algorithm, the check a card number has to pass before an issuer will
// look at it.
function passesLuhn(number) {
  var sum = 0;
  var double = false;
  var digit;
  var index;

  for (index = number.length - 1; index >= 0; index -= 1) {
    digit = parseInt(number.charAt(index), 10);

    if (double) {
      digit *= 2;

      if (digit > 9) {
        digit -= 9;
      }
    }

    sum += digit;
    double = !double;
  }

  return sum % 10 === 0;
}

function fullYear(year) {
  var number = parseInt(year, 10);

  if (isNaN(number)) {
    return NaN;
  }

  return String(year).trim().length <= 2 ? 2000 + number : number;
}

var Stripe = {
  // The order page calls this before anything else. Nothing reads the key
  // back, so there is nothing to keep.
  setPublishableKey: function () {},

  validateCardNumber: function (value) {
    var number = digitsOnly(value);

    return number.length >= 12 && number.length <= 19 && passesLuhn(number);
  },

  validateExpiry: function (month, year) {
    var monthNumber = parseInt(month, 10);
    var yearNumber = fullYear(year);
    var now = new Date();

    if (isNaN(monthNumber) || isNaN(yearNumber)) {
      return false;
    }

    if (monthNumber < 1 || monthNumber > 12) {
      return false;
    }

    // A card is good until the last moment of its expiry month.
    return new Date(yearNumber, monthNumber, 1) > now;
  },

  validateCVC: function (value) {
    var code = digitsOnly(value);

    return code.length >= 3 && code.length <= 4;
  },

  card: {
    createToken: function (form, handler) {
      handler(200, { id: 'tok_test_stub' });
    }
  }
};

window.Stripe = Stripe;
