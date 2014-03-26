# trajtest1 - propagate simple Kepler orbit and dump states for plotting
# Written by Markus Landgraf. Last modified 14Oct13

module trajtest1

using ODE

using myconst.jl
using der2bp
using ODE

RE=planets["earth"]["re"]
mu=planets["earth"]["mu"]
h=400 #km

a=RE+h
vc=sqrt(mu/a); #circular orbit speed
x0=[a;0;0;0;vc/sqrt(2);vc/sqrt(2)]
t0=0
t1=365.2422*86400
traj=ode45(der,[t0;t1],x0)

end