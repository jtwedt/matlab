% function A=eof_lsq(D,U,mask)
% computes amplitudes A for eofs U by least-squares 
%	fit of partial data to the functions, 
%		U * A'= data 
%
% elements of mask = 1 indicate valid data
%  (which rows in D and U to use at each time)
% 
% computes each column of A ("time") separately
%
function A=eof_lsq(D,U,mask)
[m,n]=size(mask);
[mm,nfcn]=size(U);
d=[];
   for j=1:n
   index=0;
      for i=1:m
         if mask(i,j) == 1
         index=index+1;
         d(index)=D(i,j);
           for k=1:nfcn
           a(index,k)=U(i,k);
           end
         end
      end
   A(:,j)=a\d';
   end
A=A';
