M=sparse(N,N);
S=sparse(N,N);
Ac=zeros(Nc,1);
dx1=zeros(1,N);
for i=1:Nc
	switch dimen
		case 2
			c=[x(C(i,2:3))-x(C(i,1));y(C(i,2:3))-y(C(i,1))];
		case 3
			c1=diff([x(C(i,1:2).'),y(C(i,1:2).'),z(C(i,1:2).')]);
			c2=diff([x(C(i,[1,3]).'),y(C(i,[1,3]).'),z(C(i,[1,3]).')]);
			c=[norm(c1),dot(c1,c2)/norm(c1);0,norm(cross(c1,c2))/norm(c1)];
	end
	gradphi=[-1 1 0; -1 0 1];
	dp=c'\gradphi;
	Ac(i)=.5*abs(det(c));
	M(C(i,:),C(i,:))=M(C(i,:),C(i,:))+Ac(i)/12*(ones(3)+eye(3));
	S(C(i,:),C(i,:))=S(C(i,:),C(i,:))+Ac(i)*(dp'*dp); %#ok<*SPRIX>
	dx1(C(i,:))=dx1(C(i,:))+Ac(i)/3;
end