using Conjecturing
using Test

@testset "Conjecturing.jl" begin
    # Write your tests here.
    Conjecturing.greet_your_package_name()
    @test Conjecturing.greet_your_package_name() == "Hello Conjecturing!"
    #@test Conjecturing.greet_your_package_name() != "Hello world!"
end
