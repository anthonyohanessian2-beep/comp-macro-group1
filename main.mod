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

 varexo eps_a;   // innovaion to log TFP
parameters
 beta     // household discount factor
 alpha    // capital share in production
 delta    // capital depreiation rate
 eta      // curvature of labour disutility
 chi      // scale of labour disutility
 rho_a    // persistence of log TFP
 rho_g    // persistence of log purchases
 gbar;    // steady government purchases
