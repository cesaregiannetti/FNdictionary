FN_setting1;
vi=5*visc;
FN_ic;
fig=figure;
g=plotyy(x,u+u0,x,w);
tvis=['Full solution     Viscosity = ' num2str(vi) '   Time = '];
tit=title([tvis '0']);
axis(g(1),[x(1) x(end) 0 u0+up]);
axis(g(2),[x(1) x(end) 0 1]);
ylabel(g(1),'potential   u');
ylabel(g(2),'recovery   w');
for it=2:Nt
	FN_step;
	g(1).Children(end).YData=u+u0;
	g(2).Children(end).YData=w;
	tit.String=[tvis num2str(round(dt*(it-1)))];
	%print(fig,['Img\pex_1_' num2str(N) '_' num2str(it)],'-dpng');
	drawnow nocallbacks;
	%drawnow limitrate nocallbacks;
end