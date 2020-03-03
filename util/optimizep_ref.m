function [p, alpha] = optimizep_ref(p, R, alpha, params, options, L)

    M            = params.M;
    N            = params.N;
    
    iterIMax     = options.iterIMax;
    verbose      = options.verbose;
    
    x = [sqrt(alpha); p];
    y = [sqrt(alpha); randi([0 1], M,1)];
    u = [sqrt(alpha); randi([0 1], M,1)];
    
    idx = 0;
    while idx < iterIMax
        % update x
        if verbose == 1
            cvx_begin 
        else
            cvx_begin quiet
        end
           variable x(M+1,1)
           minimize L(x,y,u,R)
           subject to
              0 <= x(1);
              0 <= x(2:M+1) <= 1;
              ones(M,1)'*x(2:M+1) == N; 
        cvx_end
        
        % update y
        if verbose == 1
            cvx_begin 
        else
            cvx_begin quiet
        end
           variable y(M+1,1)
           minimize L(x,y,u,R)
           subject to
              0 <= y(1);
              0 <= y(2:M+1) <= 1;
              ones(M,1)'*y(2:M+1) == N; 
        cvx_end

        % update u
        u = u + x-y;
        
        idx = idx + 1;
        obj(idx) = L(x,y,u,R);
    end
    alpha = (x(1))^2;
    p     = x(2 : M+1);
    if verbose == 1
        figure; plot(obj);
        xlabel('Iterations'); ylabel('Objective values of inner loop');
    end
end