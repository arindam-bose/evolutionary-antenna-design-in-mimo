function [new_children] = generateChildren(parent_point, seen_children, mflag, options)
%   generates children of parent_point and put them into seen-children
%   mutate children using prob if stuck in a saddle point.

    verbose      = options.verbose;
    mutationBit  = options.mutationBit;
    mutationProb = options.mutationProb;

    new_children = {};
    pushflag = 0;
    n = length(parent_point);
    
    for i = 1:n
        temp = zeros(n,1);
        temp(i) = 1;

        if (parent_point(i) == 1)
            child = toggle(parent_point, temp);

            if (isempty(seen_children))
                pushflag = 1;
            else
                if mflag == 1                                   %% Mutation
                    rng('shuffle');
                    tempA = rand(1);
                    tempA = (tempA < mutationProb);
                    if tempA
                        pos = randperm(n, mutationBit)';
                        temp = zeros(n,1);
                        temp(pos) = 1;
                        child = toggle(child, temp);
                        if verbose == 1
                            disp('Children has been mutated');
                        end
                    else
                        if verbose == 1
                            disp('Children has NOT been mutated');
                        end
                    end
                end

                if (isempty(find(cellfun(@(x) isequal(x,child), seen_children), 1)))
                    pushflag = 1;
                end

            end
            if pushflag == 1
                new_children{length(new_children)+1} = child;
            end

        end
    end
end