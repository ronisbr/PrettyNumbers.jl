## Description #############################################################################
#
# Tests related to the LaTeX back end.
#
############################################################################################

@testset "Rational numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, 1986//1987; backend = Val(:latex))
        expected = "^{1986}/_{1987}"
        @test result == expected

        result = pretty_number(String, 1234567890//1; backend = Val(:latex))
        expected = "^{1234567890}/_{1}"
        @test result == expected

        result = pretty_number(String, 1//1234567890; backend = Val(:latex))
        expected = "^{1}/_{1234567890}"
        @test result == expected

        result = pretty_number(String, -1986//1987; backend = Val(:latex))
        expected = "-^{1986}/_{1987}"
        @test result == expected

        result = pretty_number(String, -1234567890//1; backend = Val(:latex))
        expected = "-^{1234567890}/_{1}"
        @test result == expected

        result = pretty_number(String, -1//1234567890; backend = Val(:latex))
        expected = "-^{1}/_{1234567890}"
        @test result == expected
    end

    @testset "Compact" begin
        result = pretty_number(String, 1986//1987; backend = Val(:latex), compact = false)
        expected = "\\frac{1986}{1987}"
        @test result == expected

        result = pretty_number(String, -1986//1987; backend = Val(:latex), compact = false)
        expected = "-\\frac{1986}{1987}"
        @test result == expected
    end
end

@testset "Irrational numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, π; backend = Val(:latex))
        @test result == "\\pi"

        result = pretty_number(String, ℯ; backend = Val(:latex))
        @test result == "e"
    end
end

@testset "Numbers" verbose = true begin
    @testset "Default" begin
        result = pretty_number(String, 1.1986e6; backend = Val(:latex))
        expected = "1.1986 \\times 10^{6}"
        @test result == expected

        result = pretty_number(String, 0; backend = Val(:latex))
        expected = "0"
        @test result == expected

        result = pretty_number(String, 1e0; backend = Val(:latex))
        expected = "1"
        @test result == expected

        result = pretty_number(String, 1e0; always_print_base = true, backend = Val(:latex))
        expected = "1 \\times 10^{0}"
        @test result == expected

        result = pretty_number(String, 1e1; backend = Val(:latex))
        expected = "1 \\times 10^{1}"
        @test result == expected

        result = pretty_number(String, 1e2; backend = Val(:latex))
        expected = "1 \\times 10^{2}"
        @test result == expected

        result = pretty_number(String, 1e3; backend = Val(:latex))
        expected = "1 \\times 10^{3}"
        @test result == expected

        result = pretty_number(String, 1e4; backend = Val(:latex))
        expected = "1 \\times 10^{4}"
        @test result == expected

        result = pretty_number(String, 1e5; backend = Val(:latex))
        expected = "1 \\times 10^{5}"
        @test result == expected

        result = pretty_number(String, 1e6; backend = Val(:latex))
        expected = "1 \\times 10^{6}"
        @test result == expected

        result = pretty_number(String, 1e7; backend = Val(:latex))
        expected = "1 \\times 10^{7}"
        @test result == expected

        result = pretty_number(String, 1e8; backend = Val(:latex))
        expected = "1 \\times 10^{8}"
        @test result == expected

        result = pretty_number(String, 1e9; backend = Val(:latex))
        expected = "1 \\times 10^{9}"
        @test result == expected

        result = pretty_number(String, 1e-1; backend = Val(:latex))
        expected = "1 \\times 10^{-1}"
        @test result == expected

        result = pretty_number(String, 1e-2; backend = Val(:latex))
        expected = "1 \\times 10^{-2}"
        @test result == expected

        result = pretty_number(String, 1e-3; backend = Val(:latex))
        expected = "1 \\times 10^{-3}"
        @test result == expected

        result = pretty_number(String, 1e-4; backend = Val(:latex))
        expected = "1 \\times 10^{-4}"
        @test result == expected

        result = pretty_number(String, 1e-5; backend = Val(:latex))
        expected = "1 \\times 10^{-5}"
        @test result == expected

        result = pretty_number(String, 1e-6; backend = Val(:latex))
        expected = "1 \\times 10^{-6}"
        @test result == expected

        result = pretty_number(String, 1e-7; backend = Val(:latex))
        expected = "1 \\times 10^{-7}"
        @test result == expected

        result = pretty_number(String, 1e-8; backend = Val(:latex))
        expected = "1 \\times 10^{-8}"
        @test result == expected

        result = pretty_number(String, 1e-9; backend = Val(:latex))
        expected = "1 \\times 10^{-9}"
        @test result == expected
    end

    @testset "Significand format" begin
        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            significand_format = "%.8f"
        )
        expected = "1.19861987 \\times 10^{6}"
        @test result == expected
    end

    @testset "Show base and significand" begin
        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            show_base = false
        )
        expected = "1.19862"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            show_base = false,
            significand_format = "%.8f"
        )
        expected = "1.19861987"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            show_significand = false
        )
        expected = "10^{6}"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
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
            backend = Val(:latex),
            new_decimal_base = 7
        )
        expected = "0.119862 \\times 10^{7}"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            new_decimal_base = 5
        )
        expected = "11.9862 \\times 10^{5}"
        @test result == expected

        result = pretty_number(
            String,
            0;
            backend = Val(:latex),
            new_decimal_base = 6
        )
        expected = "0 \\times 10^{6}"
        @test result == expected
    end

    @testset "Multiplication sign" begin
        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            multiplication_sign = "\\cdot"
        )
        expected = "1.19862 \\cdot 10^{6}"
        @test result == expected

        result = pretty_number(
            String,
            1.19861987e6;
            backend = Val(:latex),
            multiplication_sign = "\\cdot",
            new_decimal_base = 5
        )
        expected = "11.9862 \\cdot 10^{5}"
        @test result == expected
    end
end
