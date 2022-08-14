# Conjecturing.jl

Conjecturing.jl is general automated conjecturing package currently in development that gives users the ability to produce conjectured relationships between invariants on a given type of mathematical object. To make conjectures you will need a ```data.csv``` file of precomputed invariant (and boolean data if you wish) data. The columns of ```data.csv``` should be the names of the invariants together with any optional boolean property names; exactly one column called "name" containing the names of each instance of the objects is also required. 

The rows of ```data.csv``` are the instances of your objects. As an example, this package comes with a precomputed database of mathematical values stored in the ```data.csv``` file. This file contains simple and connected graph data, and can be conjectured on with the following Conjecturing.jl functions.


```Julia
write_to_me("matching_number")
```

will conjecture on the matching number invariant column in the provided ```data.csv``` file. 

```Julia
surprise_me()
```

will conjecture on a randomly chosen invariant column from the provided ```data.csv``` file. 

