function [R, alpha] = optimizeR(p, R, alpha, params, options, f)
    
    c = params.c;
    M = params.M;
    N = params.N;
    
    verbose = options.verbose;
    
    if verbose == 1
        cvx_begin 
    else
        cvx_begin quiet
    end
        variable alpha(1)
        variable R(M,M) semidefinite
        minimize f(p,R,alpha)
        subject to
            diag(R) == c*p/N;
    cvx_end
end