# Copyright (c) 2013 Ben McFadden ( https://github.com/mcfadden )
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


class @stripe_form
  constructor: (stripe_public_key, {@form_element, @card_number_element, @card_cvc_element, @exp_month_element, @exp_year_element, @submit_button_element, @payment_errors_element} = {}) ->
    @form_element ?= $('form.payment')
    @card_number_element ?= $('.card-number')
    @card_cvc_element ?= $('.card-cvc')
    @card_exp_month_element ?= $('.card-expiry-month')
    @card_exp_year_element ?= $('.card-expiry-year')
    @submit_button_element ?= $('.submit-button')
    @payment_errors_element ?= $('.payment-errors')
    
    Stripe.setPublishableKey(stripe_public_key)
    this.setup_stripe_form_submit_handler()
  
  stripe_response_handler: (status, response) ->
    if response.error
      # re-enable the submit button
      this.submit_button_element.removeAttr "disabled"
      # show the errors on the form
      this.payment_errors_element.html(response.error.message).show()
    else
      # response contains id, last4, and card type
      this.form_element.append("<input type='hidden' name='stripe_token' value='" + response['id'] + "' />")
      this.form_element.append("<input type='hidden' name='stripe_last4' value='" + response['card']['last4'] + "' />")
      this.form_element.append("<input type='hidden' name='stripe_card_type' value='" + response['card']['type'] + "' />")
      this.card_number_element.remove()
      this.card_cvc_element.remove()
      # and submit the form
      this.form_element.get(0).submit();
  
  setup_stripe_form_submit_handler: ->
    self = this
    this.form_element.submit (event) ->
      event.preventDefault() #don't submit the form
      self.stripe_form_submit_handler()
      false #really... don't submit the form
    
  stripe_form_submit_handler: -> 
    self = this
    this.submit_button_element.attr("disabled", "disabled")
    Stripe.createToken {
        number: this.card_number_element.val(),
        cvc: this.card_cvc_element.val(),
        exp_month: this.card_exp_month_element.val(),
        exp_year: this.card_exp_year_element.val()
      },
      (status, response) ->
        self.stripe_response_handler(status, response)