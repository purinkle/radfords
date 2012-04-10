/*global $: false, jQuery: false, Radfords: false */
(function ($, jQuery, Radfords) {
    'use strict';
    Radfords.products = {
        init: function () {
            var container, form, span;
            form = $('form');
            form.prepend('<div class="error-block"></div>');
            container = $('.error-block');
            container.html('<h4 class="alert-heading"></h4><ul></ul>');
            span = '<span class="control-group error" />';
            form.validate({
                errorClass: 'error-message',
                errorContainer: container,
                errorElement: 'li',
                errorLabelContainer: $('ul', container),
                highlight: function (element) {
                    if ($(element).parent('.control-group.error').length === 0) {
                        $(element).parent().find('label').wrap(span);
                        $(element).wrap(span);
                    }
                },
                messages: {
                    'product[title]': {
                        required: 'Title can\'t be blank',
                        remote: 'Title has already been taken'
                    },
                    'product[description]': 'Description can\'t be blank',
                    'product[image_url]': 'Image url can\'t be blank',
                    'product[price]': {
                        required: 'Price is not a number',
                        number: 'Price is not a number',
                        min: jQuery.format('Price must be greater than or equal to {0}')
                    }
                },
                onclick: false,
                onfocusout: false,
                onkeyup: false,
                rules: {
                    'product[title]': {
                        required: true,
                        remote: {
                            url: '/products/check_title',
                            data: {
                                'product[id]': function () {
                                    return $('#product_id').val();
                                }
                            }
                        }
                    },
                    'product[description]': {
                        required: true
                    },
                    'product[image_url]': {
                        required: true
                    },
                    'product[price]': {
                        required: true,
                        number: true,
                        min: 0.01
                    }
                },
                showErrors: function () {
                    var errors, plural, text;
                    container.addClass('alert alert-block alert-error');
                    errors = this.numberOfInvalids();
                    plural = (errors === 1 ? 'error' : 'errors');
                    text = errors + ' ' + plural + ' prohibited this from being saved:';
                    $('.alert-heading', container).html(text);
                    this.defaultShowErrors();
                },
                unhighlight: function (element) {
                    if ($(element).parent('.control-group.error').length !== 0) {
                        $(element).parents('li').find('label').unwrap(span);
                        $(element).unwrap(span);
                    }
                }
            });
        }
    };
}($, jQuery, Radfords));
