## Description #############################################################################
#
# Function to print the numbers using the LaTeX back end.
#
############################################################################################

# Printing function for the LaTeX back end.
function _pn_latex(
    io::IO,
    number::Number;
    always_print_base::Bool = false,
    compact::Bool = true,
    math_env::Symbol = :inline,
    multiplication_sign::String = "\\times",
    new_decimal_base::Union{Nothing, Number} = nothing,
    show_base::Bool = true,
    show_significand::Bool = true,
    significand_format::String = "%g",
    wrap_in_math_env::Bool = false
)
    number_str = if number isa Rational
        _render_number_latex(number; compact)
    else
        _render_number_latex(
            number;
            always_print_base,
            multiplication_sign,
            new_decimal_base,
            significand_format,
            show_base,
            show_significand
        )
    end

    if wrap_in_math_env
        number_str = if math_env == :equation
            """
            \\begin{equation}
              $number_str
            \\end{equation}"""
        else
            '$' * number_str * '$'
        end
    end

    print(io, number_str)
    return nothing
end
