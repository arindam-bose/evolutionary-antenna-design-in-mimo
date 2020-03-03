function cost = J(p, R, alpha, params, aT)
%   our cost function: J(p,R) = (1/K) * \sum_{k=1}^{K} {w(k)(p'*R(k)*p - phi(k))^2} + ...
%                               (2*wc/Kt^2 - Kbar) \sum_{m=1}^{Kbar-1} {\sum_{n=m+1}^{Kt} {(p'*R(m,n)*p)^2}}
    
    cc       = params.cc;
    w        = params.w;
    wc       = params.wc;
    K        = params.K;
    theta    = params.theta; 
    phi      = params.phi;

    % desired pattern
    cost1 = 0;
    for k = 1 : K
        Rk    = real(R .* conj(aT(theta(k))*aT(theta(k))'));
        cost1 = cost1 + w(k) * (p'*Rk*p - alpha*phi(k))^2;
    end
    cost1 = (1/K) * cost1;
    cost = cost1;
    
    % cc = 1: cross-correlation term
    cost2 = 0;
    if (cc == 1 && wc ~=0)
        Kbar     = params.Kbar;
        thetahat = params.thetahat;

        for m = 1 : Kbar-1
            for n = m+1 : Kbar
                Rmn = real(R .* conj(aT(thetahat(m))*aT(thetahat(n))'));
                cost2 = cost2 + (p'*Rmn*p)^2;
            end
        end
        cost2 = ((2*wc)/(Kbar^2 - Kbar)) * cost2;
        cost = cost1 + cost2;
    end 
end