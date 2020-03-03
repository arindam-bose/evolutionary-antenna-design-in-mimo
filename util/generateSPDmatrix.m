function R = generateSPDmatrix(n, eigen_mean)
% Generate a dense n x n symmetric, positive definite matrix
Q = orth(randn(n));
D = diag(abs(randn(n, 1)) + eigen_mean);
R = Q*D*Q';
end