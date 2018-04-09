if ~tp || ~gprL
	return;
end
ik=full(sparse(ones(1,min(N,k+ks)),unique(round(linspace(1,N,k+ks))),1>0));
FN_gradset;
Dg=1:gmax;
for gm=1:gmax%each cycle adds a new solution to the dictionary
	Dt(gm)=t0_s; %#ok<*SAGROW>
	Dv(gm)=v0_s;
	Du(:,gm)=round(Su_s,20);%the first solution is chosen in FN_gradset
	Dw(:,gm)=round(Sw_s,20);
	if gerr<=geps%stopping criterion defined outside
		break;
	end
	gerr=0;
	nreg=min(max(1,gm-1),maxreg);
	for reg=1:nreg%starting point in each region
		t0=dt+(reg-.05-.95*rand)*((Tf-dt)/min(max(1,gm-1),maxreg));
		v0=vv(randsample(length(vv),1));
		tt=t0;
		vi=v0;
		FN_ic;
		FN_solve;
		nsol=nsol+1;
		uq=Su;
		FN_adapt;
		ke=nnz(ik);
		FN_baseprj;
		J0=erg;
		Jht=min(Tf-t0,max(dt-t0,(Tf-dt)/max(1,gm-1)/4));
		while abs(Jht)>epst%gradient driven path
			FN_gradappr;
			[~,ig]=min(abs(vv-v0-dJv/dJt*Jht));
			hv=vv(ig)-v0;
			dJv=dJv+dJt*eps*(dJv==0);
			ht=min(Tf-t0,max(dt-t0,dJt/dJv*hv+Jht*(hv==0)));
			J1=0;%step length selection by trial and bisection
			while J1<=J0 && (abs(ht)>epst || hv~=0)
				tt=t0+ht;
				vi=v0+hv;
				if ht<0 || hv~=0 || ~J1
					FN_ic;
				end
				FN_solve;
				nsol=nsol+1;
				uq=Su;
				FN_baseprj;
				J1=erg;
				[~,ig]=min(abs(vv-v0-hv/2));
				hv=(vv(ig)-v0)*(vv(ig)-v0<hv);
				ht=min(Tf-t0,max(dt-t0,dJt/dJv*hv+ht/2*(hv==0)));
			end
			if J1>J0%region-local current maximum along the gradient
				t0=tt;
				v0=vi;
				uq=Su;
				FN_adapt;
				ke=nnz(ik);
				J0=J1;
			end
			if gerr>0
				plot([t0 tt],[v0 vi],'-xg',Dt,Dv,'sb',t0_s,v0_s,'sr');
				vlim=[1.1,-.1]*[min(vv),max(vv);max(vv),min(vv)];
				tlim=[1.05,-.05]*[dt,Tf;Tf,dt];
				axis([tlim,vlim]);
				title([tit num2str([gm;round(gerr,4);nsol])]);
				pause(1e-6);
			end
			Jht=Jht/2;
		end%(while abs(Jht)>epst)
		if J0>gerr%inter-region global maximum
			for tpast=find(Dt==t0)%clone detection
				if Dv(tpast)==v0
					break;
				end
			end
			gerr=J0;
			Su_s=Su;
			Sw_s=Sw;
			t0_s=t0;
			v0_s=v0;
		end
	end%(for reg=1:nreg)
end%(for gm=1:gmax)
Du=Du(:,Dg(1:gm));
Dw=Dw(:,Dg(1:gm));
Dt=Dt(Dg(1:gm));
Dv=Dv(Dg(1:gm));
os=['Dict' '0'+dimen 'grad-L' '0'+gprL datestr(now,'_yyyy-mm-dd_HH-MM')];
save(os,'Du','Dw','Dt','Dv','x','y','z','C','T','M','S','Ac','dx1','gerr');