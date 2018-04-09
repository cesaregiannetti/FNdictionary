FN_setting3;
tp=1*round(Tf/4);%time as a parameter
tt=[logspace(log10(dt),1,8) linspace(12+(Tf+10)/(2*tp-16),Tf,tp-8)];
vv=visc*(4.8:.1:5.1);%[4 4.5 4.8 5.2 5.5 6];%[4.7 4.9 4.95 5.05 5.1 5.3];%
Dt=repelem(tt,1,length(vv)*(tp>0));
Dv=repmat(vv,1,tp);
FN_dictionary;
gprL=1;%0 = OFF, 1 = L1 minim., 2 = L2 proj., 3 = residual
geps=1.5e-2;%greedy/gradient tolerance
gmax=600;%max number of elements
rel=1;%0 = abs error, 1 = rel error, 2 = sqrt error
k=20^min(dimen,2);%number of gradient-driven minimization points
ks=50^min(dimen,2);%number of stable minimization points (added)
adapt=1*(-9*log(mean(vv))-24);%grad treshold for min pt (0 = OFF)
epst=2*dt;%minimum advancing step in t-direction
maxreg=25;%maximum number of regions in t-direction
tic;
FN_peaksel;%FN_greedy;%FN_gradient;%
disp([['DictL' 48+gprL;'timer ';'error '] num2str([size(Du,2);toc;gerr])]);
clear A Ar Aeq Aik Mik Su Sw Dug Dwg Dtg Dvg