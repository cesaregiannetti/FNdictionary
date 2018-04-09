if dimen==1
	g(end-2).YData=u+u0;
	g(end-1).YData=uq+u0;
	if adapt
		g(end).XData=x(ik);
	end
	if minw
		g(end).YData=wq(ik);
	else
		g(end).YData=uq(ik)+u0;
	end
	for ip=1:m*~tp
		g(ip).YData=Du(:,ip,it)+u0;
	end
elseif dimen==2
	g2.ZData=reshape(u+u0,size(x));
	g3.ZData=reshape(uq+u0,size(x));
	if adapt
		g4.XData=x(ik);
		g4.YData=y(ik);
	end
	g4.ZData=uq(ik)+u0;
	for ip=1:m*~tp
		g1(ip).ZData=Du(1:size(x,1),ip,it)+u0; %#ok<SAGROW>
	end
elseif dimen==3
	g5.FaceVertexCData=uq;
	if adapt
		g6.XData=x(ik);
		g6.YData=y(ik);
		g6.ZData=z(ik);
	end
	view([-20-80*it/Nt -10+40*it/Nt]);
end
title([tname '   \nu = ' num2str(vi) '   t = ' num2str(round(dt*(it-1)))]);
if prnt
	print(fig,['Img\p_' '0'+dimen '_' num2str(N) '_' num2str(it)],'-dpng');
else
	drawnow limitrate nocallbacks;
end