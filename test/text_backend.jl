## Description #############################################################################
#
# Tests related to the text backend.
#
############################################################################################

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

        result = pretty_number(String, -1986//1987)
        expected = "- ¹⁹⁸⁶/₁₉₈₇"
        @test result == expected

        result = pretty_number(String, -1234567890//1)
        expected = "- ¹²³⁴⁵⁶⁷⁸⁹⁰/₁"
        @test result == expected

        result = pretty_number(String, -1//1234567890)
        expected = "- ¹/₁₂₃₄₅₆₇₈₉₀"
        @test result == expected
    end

    @testset "Compact" begin
        result = pretty_number(String, 1986//1987; compact = false)
        expected = """
        1986
        ————
        1987"""
        @test result == expected

        result = pretty_number(String, -1986//1987; compact = false)
        expected = """
          1986
        - ————
          1987"""
        @test result == expected
    end
end

@testset "Irrational numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, π)
        @test result == "π"

        result = pretty_number(String, ℯ)
        @test result == "ℯ"
    end
end

@testset "Numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, 1.1986e6)
        expected = "1.1986 × 10⁶"
        @test result == expected

        result = pretty_number(String, 0)
        expected = "0"
        @test result == expected

        result = pretty_number(String, 1e0)
        expected = "1"
        @test result == expected

        result = pretty_number(String, 1e0; always_print_base = true)
        expected = "1 × 10⁰"
        @test result == expected

        result = pretty_number(String, 1e1)
        expected = "1 × 10¹"
        @test result == expected

        result = pretty_number(String, 1e2)
        expected = "1 × 10²"
        @test result == expected

        result = pretty_number(String, 1e3)
        expected = "1 × 10³"
        @test result == expected

        result = pretty_number(String, 1e4)
        expected = "1 × 10⁴"
        @test result == expected

        result = pretty_number(String, 1e5)
        expected = "1 × 10⁵"
        @test result == expected

        result = pretty_number(String, 1e6)
        expected = "1 × 10⁶"
        @test result == expected

        result = pretty_number(String, 1e7)
        expected = "1 × 10⁷"
        @test result == expected

        result = pretty_number(String, 1e8)
        expected = "1 × 10⁸"
        @test result == expected

        result = pretty_number(String, 1e9)
        expected = "1 × 10⁹"
        @test result == expected

        result = pretty_number(String, 1e-1)
        expected = "1 × 10⁻¹"
        @test result == expected

        result = pretty_number(String, 1e-2)
        expected = "1 × 10⁻²"
        @test result == expected

        result = pretty_number(String, 1e-3)
        expected = "1 × 10⁻³"
        @test result == expected

        result = pretty_number(String, 1e-4)
        expected = "1 × 10⁻⁴"
        @test result == expected

        result = pretty_number(String, 1e-5)
        expected = "1 × 10⁻⁵"
        @test result == expected

        result = pretty_number(String, 1e-6)
        expected = "1 × 10⁻⁶"
        @test result == expected

        result = pretty_number(String, 1e-7)
        expected = "1 × 10⁻⁷"
        @test result == expected

        result = pretty_number(String, 1e-8)
        expected = "1 × 10⁻⁸"
        @test result == expected

        result = pretty_number(String, 1e-9)
        expected = "1 × 10⁻⁹"
        @test result == expected
    end

    @testset "Significand format" begin
        result = pretty_number(String, 1.19861987e6; significand_format = "%.8f")
        expected = "1.19861987 × 10⁶"
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
        expected = "0.119862 × 10⁷"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            new_decimal_base = 5
        )
        expected = "11.9862 × 10⁵"
        @test result == expected

        result = pretty_number(
            String,
            0,
            new_decimal_base = 6
        )
        expected = "0 × 10⁶"
        @test result == expected
    end

    @testset "Multiplication sign" begin
        result = pretty_number(
            String,
            1.19861987e6;
            multiplication_sign = '⋅'
        )
        expected = "1.19862 ⋅ 10⁶"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            multiplication_sign = '⋅',
            new_decimal_base = 5
        )
        expected = "11.9862 ⋅ 10⁵"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            multiplication_sign = '❌'
        )
        expected = "1.19862 ❌ 10⁶"
        @test result == expected
    end
end
