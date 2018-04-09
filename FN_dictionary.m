if exist('Dictionary.mat','file')
	load Dictionary;
	tt=Dt(Dv==min(Dv));
	vv=Dv(Dt==min(Dt));
	tp=length(tt);
else
	if tp
		tt=dt*unique(ceil(tt./dt));
	else
		tt=T;
	end
	v=length(vv);
	p=length(tt);
	Du=zeros(N,v,p);
	Dw=zeros(N,v,p);
	for id=1:v
		vi=vv(id);
		FN_ic;
		FN_solve;
		Du(:,id,:)=round(Su,20);
		Dw(:,id,:)=round(Sw,20);
	end
	if tp
		Du=reshape(Du,N,v*p);
		Dw=reshape(Dw,N,v*p);
	end
	%save(['Dictionary_' '0'+dimen '_' num2str(N)],'Du','Dw','Dt','Dv');
end
gerr=0;
clear A Su Sw