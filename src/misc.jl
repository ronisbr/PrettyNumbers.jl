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
    base        = floor(log10(abs(number)))
    significand = number / 10^base
    return significand, base
end

function _get_significand_and_base(number::Number, new_decimal_base::Integer)
    significand, base = _get_significand_and_base(number)
    fact = 10^(new_decimal_base - base)
    significand /=  fact
    return significand, new_decimal_base
end
