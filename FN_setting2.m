dimen=2;
visc=1e-6;
if ~exist('x','var') || isvector(x)
	%load test2;
	[x,y]=meshgrid(0:.01:1,0:.01:1);
	z=0;
	C=delaunay(x,y);
	clear T M S Ac dx1 rad;
end
if ~exist('T','var')
	T=0:.6:600;
end
FN_setting;
if ~exist('M','var') || size(M,1)~=N
	FN_stiff;
end
if ~exist('rad','var')
	rad=.1;
end
u_0=@(xc,yc,~)beta*((x(:)-xc).^2+(y(:)-yc).^2<=rad^2);