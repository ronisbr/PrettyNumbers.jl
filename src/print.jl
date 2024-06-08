## Description #############################################################################
#
# Main function to print the numbers.
#
############################################################################################

export pretty_number

"""
    pretty_number([io::IO, | String, ]number::Number; backend, kwargs...) -> [Nothing | String]

Pretty print the `number`.

If the first argument is an `io`, the number is printed to it. If it is a `String`, a string
is returned with the printed number. It it is omitted, it defaults to `stdout`.

The number will be printed using the specified `backend`. The following options are
available:

- `Val(:latex)`: LaTeX back end.
- `Val(:text)`: Text back end.


# Keywords

These are the general keywords available in all back ends. Notice that each back end defines
a set of specific keywords as shown in the sections below.

All keywords depends on the type of the `number`.

## Rational

If `number` is `Rational`, the following keywords are available:

- `compact::Bool`: If `true`, the rational number will be printed compactly, in one line
    like `³/₄`. Otherwise, the rational number is printed using multiple lines, like
    (**Default** = `true`):


        123
        ————
        4567

## Numbers

Otherwise, the `number` is printed using the scientific notation in the base 10. In this
case, the following keywords are available:

- `always_print_base::Bool`: If `true`, the base is always printed even if the base exponent
    is 0.
    (**Default** = `false`)
- `significand_format::String`: The format that will be used to print the signifcand, as
    described by the function `Printf.@printf`.
    (**Default** = `"%g"`)
- `show_base::Bool`: If `true`, the base will be printed. Otherwise, it will be omitted.
    (**Default** = `true`)
- `show_significand::Bool`: If `true`, the significand will be printed. Otherwise, it will
    be omitted.
    (**Default** = `true`)
- `new_decimal_base::Union{Nothing, Number}`: If it is a number, the decimal base of the
    number will be converted to this number. If it is `nothing`, the base is not changed.
    (**Default** = `nothing`)

# Keywords for the Text Back End

## Numbers

- `multiplication_sign::Char`: The multiplication sign that will be used between the
    significand and the decimal base, common options are `'⋅'` and `'×'`.
    (**Default** = `'×'`)

# Keywords for the LaTeX Back End

Those keywords apply for the LaTeX back end only and for all supported number types.

- `math_env::Symbol`: The math environment type to wrap the output in if `wrap_in_math_env`
    is `true`. The possible options are `:inline` for inline LaTeX math environment (`\$`),
    or `:equation` for using `\begin{equation} .. \end{equation}`.
    (**Default**: `:inline`)
- `wrap_in_math_env::Bool`: If `true`, the output will be wrapped in a math environment. The
    user can select which environment the function will use in the keyword `math_env`.
    (**Default**: `false`)

## Numbers

- `multiplication_sign::Symbol`: The multiplication sign that will be used between the
    significand and the decimal base, common options are `\\cdot` and `\\times`.
    (**Default** = `"\\times"`)

# Extended Help

## Examples

### Text Back End

```julia
julia> pretty_number(19//86)
¹⁹/₈₆

julia> pretty_number(19//86; compact = false)
19
——
86

julia> pretty_number(1906.1896)
1.90619 × 10³

julia> pretty_number(1906.1896; significand_format = "%.10f")
1.9061896000 × 10³

julia> pretty_number(1906.1896; new_decimal_base = 4)
0.190619 × 10⁴
```

### LaTeX Back End

```julia
julia> pretty_number(19//86; backend = Val(:latex))
^{19}/_{86}

julia> pretty_number(19//86; backend = Val(:latex), compact = false)
\\frac{19}{86}

julia> pretty_number(1906.1896; backend = Val(:latex))
1.90619 \\times 10^{3}

julia> pretty_number(1906.1896; backend = Val(:latex), significand_format = "%.10f")
1.9061896000 \\times 10^{3}

julia> pretty_number(1906.1896; backend = Val(:latex), new_decimal_base = 4)
0.190619 \\times 10^{4}
```
"""
function pretty_number(number::Number; kwargs...)
    return pretty_number(stdout, number; kwargs...)
end

function pretty_number(
    io::IO,
    number::Number;
    backend::Backend = Val(:text),
    kwargs...
)
    if backend === Val(:text)
        _pn_text(io, number; kwargs...)
    elseif backend === Val(:latex)
        _pn_latex(io, number; kwargs...)
    end

    return nothing
end

function pretty_number(::Type{String}, number::Number; kwargs...)
    io = IOBuffer()
    pretty_number(io, number; kwargs...)
    str = String(take!(io))
    return str
end
