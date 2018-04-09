FN_ic;
ik=false(1,N);
ik(round(linspace(1,N,ks)))=true;
Aik=A(ik,:);%#ok<*NASGU>
Mik=M(ik,ik);
q=zeros(m,Nt);
e=zeros(1,Nt);
r=zeros(1,Nt);
iterls=zeros(1,Nt);%number of reweighted least squares iterations
uq=u;
wq=w;
tname='Weighted Least Squares';
fig=figure;
FN_plotin;
for it=2:Nt
	if mod(it-2,1) && ~tp
		q(:,it)=q(:,it-1);
	else
		FN_adapt;
		ke=nnz(ik);
		tloc=abs(Dt-it*dt)<loct/2;
		if ~tp || ~any(tloc)
			tloc=true(m,1);
		end
		ml=sum(tloc);
		FN_residual;
		for iter=1:smax
			res=Ar*q(tloc,it)+br;
			ares=abs(res);
			meps=1e-6*max(1,max(ares));
			ir=ares>=meps;
			wr=ones(ke,1);
			wr(ir)=meps./sqrt(ares(ir));
			W=spdiags(wr,0,ke,ke);
			LB=q(tloc,it)-1;
			UB=q(tloc,it);
			dq=lsqlin(W*Ar,W*res,[],[],ones(1,ml),sum(q(tloc,it))-1,LB,UB);
			q(tloc,it)=q(tloc,it)-dq;
			if sum(abs(dq))<=seps*(1+sum(q(tloc,it)))
				break
			end
		end
		iterls(it)=iter;
		if iter >= smax
			q(tloc,it)=lsqnonneg(Ar,-br);
		end
	end
	FN_asserr;
	FN_plotup;
end