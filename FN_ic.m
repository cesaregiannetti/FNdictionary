if exist('Dtg','var') && min(Dtg)<=min(tt) && max(Dvg==vi)
	[Tint,ic]=max(Dtg.*(Dtg<=min(tt) & Dvg==vi));
	u=Dug(:,ic);
	w=Dwg(:,ic);
else
	u=u_0(.1,.1,.1);
	w=zeros(N,1);
	Tint=0;
end
A=vi*dt*S+M;