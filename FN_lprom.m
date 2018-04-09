FN_ic;
ik=false(1,N);
ik(round(linspace(1,N,ks)))=true;
Aik=A(ik,:);%#ok<*NASGU>
Mik=M(ik,ik);
q=zeros(m,Nt);
e=zeros(1,Nt);
r=zeros(1,Nt);
cvx=1;%impose convexity of the solution manifold as sum(q(:,it))=1
uq=u;
wq=w;
tname='Linear Programming';
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
		Aeq=[Ar,-speye(ke),speye(ke);cvx*ones(1,ml),zeros(1,2*ke)];
		f=[zeros(ml,1);ones(2*ke,1)];
		LB=0*ones(ml,1);
		try
			qq=linprog(f,[],[],Aeq,[-br;cvx],[LB;zeros(2*ke,1)]);
			q(tloc,it)=qq(1:ml);
		catch
			%q(tloc,it)=lsqlin(Ar,-br,[],[],cvx*ones(1,ml),cvx,LB);
			q(tloc,it)=lsqnonneg(Ar,-br);
		end
	end
	FN_asserr;
	FN_plotup;
end