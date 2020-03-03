function [p] = optimizep(p, R, alpha, params, options, f)
    
    M            = params.M;
    N            = params.N;
    
    if N < M
        iterIMax     = options.iterIMax;
        verbose      = options.verbose;

        oldp         = 99*ones(M,1);
        mcount       = 0;
        seenChildren = {};
        mflag        = 0;
        tp           = 0;
        flag = 1;

        while tp < iterIMax
%          while flag
            if verbose == 1
                disp(['tp: ' num2str(tp)]);
            end
            [newChildren]  = generateChildren(p, seenChildren, mflag, options);

            if verbose == 1
                disp('new children set = ');
                celldisplocal(newChildren);
            end
            [p]       = findMinFunctional(f, R, alpha, p, newChildren, mflag);
            mflag = 0;

            if verbose == 1
                disp(['best p = ' num2str(p')]);
            end
            [seenChildren] = pushSeenChildren(seenChildren, newChildren);

            if verbose == 1
                disp('seen children set = ');
                celldisplocal(seenChildren);
            end

            if (oldp == p)
%                  mflag  = 2;
%                  seenChildren = oldChildren;
            break;
            else
                mflag = 0;
            end

%              if sum(p) == N
%                  flag = 0;
%             end

            oldp = p;
            oldChildren = seenChildren;
            tp = tp+1;

            if verbose == 1
                disp('------------------------------------');
            end
        end
    end
end