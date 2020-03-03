function plotCrossCorrelation(p, R, aT, params)
    Kbar     = params.Kbar;
    thetahat = params.thetahat;
    
    for m = 1 : Kbar
        for n = 1 : Kbar
            Rmn = real(R .* conj(aT(thetahat(m))*aT(thetahat(n))'));
            Rcc(m,n)= (p'*Rmn*p)^2;
        end
    end
    disp('Cross-correlation coefficient: ');
    disp(Rcc);
    imagesc(Rcc);
    title('Cross-correlation coefficients');
    xticks([1 2 3]);
    xticklabels(thetahat);
    yticks([1 2 3]);
    yticklabels(thetahat);
    colorbar; colormap gray;

end