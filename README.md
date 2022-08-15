# Conjecturing.jl

Conjecturing.jl is general automated conjecturing package currently in development that gives users the ability to produce conjectured relationships between invariants on a given type of mathematical object. To make conjectures you will need a ```data.csv``` file of precomputed invariant (and boolean data if you wish) data. The columns of ```data.csv``` should be the names of the invariants together with any optional boolean property names; exactly one column called "name" containing the names of each instance of the objects is also required. 

The rows of ```data.csv``` are the instances of your objects. As an example, this package comes with a precomputed databases of mathematical values stored in the ```graph_data.csv``` file, the ```matrix_data.csv``` file, and the ```integer_data.csv``` file. These file contain precomputed numerical and boolean values on simple connected graphs, square matrices, and positive integers, respectively. To generate conjectures on the simple connected graph data, run the following Conjecturing.jl functions (also see the example.jl file in the root directory).


```Julia
conjs = conjecture(
    "graph_data.csv",
    "matching_number",
    "connected graph",
    types = graph_types,
    use_test_data = true,
)

```
will conjecture on the matching number invariant column in the provided ```graph_data.csv``` file. 

```Julia
random_conjs = conjecture(
    "graph_data.csv",
    "connected graph",
    types = graph_types,
    use_test_data = true,
)
```

will conjecture on a randomly chosen invariant column from the provided ```graph_data.csv``` file. 

