eval(['FN_setting' '1'+~isscalar(y)+~isscalar(z)]);
tp=sum(Dv==min(Dv));
m=size(Du,2);
vi=4.95*visc;%target parameter
minw=0;%minimize the residual on w
loct=40;%time width of the (overlapping) local regions (0 = OFF)
l=10;%time steps before re-evaluating coefficients
k=15^min(dimen,2);%number of gradient-driven minimization points
ks=12^min(dimen,2);%number of stable minimization points (added)
adapt=1*(-9*log(vi)-24);%grad treshold for min. points (0 = OFF)
seps=5e-2;%tolerance for LS-ROM stopping criterion
smax=50;%max number of LS iterations (0 = pure L2)
prnt=0;%print to Img\p_DIM_N_IT.png (0 = display only)
fixq=zeros(m,1);
fixq(floor((max(2,m/max(1,tp))+[0 1 3])/2))=1/(2+mod(ceil(m/max(1,tp)),2));
tic;
FN_lprom;%linear programming
[tlp,qlp,elp,rlp]=deal(toc,q,e,r);
FN_lsrom;%least squares
[tls,qls,els,rls]=deal(toc-tlp,q,e,r);
%FN_fixq;%fixed coefficients
[tfx,qfx,efx,rfx]=deal(toc-tlp-tls,q,e,r);
if tp
	vlp=sum(dx1*(Du*qlp));
	vls=sum(dx1*(Du*qls));
	vfx=sum(dx1*(Du*qfx));
else
	[vlp,vls,vfx]=deal(0);
	for im=2:Nt
		vlp=vlp+dx1*(Du(:,:,im)*qlp(:,im));
		vls=vls+dx1*(Du(:,:,im)*qls(:,im));
		vfx=vfx+dx1*(Du(:,:,im)*qfx(:,im));
	end
end
ostr=num2str([tfx;tls;tlp;sum(efx)/vfx;sum(els)/vls;sum(elp)/vlp]);
disp([['timeFX ';'timeLS ';'timeLP ';'%errFX ';'%errLS ';'%errLP '],ostr]);
figure;
plot(T,efx,'g',T,els,'r',T,elp,'b',T,rfx,'--g',T,rls,'--r',T,rlp,'--b');
title('L^1 norm of the relative error and average residual');
legend('error_F_X','error_L_S','error_L_P','res_F_X','res_L_S','res_L_P');