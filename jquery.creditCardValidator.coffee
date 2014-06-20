###
jQuery Credit Card Validator

Copyright 2012 Pawel Decowski

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
Unported License. To view a copy of this license, visit:

http://creativecommons.org/licenses/by-sa/3.0/

or send a letter to:

Creative Commons, 444 Castro Street, Suite 900,
Mountain View, California, 94041, USA.
###

$ = jQuery

$.fn.validateCreditCard = (callback, options) ->
    card_types = [
        {
            name: 'amex'
            pattern: /^3[47]/
            valid_length: [ 15 ]
        }
        {
            name: 'diners_club_carte_blanche'
            pattern: /^30[0-5]/
            valid_length: [ 14 ]
        }
        {
            name: 'diners_club_international'
            pattern: /^36/
            valid_length: [ 14 ]
        }
        {
            name: 'jcb'
            pattern: /^35(2[89]|[3-8][0-9])/
            valid_length: [ 16 ]
        }
        {
            name: 'laser'
            pattern: /^(6304|670[69]|6771)/
            valid_length: [ 16..19 ]
        }
        {
            name: 'visa_debit'
            pattern: /^(400626|40770(4|5)|408367|40845(6|7)|40940[0-2]|41228(5|6)|41378(7|8)|418760|41917[6-9]|419772|419776|420672|42159[2-4]|421682|423769|431072|43253(4|5)|441078|444001|44400(5|6)|444008|4462(0[0-9]|1[0,1])|4462(1[3-9]|[2-4][0-9]|5[0-4])|4462(5[7-9]|6[0-9]|7[0-2])|4462(7[4-9]|8[0-3])|446286|44629(1|2)|446294|450875|45397(8|9)|454313|45443[2-5]|454742|45670(5|6)|4567(2[5-9]|3[0-9]|4[0-5])|458046|459305|4593(3(8|9)|40)|459362|459364|459389|459470|459(499|50[01])|45951[12]|459545|45956[6-8]|459[67][0-9]{2}|459847|460024|4658[3-7][0-9]|4659(0[1-9]|[1-4][0-9]|50)|472628|472684|474503|474551|4751[1-5][0-9]|475183|4757[1-5][0-9]|4762[2-6][0-9]|4763[4-8][0-9]|480240|484412|484415|484417|484427|489342|4909[67][0-9]|49218[12]|492912|495065|495067|49509[0-4]|498824|499806|49984[4-6]|499902)/
            valid_length: [ 16..19 ]
        }
        {
            name: 'visa_electron'
            pattern: /^(4026|417500|4508|4844|491(3|7)|400115|40083[7-9]|41292[1-3]|417935|41974[0-1]|41977[3-5]|424519|42496[23]|437860|444000|459472|4844(0[6-9]|1[01])|48441[34]|4844(1[89]|2[0-6])|4844(2[89]|[34][0-9]|5[0-5])|4917[3-5][0-9])/
            valid_length: [ 16..19 ]
        }
        {
            name: 'visa'
            pattern: /^4/
            valid_length: [ 16..19 ]
        }
        {
            name: 'mastercard'
            pattern: /^5[1-5]/
            valid_length: [ 16 ]
        }
        {
            name: 'maestro'
            pattern: /^(5018|5020|5038|6304|6759|676[1-3])/
            valid_length: [ 12..19 ]
        }
        {
            name: 'discover'
            pattern: /^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)/
            valid_length: [ 16 ]
        }
    ]

    options ?= {}

    options.accept ?= (card.name for card in card_types)

    for card_type in options.accept
        if card_type not in (card.name for card in card_types)
            throw "Credit card type '#{ card_type }' is not supported"

    get_card_type = (number) ->
        for card_type in (card for card in card_types when card.name in options.accept)
            if number.match card_type.pattern
                return card_type

        null

    is_valid_luhn = (number) ->
        sum = 0

        for digit, n in number.split('').reverse()
            digit = +digit # the + casts the string to int
            if n % 2
                digit *= 2
                if digit < 10 then sum += digit else sum += digit - 9
            else
                sum += digit

        sum % 10 == 0

    is_valid_length = (number, card_type) ->
        number.length in card_type.valid_length

    validate_number = (number) ->
        card_type = get_card_type number
        luhn_valid = false
        length_valid = false

        if card_type?
            luhn_valid = is_valid_luhn number
            length_valid = is_valid_length number, card_type

        callback
            card_type: card_type
            luhn_valid: luhn_valid
            length_valid: length_valid

    validate = ->
        number = normalize $(this).val()
        validate_number number

    normalize = (number) ->
        number.replace /[ -]/g, ''

    this.bind('input', ->
        $(this).unbind('keyup') # if input event is fired (so is supported) then unbind keyup
        validate.call this
    )

    # bind keyup in case input event isn't supported
    this.bind('keyup', ->
        validate.call this
    )

    # run validation straight away in case the card number is prefilled
    validate.call this unless this.length is 0

    this
