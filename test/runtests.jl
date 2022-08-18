using Conjecturing
using Test

@testset "Conjecture" begin
   io = IOBuffer()

   T = UpperBound
   c = Conjecture{T}("f", "g", [], 0, [], "thing", "X")
   s = show(io, c)
   @test String(take!(io)) == "If X is a thing, then f(X) >= g(X)"

   T = LowerBound
   c = Conjecture{T}("f", "g", [], 0, [], "thing", "X")
   s = show(io, c)
   @test String(take!(io)) == "If X is a thing, then f(X) <= g(X)"

   T = UpperBound
   c = Conjecture{T}("f", "g", ["a", "b"], 0, [], "thing", "X")
   s = show(io, c)
   @test String(take!(io)) == "If X is a thing [a, b], then f(X) >= g(X)"
end
