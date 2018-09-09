function [m, A, Eigenfaces] = EigenfaceCore(T)


             
 
%%%%%%%%%%%%%%%%%%%%%%%% Calculating the mean image 
m = mean(T,2); % Computing the average face image m = (1/P)*sum(Tj's)    (j = 1 : P)
% gives m*n,1 matrix

Train_Number = size(T,2);

%%%%%%%%%%%%%%%%%%%%%%%% Calculating the deviation of each image from mean image
A = [];  
for i = 1 : Train_Number
    temp = double(T(:,i)) - m; % Computing the difference image for each image in the training set Ai = Ti - m
    A = [A temp]; % Merging all centered images
end
% A will be 36000*20 matrix



L = A'*A; % L is  covariance matrix C=A*A'. the cov mat as specified in tutorial
[V D] = eig(L); % Diagonal elements of D are the eigenvalues for both L=A'*A and C=A*A'.


L_eig_vec = V;

%Eigenfaces is the eigen vector matrix of the cov matrix,L_eigen_vec is
%temporary
%%%%%%%%%%%%%%%%%%%%%%%% Calculating the eigenvectors of covariance matrix 'C'
% Eigenvectors of covariance matrix C (or so-called "Eigenfaces")
% can be recovered from L's eiegnvectors.
Eigenfaces = A * L_eig_vec; % A: centered image vectors

