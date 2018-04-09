if ~tp || ~gprL
	return;
end
ik=full(sparse(ones(1,min(N,k+ks)),unique(round(linspace(1,N,k+ks))),1>0));
[gerr,gi]=max(dx1*abs(Du));
Dg=zeros(1,min(gmax,size(Du,2)));
for gm=1:min(gmax,size(Du,2))
	Dg(gm)=gi;
	disp(['Dictionary size ' num2str(gm) ' with error ' num2str(gerr)]);
	if gerr<=geps
		break;
	end
	Li=zeros(1,size(Du,2));
	for ib=setdiff(1:size(Du,2),Dg(1:gm))
		uq=Du(:,ib);
        FN_adapt;
		ke=nnz(ik);
		Sw=Dw(:,ib);
        vi=Dv(ib);
		FN_baseprj;
		Li(ib)=erg;
	end
	[gerr,gi]=max(Li);
end
Du=Du(:,Dg(1:gm));
Dw=Dw(:,Dg(1:gm));
Dt=Dt(Dg(1:gm));
Dv=Dv(Dg(1:gm));
os=['Dict' '0'+dimen 'grdy-L' '0'+gprL datestr(now,'_yyyy-mm-dd_HH-MM')];
save(os,'Du','Dw','Dt','Dv','x','y','z','C','T','M','S','Ac','dx1','gerr');