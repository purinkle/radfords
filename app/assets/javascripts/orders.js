jQuery(function ($) {
  $(document).ready(function () {
    $(document).on("submit", "#payment-form", function (e) {
      var $form = $(this);

      e.preventDefault();
      $form.find('button').prop('disabled', true);
      $form.find(".alert-error").remove();
      Stripe.card.createToken($form, stripeResponseHandler);
      return false;
    });

    var stripeResponseHandler = function (status, response) {
      var $form = $('#payment-form'),
      $alert = $("<div>").addClass("alert alert-block alert-error"),
      fields = $form.find("[data-required]"),
      $heading = $("<h4>").text("Looks like we need more information"),
      $list = $("<ul>"),
      errors = [];

      errors = fields.map(function () {
        var $element = $(this);

        if ($element.val().trim() === "") {
          return $("label[for='" + $element.attr("id") + "']").text() +
            " can't be blank";
        }
      });

      if (!Stripe.validateCardNumber($(".card-number").val())) {
        errors.push("This card number looks invalid");
      }

      if (!Stripe.validateExpiry($(".card-expiry-month").val(), $(".card-expiry-year").val())) {
        errors.push("Your card's expiration date is invalid");
      }

      if (!Stripe.validateCVC($(".card-cvc").val())) {
        errors.push("Your card's security code is invalid");
      }

      if (errors.length < 1 && response.error) {
        errors.push(response.error.message);
      }

      if (errors.length !== 0) {
        errors.each(function () {
          $list.append($("<li>").text(this));
        });
        $alert.prepend([$heading, $list]);
        $form.prepend($alert);
        $form.find('button').prop('disabled', false);
      } else {
        var token = response.id;
        $form.append($('<input type="hidden" name="stripe_token" />').
            val(token));
        $form.get(0).submit();
      }
    };
  });
});
