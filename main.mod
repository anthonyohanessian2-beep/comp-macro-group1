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

beta=.97; alpha=.336; delta=.08; eta=1;
rho_a=@{RHO_A}; rho_g=.9;
// Calibration targets: n=1/3, g=20% of steady output.
kap=(alpha/(1/beta-1+delta))^(1/(1-alpha)); // steady K/N ratio
yref=kap^alpha/3;
gbar=.2*yref;
cref=yref-delta*kap/3-gbar;
chi=(1-alpha)*kap^alpha/(cref*(1/3)^eta);