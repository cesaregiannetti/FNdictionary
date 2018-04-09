Su=zeros(N,length(tt));
Sw=zeros(N,length(tt));
for is=1:length(tt)
	while Tint<tt(is)
		FN_step;
		Tint=Tint+dt;
	end
	Su(:,is)=u;
	Sw(:,is)=w;
end