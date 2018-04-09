if dimen==1
	g=plot(x,Du(:,:,1)+u0,'c',x,u+u0,'b',x,uq+u0,'r',x(ik),uq(ik)+u0,'ro');
	axis([x(1) x(end) 0 u0+up]);
	legend(g(end-3:end),'Dictionary','Exact sol.','L^1 approx.','min. pt');
elseif dimen==2
	g1=plot3(x(:,1),y(:,1),Du(1:size(x,1),:,1)+u0,'c');
	hold on;
	g2=mesh(x,y,reshape(u+u0,size(x)),sparse(size(x,1),size(x,2)));
	g3=mesh(x,y,reshape(uq+u0,size(x)),ones(size(x)));
	g4=plot3(x(ik),y(ik),uq(ik)+u0,'mo');
	axis([min(x(:)) max(x(:)) min(y(:)) max(y(:)) 0 u0+up]);
	colormap jet;
	view([-25 20]);
	G=[g2;g3;g4;g1];
	L=['Exact sol. ';'L^1 approx.';'min. points';'Dictionary '];
	legend(G,L,'Location','best');
elseif dimen==3
	g5=trimesh(C,x,y,z,uq);
	hold on;
	g6=plot3(x(ik),y(ik),z(ik),'ro');
	colorbar;
	xlabel('x');
	ylabel('y');
	zlabel('z');
	axis equal;
	caxis([u0 up]);
	view([-20 -10]);
	title([tname '   \nu = ' num2str(vi) '   t = 0']);
	legend(['L^1 approx.';'min. points'],'Location','best');
end