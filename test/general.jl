# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   General tests.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

@testset "stdout" begin
    old_stdout = stdout

    in, out = redirect_stdout()
    pretty_number(1.19861987e6)
    result = String(readavailable(in))
    redirect_stdout(old_stdout)

    expected = "1.19862 ⋅ 10⁶"

    @test result == expected
end

