# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Main function to print the numbers.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

export pretty_number

"""
    pretty_number([io::IO, | String, ]number::Number; kwargs...)

Print the `number`.

If the first argument is an `io`, then the number is printed to it. If it is
a `String`, then a string is returned with the printed number. It it is omitted,
then it defaults to `stdout`.

# Keywords

The following keywords are available to modify the number printing. Those
arguments depends on the type of the number.

## Rational

If `number` is `Rational`, then the following keywords are available:

- `compact::Bool`: If `true`, then the rational number will be printed
    compactly, in one line like `³/₄`. Otherwise, the rational number is printed
    using multiple lines, like (**Default** = `true`):


        123
        ————
        4567

## Numbers

Otherwise, the `number` is printed using the scientific notation in the base 10.
In this case, the following keywords are available:

- `always_print_base::Bool`: If `true`, then the base is always printed even if
    the base exponent is 0. (**Default** = `false`)
- `multiplication_sign::Char`: The multiplication sign that will be used between
    the significand and the decimal base, common options are `'⋅'` and `'×'`.
    (**Default** = `'×'`)
- `significand_format::String`: The format that will be used to print the
    signifcand, as described by the function [`Printf.@printf`](@ref).
    (**Default** = `"%g"`)
- `show_base::Bool`: If `true`, then the base will be printed. Otherwise, it
    will be omitted. (**Default** = `true`)
- `show_significand::Bool`: If `true`, then the significand will be printed.
    Otherwise, it will be omitted. (**Default** = `true`)
- `new_decimal_base::Union{Nothing, Number}`: If it is a number, then the
    decimal base of the number will be converted to this number. If it is
    `nothing`, then the base is not changed. (**Default** = `nothing`)

# Examples

```julia
julia> pretty_number(19//86)
¹⁹/₈₆

julia> pretty_number(19//86; compact = false)
19
——
86

julia> pretty_number(1906.1896)
1.90619 · 10³

julia> pretty_number(1906.1896, significand_format = "%.10f")
1.9061896000 · 10³

julia> pretty_number(1906.1896; new_decimal_base = 4)
0.190619 · 10⁴
```
"""
function pretty_number(number::Number; kwargs...)
    return pretty_number(stdout, number; kwargs...)
end

function pretty_number(io::IO, number::Number; kwargs...)
    _pn_text(io, number; kwargs...)
    return nothing
end

function pretty_number(::Type{String}, number::Number; kwargs...)
    io = IOBuffer()
    pretty_number(io, number; kwargs...)
    str = String(take!(io))
    return str
end
