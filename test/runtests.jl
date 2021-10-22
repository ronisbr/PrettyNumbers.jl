using Test
using PrettyNumbers

@testset "General test" verbose = true begin
    include("./general.jl")
end

@testset "Text backend" verbose = true begin
    include("./text_backend.jl")
end
