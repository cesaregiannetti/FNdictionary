wq(ik)=etaueta*uq(ik)+egetadt*wq(ik);
if minw
	Ar=Dw(ik,tloc,1+~tp*(it-1));
	br=-wq(ik);
else
	if ~tp || it<=2 || adapt || loct
		Ar=Aik*Du(:,tloc,1+~tp*(it-1));
	end
	br=Mik*(dt*fun(uq(ik),wq(ik))-uq(ik));
end