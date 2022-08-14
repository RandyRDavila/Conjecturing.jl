using Conjecturing
using Test

@testset "Conjecturing.jl" begin
   # TODO: Add proper testing 
   @test typeof(surprise_me("data.csv"; use_test_data = true)) == Vector{Any}
   @test typeof(write_to_me("data.csv", "matching_number"; use_test_data = true)) == Vector{Any}
end
