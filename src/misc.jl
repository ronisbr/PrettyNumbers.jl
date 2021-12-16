# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Miscellaneous functions.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

"""
    _get_significand_and_base(number::Number[, new_decimal_base::Integer])

Return the significand and the base of the `number` in base 10. If the parameter
`new_decimal_base` is passed, then the output base is converted to this value.
"""
function _get_significand_and_base(number::Number)
    if abs(number) > 0
        base        = floor(log10(abs(number)))
        significand = number / 10^base
        return significand, base
    else
        return number, 0
    end
end

function _get_significand_and_base(number::Number, new_decimal_base::Integer)
    if abs(number) > 0
        significand, base = _get_significand_and_base(number)
        fact = 10^(new_decimal_base - base)
        significand /=  fact
        return significand, new_decimal_base
    else
        return number, new_decimal_base
    end
end
