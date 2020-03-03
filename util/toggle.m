function [new_vec] = toggle(vec, pos)
%   toggles the bit of vec using the pos vector mask
    new_vec = xor(vec,pos);
end