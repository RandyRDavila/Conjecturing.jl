using Conjecturing
using DataFrames
using CSV


conjecture("matrix_data.csv", "det"; object_type = "matrix", conj_lims = 1:15);
