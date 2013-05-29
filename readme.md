# StripeCoffeeScript
A CoffeeScript library for processing credit cards with [Stripe](https://stripe.com).

## Requirements

Requires [jQuery](http://jquery.com/)

You must include the stripe.js file on your page. As of this writing, this is hosted by stripe and can be included with:
`<script type="text/javascript" src="https://js.stripe.com/v2/"></script>`


## Usage

In it's simplest form:

    $(function(){
      new stripe_form("STRIPE_PUBLIC_KEY")
    })


It also takes an optional elements arguement that allows you to specify the elements you used on your form:

    new stripe_form("STRIPE_PUBLIC_KEY", {
      form_element = $('form.payment'),_
      submit_button_element = $('.submit-button')
    })


Possible elements along with their default are:

    form_element = $('form.payment')
    card_number_element = $('.card-number')
    card_cvc_element = $('.card-cvc')
    card_exp_month_element = $('.card-expiry-month')
    card_exp_year_element = $('.card-expiry-year')
    submit_button_element = $('.submit-button')
    payment_errors_element = $('.payment-errors')


If you went crazy:

    new stripe_form("STRIPE_PUBLIC_KEY", {
      form_element = $('form.payment')
      card_number_element = $('.card-number')
      card_cvc_element = $('.card-cvc')
      card_exp_month_element = $('.card-expiry-month')
      card_exp_year_element = $('.card-expiry-year')
      submit_button_element = $('.submit-button')
      payment_errors_element = $('.payment-errors')
    })

#####Errors
If there are any errors, they will be populated in the `payment_errors_element`.

#####Added fields
If there are no errors and a valid token is returned, these three fields are added to the `form_element`:

 `stripe_token` which contians the token returned by Stripe
 `stripe_last4` this contains the last 4 digits of the card number
 `stripe_card_type` this contains the card type.
 
#####Security
Finally, the `card_number_element` and the `card_cvc_element` are removed from the form before submittiing it. This ensures the credit card number never hits your server.


### Version
Current version is 1.0

### Known Issues / Limitations
Currently only supports card number, card CVC, and card expiration month/year. Any other fields aren't used when generating a token.

### Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### License
The MIT License (MIT)

Copyright (c) 2013 Ben McFadden ( https://github.com/mcfadden )

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.