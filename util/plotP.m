function plotP(P, p, R, alpha, params, it)
    K     = params.K;
    theta = params.theta;
    phi   = params.phi;
    cc    = params.cc;
    
    if cc == 0
        text = 'Without cross-correlation';
    elseif cc == 1
        text = 'With cross-correlation';
    end
     
    funP = zeros(K,1);
    for k = 1:K
        funP(k) = P(p,R,theta(k));
    end
     
    plot(theta, funP/alpha);
    hold on;
    plot(theta, phi);
    xlim([theta(1)-1, theta(end)+1]);
     
    legend(text, 'Desired');
    ylabel('P(\theta)');
    xlabel('\theta(\circ)');
    ylim([0 1.5]);
    title(['Iteration: ' num2str(it)]);
    hold off;
end