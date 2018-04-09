eval(['FN_setting' '1'+~isscalar(y)+~isscalar(z)]);
k=15^min(dimen,2);%number of gradient-driven minimization points
ks=12^min(dimen,2);%number of stable minimization points (added)
ik=full(sparse(ones(1,min(N,k+ks)),unique(round(linspace(1,N,k+ks))),1>0));
adapt=1*(-9*log(4.95*visc)-24);%grad treshold for min. points (0 = OFF)
loct=40;%time width of the (overlapping) local regions (0 = OFF)
smax=50;%max number of LS iterations (0 = pure L2)
uq=u_0(.1,.1,.1);
wq=zeros(N,1);
A=4.95*visc*dt*S+M;