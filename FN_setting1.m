dimen=1;
visc=1e-6;
if ~exist('x','var') || ~isscalar(y)
	x=(0:.005:1).';
	y=0;
	z=0;
	C=[1:length(x)-1;2:length(x)].';
	clear T;
end
if ~exist('T','var')
	T=0:.6:600;
end
FN_setting;
Ac=diff(x);
dx1=.5*([0;Ac]+[Ac;0]).';
dx2=[Ac(1);Ac].*[Ac;Ac(end)];
M=speye(N);
S=spdiags([-1./dx2 2./dx2 -1./dx2],-1:1,N,N);
S([1 end])=1./dx2([1 end]);
u_0=@(xc,~,~)beta*(abs(x(:)-xc)<=.025);