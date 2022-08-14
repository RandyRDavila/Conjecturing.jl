using Conjecturing
using Test

@testset "Conjecturing.jl" begin
   # TODO: Add proper testing 
   @test typeof(random_conjecture("data.csv"; use_test_data = true)) == Vector{Any}
   @test typeof(write_on_the_wall("data.csv", "matching_number"; use_test_data = true)) == Vector{Any}
end
