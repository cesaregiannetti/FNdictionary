FN_ic;
ik=false(1,N);
ik(round(linspace(1,N,ks)))=true;
Aik=A(ik,:);%#ok<*NASGU>
Mik=M(ik,ik);
q=zeros(m,Nt);
e=zeros(1,Nt);
r=zeros(1,Nt);
qshift=tp && exist('gprL','var') && ~gprL;
uq=u;
wq=w;
tname='Fixed coefficients';
fig=figure;
FN_plotin;
for it=2:Nt
	if mod(it-2,1) && ~tp
		q(:,it)=q(:,it-1);
	else
		FN_adapt;
		ke=nnz(ik);
		tloc=1:m;
		FN_residual;
		if qshift && it*dt > mean(Dt(min(Nt,find(fixq)+floor(v/2))))
			fixq=circshift(fixq,v);
		end
		q(tloc,it)=fixq;
	end
	FN_asserr;
	FN_plotup;
end