function [minp] = findMinFunctional(f, R, alpha, parent, new_children, mflag)
    
%   finds the minimum of the functional value
    val = zeros(length(new_children), 1);
    if mflag ~=2
        new_children{length(new_children)+1} = parent;
    end
    for i = 1:length(new_children)
        child = new_children{i};
        val(i) = f(child,R,alpha);
    end
    min_idx = (val == min(val));
    minp    = new_children{min_idx};
end