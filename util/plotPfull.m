function plotPfull(Pn, Rem, alpha, params)
    K     = params.K;
    theta = params.theta;
    phi   = params.phi;
    N     = params.N;
   
    funP = zeros(K,1);
    for k = 1:K
        funP(k) = Pn(Rem,theta(k),N);
    end
    
    plot(theta, funP/alpha);
    hold on;
    plot(theta, phi);
    xlim([theta(1)-1, theta(end)+1]);
    
    legend('Empirical', 'Desired');
    ylabel('P(\theta)');
    xlabel('\theta(\circ)');
    title('Empirical beampattern');
    hold off;
end