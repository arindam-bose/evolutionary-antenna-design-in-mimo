function [seen_children] = pushSeenChildren(seen_children, new_children)
%   pushes children into the seen_chldren set
    for i = 1:length(new_children)
        child = new_children{i};
        if (isempty(find(cellfun(@(x) isequal(x,child), seen_children), 1)))
            seen_children{length(seen_children)+1} = child;
        end
    end
end