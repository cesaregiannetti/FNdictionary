if dimen==1
	grad=diff(uq)./diff(x);
elseif dimen==2
	[grx,gry]=gradient(reshape(uq,size(x)),x(1,2)-x(1,1),y(2,1)-y(1,1));
	grad=sqrt(grx(:).^2+gry(:).^2);
elseif dimen==3
	gr=sortrows([C(:,2),max(abs(diff(uq(C),1,2)),[],2)./sqrt(2*Ac)]);
	grad(gr(:,1))=gr(:,2);
	%grad=(S*uq)./dx1.';
end