function  thermal4=mycmap_thermal4(nlevs,withwhite);
% withwhite=1, makes midpoint of distribution white 
% iff N is even the white is double wide
% whithwhite=0, has no white
% for best results N<20;

if (nargin<2), withwhite=0; end

iseven=0; 
if nlevs/2==floor(nlevs/2), iseven=1;  end
 
cmp = [ 10 50 120; 15 75 165; 30 110 200; 60 160 240; 80 180 250;
130 220 185; 170 230 184; 187 235 194; 207 241 202; 255 255 255;
255 255 255; 255 238 180; 255 232 120; 255 192 60; 255 160 0;
255 96 0; 255 50 0; 225 20 0; 192 0 0; 165 0 0];
cmp=cmp/255;

%$$$ cmp = [ 120 50 120; 120 50 120; 10 50 120; 15 75 165; 30 110 200; 60 160 240; 
%$$$ 130 220 185; 170 230 184; 207 241 202; 255 255 255;
%$$$ 255 255 255; 255 238 180; 255 232 120; 255 192 60; 255 160 0;
%$$$ 255 96 0; 255 50 0; 225 20 0; 192 0 0; 165 0 0];
%$$$ cmp=cmp/255;
%$$$ 
%$$$ Mat=(1:20)'*ones(1,3);
%$$$ contourf(Mat,1:20);
%$$$ colormap(cmp);



clear clow chigh

if (withwhite)
if iseven,
  ic=(nlevs-4)/2;
  X=(0:8)/8; 
  Xlow=(0:ic)/ic;
  clow=interp1(X,cmp(1:9,:),Xlow);
  chigh=interp1(X,cmp(20-(0:8),:),Xlow);
  thermal4=[clow; [1 1 1]; flipud(chigh)]; 
else
  ic=(nlevs-3)/2;
  X=(0:9)/9; 
  Xlow=(0:ic)/ic;
  clow=interp1(X,cmp(1:10,:),Xlow);
  chigh=interp1(X,cmp(20-(0:9),:),Xlow);
  thermal4=[clow; flipud(chigh)]; 
end  
else
if iseven,
  ic=(nlevs-2)/2; 
  X=(0:8)/8;
  Xlow=(0:ic)/ic;
  clow=interp1(X,cmp(1:9,:),Xlow);
  chigh=interp1(X,cmp(20-(0:8),:),Xlow);
  thermal4=[clow(1:ic,:); 0.5*(clow(ic+1,:)+chigh(ic+1)); flipud(chigh(1:ic,:))]; 
else
  ic=(nlevs-3)/2; 
  X=(0:8)/8; 
  Xlow=(0:ic)/ic;
  clow=interp1(X,cmp(1:9,:),Xlow);
  chigh=interp1(X,cmp(20-(0:8),:),Xlow);
  thermal4=[clow; flipud(chigh)]; 
end  
end
  
thermal4;

