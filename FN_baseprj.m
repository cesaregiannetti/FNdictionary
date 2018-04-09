if gprL==3
	Ar=vi*dt*S(ik,:)+M(ik,:);
	br=M(ik,ik)*(dt*fun(uq(ik),etaueta*uq(ik)+egetadt*Sw(ik))-uq(ik));
	erg=min(mean(abs(Ar*Du(:,Dg(1:gm))+br)))/(1+(rel>0)*(mean(abs(br))-1));
else
	if gprL==2
		qq=lsqlin(Du(ik,Dg(1:gm)),uq(ik),[],[],ones(1,gm),1,zeros(gm,1));
	elseif gprL==1
		f=[zeros(gm,1);ones(2*ke,1)];
		Ar=[Du(ik,Dg(1:gm)),-speye(ke),speye(ke);ones(1,gm),zeros(1,2*ke)];
		try
			qq=linprog(f,[],[],Ar,[uq(ik);1],zeros(gm+2*ke,1));
			qq=qq(1:gm);
		catch
			qq=lsqnonneg(Du(ik,Dg(1:gm)),uq(ik));
		end
	end
	normg=(dx1*abs(uq))^(1/max(1,rel));
    erg=(dx1*abs(Du(:,Dg(1:gm))*qq-uq))/(1+(rel>0)*(normg-1));
end