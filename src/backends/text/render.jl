# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Functions to render the numbers in text backend.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function _render_number_text(
    number::Rational;
    compact::Bool = true
)
    if compact
        aux = abs(number.num)
        num_str = ""

        while aux ≥ 1
            i = aux % 10
            num_str = _EXPONENTS[i + 1] * num_str
            aux = floor(aux / 10)
        end

        aux = abs(number.den)
        den_str = ""

        while aux ≥ 1
            i = aux % 10
            den_str = _SUBNUMBERS[i + 1] * den_str
            aux = floor(aux / 10)
        end

        number_str = (number.num ≥ 0 ? "" : "- ") * num_str * "/" * den_str

        return number_str
    else
        num_str = sprint(print, abs(number.num))
        den_str = sprint(print, abs(number.den))

        num_width = textwidth(num_str)
        den_width = textwidth(den_str)

        fraction_width = max(num_width, den_width)

        # Align the numbers in the center.
        Δ = div(fraction_width - num_width, 2)
        num_str = " "^Δ * num_str

        Δ = div(fraction_width - den_width, 2)
        den_str = " "^Δ * den_str

        # Check if the fraction is negative. In this case, we must change the
        # alignemnt.
        is_neg = number.num < 0

        num_str  = (!is_neg ? "" : "  ") * num_str * "\n"
        num_str *= (!is_neg ? "" : "- ") * "—"^fraction_width * "\n"
        num_str *= (!is_neg ? "" : "  ") * den_str

        return num_str
    end
end

function _render_number_text(number::Irrational; kwargs...)
    return string(number)
end

function _render_number_text(
    number::Number;
    always_print_base::Bool = false,
    multiplication_sign::Char = '×',
    significand_format::String = "%g",
    show_base::Bool = true,
    show_significand::Bool = true,
    new_decimal_base::Union{Nothing, Number} = nothing
)
    # Get the significand and the base.
    if new_decimal_base !== nothing
        significand, base = _get_significand_and_base(number, new_decimal_base)
    else
        significand, base = _get_significand_and_base(number)
    end

    # Significand
    # ==========================================================================

    significand_str = ""

    if show_significand
        fmt = Printf.Format(significand_format)
        significand_str = Printf.format(fmt, significand)
    end

    # Base
    # ==========================================================================

    # If `base` is 0, then only show it if the user wants.
    base_str = ""

    if show_base && ((base != 0) || always_print_base)
        # Create the string representation.
        aux = abs(base)
        exponent_str = ""

        while aux ≥ 1
            i = aux % 10
            exponent_str = _EXPONENTS[i + 1] * exponent_str
            aux = floor(aux / 10)
        end

        # If `exponent_str` is empty, then the base is 0.
        if always_print_base
            exponent_str = "⁰"
        end

        if base < 0
            exponent_str = "⁻" * exponent_str
        end

        if show_significand
            base_str *= " " * multiplication_sign * " "
        end

        base_str *= "10" * exponent_str
    end

    # Output
    # ==========================================================================

    number_str = significand_str * base_str

    return number_str
end
