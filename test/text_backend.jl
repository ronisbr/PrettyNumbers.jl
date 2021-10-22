# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Tests related to the text backend.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

@testset "Rational numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, 1986//1987)
        expected = "¹⁹⁸⁶/₁₉₈₇"
        @test result == expected

        result = pretty_number(String, 1234567890//1)
        expected = "¹²³⁴⁵⁶⁷⁸⁹⁰/₁"
        @test result == expected

        result = pretty_number(String, 1//1234567890)
        expected = "¹/₁₂₃₄₅₆₇₈₉₀"
        @test result == expected
    end
end

@testset "Numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, 1.1986e6)
        expected = "1.1986 ⋅ 10⁶"
        @test result == expected

        result = pretty_number(String, 1e0)
        expected = "1"
        @test result == expected

        result = pretty_number(String, 1e0; always_print_base = true)
        expected = "1 ⋅ 10⁰"
        @test result == expected

        result = pretty_number(String, 1e1)
        expected = "1 ⋅ 10¹"
        @test result == expected

        result = pretty_number(String, 1e2)
        expected = "1 ⋅ 10²"
        @test result == expected

        result = pretty_number(String, 1e3)
        expected = "1 ⋅ 10³"
        @test result == expected

        result = pretty_number(String, 1e4)
        expected = "1 ⋅ 10⁴"
        @test result == expected

        result = pretty_number(String, 1e5)
        expected = "1 ⋅ 10⁵"
        @test result == expected

        result = pretty_number(String, 1e6)
        expected = "1 ⋅ 10⁶"
        @test result == expected

        result = pretty_number(String, 1e7)
        expected = "1 ⋅ 10⁷"
        @test result == expected

        result = pretty_number(String, 1e8)
        expected = "1 ⋅ 10⁸"
        @test result == expected

        result = pretty_number(String, 1e9)
        expected = "1 ⋅ 10⁹"
        @test result == expected
    end

    @testset "Significand format" begin
        result = pretty_number(String, 1.19861987e6; significand_format = "%.8f")
        expected = "1.19861987 ⋅ 10⁶"
        @test result == expected
    end

    @testset "Show base and significand" begin
        result = pretty_number(String, 1.19861987e6; show_base = false)
        expected = "1.19862"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            show_base = false,
            significand_format = "%.8f"
        )
        expected = "1.19861987"
        @test result == expected

        result = pretty_number(String, 1.19861987e6; show_significand = false)
        expected = "10⁶"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            show_base = false,
            show_significand = false
        )
        expected = ""

        @test result == expected
    end

    @testset "New decimal base" begin
        result = pretty_number(
            String,
            1.19861987e6;
            new_decimal_base = 7
        )
        expected = "0.119862 ⋅ 10⁷"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            new_decimal_base = 5
        )
        expected = "11.9862 ⋅ 10⁵"
        @test result == expected
    end
end
