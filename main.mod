// Question 1: persistence of a TFP shock in an RBC economy.
// Household is the owner of capital, and the firm is renting inputs, and there are lump-sum taxes.
// From Octave/MATLAB: dynare main

// METHOD=1: stochastic perturbation; 2: perfect foresight; 3: extended path.
// ORDER is the Taylor degree for METHOD=1 and uncertainty horizon for METHOD=3
// SHOCK=1: TFP; 2: government spending; 3: tax timing.
@#ifndef METHOD
 @#define METHOD = 1
@#endif
@#ifndef ORDER
 @#define ORDER = 1
@#endif
@#ifndef SHOCK
 @#define SHOCK = 1
@#endif
@#ifndef HORIZON
 @#define HORIZON = 200
@#endif
@#ifndef SAMPLE
 @#define SAMPLE = 80
@#endif
@#ifndef SCALE
 @#define SCALE = 1
@#endif


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

beta=.96; alpha=.36; delta=.08; eta=1;
rho_a=@{RHO_A}; rho_g=.9;
// Calibration targets: n=1/3, g=20% of steady output.
kap=(alpha/(1/beta-1+delta))^(1/(1-alpha)); // steady K/N ratio
yref=kap^alpha/3;
gbar=.2*yref;
cref=yref-delta*kap/3-gbar;
chi=(1-alpha)*kap^alpha/(cref*(1/3)^eta);