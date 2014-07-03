% function [ind1,ind2]=match_vec(vec1,vec2,eps);
%
% finds the indices in vec2 that match values in vec1
% for each value in vec1, finds the closest value in vec2
% if it is closer than eps, stores the respective indices 
% of the pair in ind1 and ind2
% 
function [ind1,ind2]=match_vec(vec1,vec2,eps)
%
n1=length(vec1);
index=0;ind1=[];ind2=[];
	for j=1:n1
	x=vec1(j);
	[val,i]=min(abs(vec2-x));
		if val<eps
		index=index+1;
		ind1(index)=j;ind2(index)=i;
		end
	end
		