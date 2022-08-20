using Conjecturing
using CSV
using Test

@testset "Conjecturing" begin

   @testset "Statistic" begin
      io = IOBuffer()

      name = "stat"
      values = [1, 2, 3]
      s = Statistic(name, values)
      out = show(io, s)
      @test String(take!(io)) == "Statistic{Int64}(\"$name\", $(repr(values)))"
   end

   @testset "Data" begin
      data = """
      a,b,c
      0,1,2
      1,2,3
      """
      types = Dict(
         "a" => Bool,
         "b" => Int64,
         "c" => Float64,
      )
      csv = CSV.File(IOBuffer(data); types=types)
      stats = Conjecturing.get_statistics(csv)
      @test typeof(stats) == Vector{Statistic}
      @test length(stats) == 2
      @test stats[1].name == "b"
      @test stats[1].values == [1, 2]
      @test stats[2].name == "c"
      @test stats[2].values == [2, 3]
   end

   @testset "Conjecture" begin
      io = IOBuffer()

      T = UpperBound
      c = Conjecture{T}(Statistic("f", [1,]), "g", [], 0, [], "thing")
      out = show(io, c)
      @test String(take!(io)) == "thing ⟹  f >= g"

      T = LowerBound
      c = Conjecture{T}(Statistic("f", [1,]), "g", [], 0, [], "thing")
      out = show(io, c)
      @test String(take!(io)) == "thing ⟹  f <= g"

      T = UpperBound
      c = Conjecture{T}(Statistic("f", [1,]), "g", ["a", "b"], 0, [], "thing")
      out = show(io, c)
      @test String(take!(io)) == "thing(a, b) ⟹  f >= g"
   end

   @testset "Generate" begin
      X1 = [1, 2, 3]
      y1 = [1, 2, 3]
      T1 = UpperBound
      m1, b1 = Conjecturing.find_slope_intercept(X1, y1, T1)
      @test m1 ≈ 1.0
      @test b1 == 0.0

      X2 = [1, 2, 3]
      y2 = [1, 2, 3]
      T2 = LowerBound
      m2, b2 = Conjecturing.find_slope_intercept(X2, y2, T2)
      @test m2 ≈ 1.0
      @test b2 == 0.0

      X3 = [1, 2, 3]
      y3 = [2, 4, 6]
      T3 = UpperBound
      m3, b3 = Conjecturing.find_slope_intercept(X3, y3, T3)
      @test m3 ≈ 2.0
      @test b3 == 0.0

      X4 = [1, 2, 3]
      y4 = [2, 4, 6]
      T4 = LowerBound
      m4, b4 = Conjecturing.find_slope_intercept(X4, y4, T4)
      @test m4 ≈ 2.0
      @test b4 == 0.0

      X5 = [1, 2, 3]
      y5 = [2, 3, 4]
      T5 = UpperBound
      m5, b5 = Conjecturing.find_slope_intercept(X5, y5, T5)
      @test m5 ≈ 1.0
      @test b5 == 1.0

      X6 = [2, 4, 6]
      y6 = [1, 2, 3]
      T6 = LowerBound
      m6, b6 = Conjecturing.find_slope_intercept(X6, y6, T6)
      @test m6 ≈ 0.5
      @test b6 == 0.0

      X7 = [2, 4, 6]
      y7 = [1, 2, 3]
      T7 = UpperBound
      m7, b7 = Conjecturing.find_slope_intercept(X7, y7, T7)
      @test m7 ≈ 0.5
      @test b7 == 0.0

      X8 = [1, 2, 3]
      y8 = [2, 3, 4]
      T8 = LowerBound
      m8, b8 = Conjecturing.find_slope_intercept(X8, y8, T8)
      @test m8 ≈ 1.0
      @test b8 == 1.0

      X9 = [2, 3, 4]
      y9 = [1, 2, 3]
      T9 = UpperBound
      m9, b9 = Conjecturing.find_slope_intercept(X9, y9, T9)
      @test m9 ≈ 1.0
      @test b9 == -1.0

      X10 = [2, 3, 4]
      y10 = [1, 2, 3]
      T10 = LowerBound
      m10, b10 = Conjecturing.find_slope_intercept(X10, y10, T10)
      @test m10 ≈ 1.0
      @test b10 == -1.0

      c = Conjecturing.conjecture(UpperBound, [], "thing", Statistic("f", [1,]), Statistic("g", [1,]))
      @test typeof(c) == Conjecture{UpperBound}
      @test c.objects == []
      @test c.object_type == "thing"
      @test c.expression == "1//1*g + 0//1"
      @test c.hypotheses == []
      @test c.touch_number == 1
      @test c.target.name == "f"
      @test c.target.values == [1,]
   end

end
