FN_setting1;
nsamp=1e4;
u2=zeros(N,1);
w2=zeros(N,1);
for i=1:nsamp
	vi=2*visc*(2+rand);
	A=vi*dt*S+M;
	CFL=dt*(125*vi+5.5e-4)/min(dx1);
	u1=beta*rand(N,1);
	w1=rand(N,1);
	for j=1:N
		u2(j)=u1(j)*rand;
		w2(j)=w1(j)*rand;
	end
	u=u1;
	w=w1;
	FN_step;
	Su1=u;
	Sw1=w;
	u=u2;
	w=w2;
	FN_step;
	Su2=u;
	Sw2=w;
	if any(Su1<Su2) || any(Sw1<Sw2)
		display(CFL);
		display(vi);
		error('The scheme is not monotone under this CFL in the vi range');
	end
end