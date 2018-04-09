dimen=3;
visc=1e-2;
if ~exist('x','var') || isscalar(z)
	%load test3;
	[x,y]=meshgrid(0:100,0:100);
	z=50*sin(pi/100*x).*sin(pi/100*y);
	C=delaunay(x,y);
	clear T M S Ac dx1 rad;
end
if ~exist('T','var')
	T=0:.6:900;
end
FN_setting;
if ~exist('M','var') || size(M,1)~=N
	FN_stiff;
end
if ~exist('rad','var')
	rad=10;
end
u_0=@(xc,yc,zc)beta*((x(:)-xc).^2+(y(:)-yc).^2+(z(:)-zc).^2<=rad^2);