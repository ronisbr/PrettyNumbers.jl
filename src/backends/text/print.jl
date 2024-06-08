## Description #############################################################################
#
# Functions to print the numbers using the text back end.
#
############################################################################################

# Printing function for the text back end.
function _pn_text(
    io::IO,
    number::Number;
    always_print_base::Bool = false,
    compact::Bool = true,
    significand_format::String = "%g",
    show_base::Bool = true,
    show_significand::Bool = true,
    multiplication_sign::Char = '×',
    new_decimal_base::Union{Nothing, Number} = nothing
)
    if number isa Rational
        number_str = _render_number_text(number; compact)
    else
        number_str = _render_number_text(
            number;
            always_print_base,
            multiplication_sign,
            new_decimal_base,
            significand_format,
            show_base,
            show_significand
        )
    end

    # == Output to the IO buffer ===========================================================

    print(io, number_str)

    return nothing
end
