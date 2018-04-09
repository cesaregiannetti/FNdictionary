if tp
	uq=Du(:,tloc)*q(tloc,it);
	wq=Dw(:,tloc)*q(tloc,it);
else
	uq=Du(:,:,it)*q(:,it);
	wq=Dw(:,:,it)*q(:,it);
end
FN_step;
e(it)=(dx1*abs(u-uq))/(dx1*abs(u));
r(it)=mean(abs(Ar*q(tloc,it)+br))/up;