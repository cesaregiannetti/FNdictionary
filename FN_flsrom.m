FN_fic;
Aik=A(ik,:);
Mik=M(ik,ik);
tic;
for it=2:Nt
	FN_adapt;
	ke=nnz(ik);
	tl=(abs(Dt-it*dt)<loct/2)|~any(abs(Dt-it*dt)<loct/2);
	Ar=Aik*Du(:,tl);
	br=Mik*(uq(ik)-dt*fun(uq(ik),etaueta*uq(ik)+egetadt*wq(ik)));
	q=zeros(sum(tl),1);
	for iter=1:smax
		res=Ar*q-br;
		ares=abs(res);
		meps=1e-6*max(1,max(ares));
		wr=meps./sqrt(ares);
		wr(wr>meps^1.5)=1;
		W=spdiags(wr,0,ke,ke);
		dq=lsqlin(W*Ar,W*res,[],[],ones(1,sum(tl)),sum(q)-1,q-1,q);
		q=q-dq;
		if sum(abs(dq))<=5e-2*(1+sum(q))
			break
		end
	end
	if iter >= smax
		q=lsqnonneg(Ar,br);
	end
	uq=Du(:,tl)*q;
end
toc;