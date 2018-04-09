tt=t0+Jht/2; %#ok<*NASGU>
vi=v0;
FN_ic;
FN_solve;
nsol=nsol+1;
uq=Su;
FN_baseprj;
dJt=(erg-J0)/(tt-t0);
if dJt==0
	dJt=eps/(Tf-dt);
end
hv=min(abs(vv(vv~=v0)-v0));
tt=t0;
vi=max(vv(vv==v0+hv | vv==v0-hv));
FN_ic;
FN_solve;
nsol=nsol+1;
uq=Su;
FN_baseprj;
dJv=(erg-J0)/(vi-v0);