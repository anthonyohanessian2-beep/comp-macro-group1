// Question 1: persistence of a TFP shock in an RBC economy.
// Household is the owner of capital, and the firm is renting inputs, and there are lump-sum taxes.
// From Octave/MATLAB: dynare main
//                     dynare main -DRHO_A=0.5
// METHOD=1: stochastic perturbation; 2: perfect foresight; 3: extended path.
// ORDER is the Taylor degree for the stochastic solution.
@#ifndef RHO_A
 @#define RHO_A = 0.9
@#endif
@#ifndef ORDER
 @#define ORDER = 1
@#endif
@#ifndef SAMPLE
 @#define SAMPLE = 80
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

model;
 // 1. Production uses inherited capital.
 y=a*k(-1)^alpha*n^(1-alpha);
 // 2. Investment creates tomorrow's capital.
 k=(1-delta)*k(-1)+invest;
 // 3. Goods market clearing.
 y=c+invest+g;
 // 4. Competitive wage equals marginal product of labour.
 w=(1-alpha)*y/n;
 // 5. rk records capital's marginal product.
 rk=alpha*y/k(-1);
 // 6. Household labour-supply condition.
 chi*n^eta=w/c;
 // 7. Euler equation, with next-period return.
 1/c=beta*(1/c(+1))*(rk(+1)+1-delta);
 // 8. Lump-sum taxes finance government purchases.
 tax=g;
 // 9. Persistent log TFP.
 log(a)=rho_a*log(a(-1))+eps_a;
 // 10. Persistent log government purchases (no shock in this experiment).
 log(g/gbar)=rho_g*log(g(-1)/gbar);
end;