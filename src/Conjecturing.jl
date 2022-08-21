module Conjecturing

using CSV
using Combinatorics
using GLPK
using JuMP

include("statistic.jl")
include("property.jl")
include("data.jl")
include("conjecture.jl")
include("filters.jl")
include("generate.jl")

export Statistic
export Property
export Dataset
export dataset_from_csv
export AbstractConjecture
export UpperBound, LowerBound
export Conjecture
export conjectures
export conjectures_on

end
