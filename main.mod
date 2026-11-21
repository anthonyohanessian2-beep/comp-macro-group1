// Question 1: persistence of a TFP shock in an RBC economy.
// Household is the owner of capital, and the firm is renting inputs, and there arelump-sum taxes.
// From Octave/MATLAB: dynare main 
//                    


// k is chosen at the END of the period; its lag is inherited.
var
 c       // household consumption
 k       // capital owned by the household
 n       // hours worked
 invest  // investment
 y       // output
 a       // total factor productivity
 g       // government purchases
 w       // real wage
 rk      // marginal product of inherited capital
 tax;    // household lump-sum taxes

 