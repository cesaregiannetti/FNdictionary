FN_setting3;
vi=5*visc;
FN_ic;
fig=figure;
g=trimesh(C,x,y,z,u+u0);
tvis=['Full solution     Viscosity = ' num2str(vi) '   Time = '];
colorbar;
axis equal;
caxis([u0 up]);
xlabel('x');
ylabel('y');
zlabel('z');
for it=2:Nt
    FN_step;
	g.FaceVertexCData=u+u0;
    title([tvis num2str(round(dt*(it-1)))]);
    view([-20-80*it/Nt -10+40*it/Nt]);
	%print(fig,['Img\pex_3_' num2str(N) '_' num2str(it)],'-dpng');
	drawnow nocallbacks;
end