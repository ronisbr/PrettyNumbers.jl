using Test
using PrettyNumbers

@testset "General test" verbose = true begin
    include("./general.jl")
end

@testset "LaTeX Back End" verbose = true begin
    include("./latex_backend.jl")
end

@testset "Text Back End" verbose = true begin
    include("./text_backend.jl")
end
