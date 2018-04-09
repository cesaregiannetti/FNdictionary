if adapt
	ik=full(sparse(ones(1,min(N,ks)),unique(round(linspace(1,N,ks))),1>0));
	FN_grad;
	ig=find(abs(grad)>adapt);
	ik(ig(round(linspace(1,length(ig),k*(~isempty(ig))))))=true;
	if exist('A','var')
		Aik=A(ik,:);
		Mik=M(ik,ik);
	end
end