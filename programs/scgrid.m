function [r,xL,xR]=scgrid(GridSize,GridSpacing)
%function [r,xL,xR]=scgrid(GridSize,GridSpacing)
%  SYNOPSIS
%  The function computes the resistance (or reactance) values of the circles 
%  to be drawn in a smith chart, from a simple grid definition.
%  The output variables are compatible with the ones defined in scDraw.m
%
%  SYNTAX
%   [r,xL,xR]=scgrid; uses a default grid, which makes a smith chart
%                     similar to the one in the book:
%                     Ramo, Winnery, Van Duzer "Fields and Waves"
%   [r,xL,xR]=scgrid(GridSize,GridSpacing); uses the specified arguments
%  
%  INPUT ARGUMENTS:
%     GridSize: A vector containing the size of grids to be drawn
%     GridSpacinc: A vector containing the spacing of the grids defined by GridSize
%
%  OUTPUT ARGUMENTS:
%     r       : A vector consisting of the computed values of r (or x)
%     xL      : A vector of x (or r) values containing left termination points for r (or x) circles
%     xR      : A vector of x (or r) values containing right termination points for r (or x) circles
%
% Ignasi Corbella. Universitat Politècnica de Catalunya UPC corbella@tsc.upc.es
% 15-January-2002

if nargin==0
   GridSpacing=[10  2  1 0.2 0.1 0.05 0.02 0.01]; %default grid
   GridSize=   [50 20 10 5   2   1    0.5  0.2 ]; %default grid
elseif nargin~=2
   error('Not enough arguments in call to scgrid.m')
end

nd=5; %number precision to compare floating numbers
r=[];
xR=[];
xL=[];
for ii=1:length(GridSpacing)
   r1=[GridSpacing(ii):GridSpacing(ii):GridSize(ii)];
   r1=fix(r1*10^nd)/10^nd; %fixing nd decimal figures to allow comparing floating numbers
   inside=find(xL<GridSize(ii)&r<=GridSize(ii));
   jj=~ismember(r(inside),r1);
   if ~isempty(jj)
      xL(inside(jj))=GridSize(ii);
   end
   r1(ismember(r1,r(inside)))=[]; 
   r=[r r1];
   xR=[xR GridSize(ii)*ones(size(r1))];
   xL=[xL zeros(size(r1))];
end

[r,I]=sort(r);
xR=xR(I);
xL=xL(I);