###
jQuery Credit Card Validator

Copyright 2012 Pawel Decowski

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
Unported License. To view a copy of this license, visit:

http://creativecommons.org/licenses/by-sa/3.0/

or send a letter to:

Creative Commons, 444 Castro Street, Suite 900,
Mountain View, California, 94041, USA.
###

$ = jQuery

$.fn.validateCreditCard = (callback, options) ->
    card_types = [
        {
            name: 'amex'
            pattern: /^3[47]/
            valid_length: [ 15 ]
        }
        {
            name: 'diners_club_carte_blanche'
            pattern: /^30[0-5]/
            valid_length: [ 14 ]
        }
        {
            name: 'diners_club_international'
            pattern: /^36/
            valid_length: [ 14 ]
        }
        {
            name: 'jcb'
            pattern: /^35(2[89]|[3-8][0-9])/
            valid_length: [ 16 ]
        }
        {
            name: 'laser'
            pattern: /^(6304|670[69]|6771)/
            valid_length: [ 16..19 ]
        }
        {
            name: 'visa_electron'
            pattern: /^(4026|417500|4508|4844|491(3|7))/
            valid_length: [ 16 ]
        }
        {
            name: 'visa'
            pattern: /^4/
            valid_length: [ 16 ]
        }
        {
            name: 'mastercard'
            pattern: /^5[1-5]/
            valid_length: [ 16 ]
        }
        {
            name: 'maestro'
            pattern: /^(5018|5020|5038|6304|6759|676[1-3])/
            valid_length: [ 12..19 ]
        }
        {
            name: 'discover'
            pattern: /^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)/
            valid_length: [ 16 ]
        }
    ]

    options ?= {}

    options.accept ?= (card.name for card in card_types)

    for card_type in options.accept
        if card_type not in (card.name for card in card_types)
            throw "Credit card type '#{ card_type }' is not supported"

    get_card_type = (number) ->
        for card_type in (card for card in card_types when card.name in options.accept)
            if number.match card_type.pattern
                return card_type

        null

    is_valid_luhn = (number) ->
        sum = 0

        for digit, n in number.split('').reverse()
            digit = +digit # the + casts the string to int
            if n % 2
                digit *= 2
                if digit < 10 then sum += digit else sum += digit - 9
            else
                sum += digit

        sum % 10 == 0

    is_valid_length = (number, card_type) ->
        number.length in card_type.valid_length

    validate_number = (number) ->
        card_type = get_card_type number
        luhn_valid = false
        length_valid = false

        if card_type?
            luhn_valid = is_valid_luhn number
            length_valid = is_valid_length number, card_type

        callback
            card_type: card_type
            luhn_valid: luhn_valid
            length_valid: length_valid

    validate = ->
        number = normalize $(this).val()
        validate_number number

    normalize = (number) ->
        number.replace /[ -]/g, ''

    this.bind('input', ->
        $(this).unbind('keyup') # if input event is fired (so is supported) then unbind keyup
        validate.call this
    )

    # bind keyup in case input event isn't supported
    this.bind('keyup', ->
        validate.call this
    )

    # run validation straight away in case the card number is prefilled
    validate.call this unless this.length is 0

    this
