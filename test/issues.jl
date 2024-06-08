## Description #############################################################################
#
# Issues.
#
############################################################################################

@testset "Printing to Text Back End with `always_print_base`" begin
    result = pretty_number(String, 1906.1894; always_print_base = true)
    expected = "1.90619 × 10³"
    @test result == expected
end
