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

      if (response.error) {
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
