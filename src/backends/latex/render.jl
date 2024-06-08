## Description #############################################################################
#
# Function to render numbers in LaTeX back end.
#
############################################################################################

function _render_number_latex(number::Rational; compact::Bool = true)
    sign = number.num ≥ 0 ? "" : "-"
    if compact
        num_str = "$sign^{$(abs(number.num))}/_{$(number.den)}"
    else
        num_str = "$sign\\frac{$(abs(number.num))}{$(number.den)}"
    end

    return num_str
end

function _render_number_latex(number::Irrational; kwargs...)
    num_str = if number === π
        "\\pi"
    elseif number === ℯ
        "e"
    else
        string(number)
    end

    return num_str
end

function _render_number_latex(
    number::Number;
    always_print_base::Bool,
    multiplication_sign::String,
    significand_format::String,
    show_base::Bool,
    show_significand::Bool,
    new_decimal_base::Union{Nothing, Number}
)
    # Get the significand and the base.
    if new_decimal_base !== nothing
        significand, base = _get_significand_and_base(number, new_decimal_base)
    else
        significand, base = _get_significand_and_base(number)
    end

    # == Significand =======================================================================

    significand_str = ""

    if show_significand
        fmt = Printf.Format(significand_format)
        significand_str = Printf.format(fmt, significand)
    end

    # == Base ==============================================================================

    # If `base` is 0, only show it if the user wants.
    base_str = ""

    if show_base && ((base != 0) || always_print_base)
        # Create the string representation.
        base_str = if base == 0
            "10^{0}"
        else
            "10^{" * string(round(Int, base)) * "}"
        end

        if show_significand
            base_str = " " * multiplication_sign * " " * base_str
        end
    end

    # == Output ============================================================================

    number_str = significand_str * base_str

    return number_str
end
