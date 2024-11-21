# Modelgeneration

data for the different variants are available in the RackVariantTable.cvs

dHeight,dLength,dDepth,nShelves,bShelfType,bColumnType



## Part generation

For each part we provide a CCFUNC 


## Assembly generation

for the rack we provide a CCFUNC that can assemble the columns and shelves correctly.
The CCFUNC either loads the correct parts according to the parameters or loads a template and recalculated the parts for the correct size.

The nbrShelves defines the ...


## Output Files

We provide for each part the possible variants as smp and stp

For each row in RackVariantTable.cvs we provoide binary smp and stp file fo the "flattened" assembly

PNG later...

## Questions
You need the code that generates each variant of a model? Currently we have one "generic" code for creating all variants.

If yes, then we would definitivly have to develop a logger that creates code from a  given parametric model in memory.
-> the logger would write the "values" and not the "parametrization" of expressions.

When code generation should be possible for each operation, then it seems to me that we have to create for ech model 



