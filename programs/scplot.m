function scplot(r, x, LinCol, xR, xL, rR, rL)
%function scplot(r, x, LinCol, xR, xL, rR, rL)
%plots a smith chart
%ICS 15-1-02

nd=5;
main=[[0.05:0.05:0.2] ...
      [0.3:0.1:1] ...
      [1.2:0.2:2] ...
      [3:1:5] ...
      10 20 50];
main=fix(main*10^nd)/10^nd;

r=fix(r*10^nd)/10^nd;
Center=r./(1+r);
Radii=1./(1+r);
anglestep=pi/180; % 1 degree step
figure(gcf);
hold on
for ii=1:length(r)
   pnts=points(r(ii)+j*xL(ii),r(ii)+j*xR(ii),Center(ii),Radii(ii),anglestep);
   if ~isempty(find(r(ii)==main))
      fprintf('%f\n', r(ii));
      Col=[0 0 1];
   else
      Col=[1 0 0];
   end
   
   plot(pnts,'color', Col);
   plot(conj(pnts), 'color', Col);
end

x=fix(x*10^nd)/10^nd;
Center=1+j./x;
Radii=1./x;
for ii=1:length(x)
   pnts=points(rL(ii)+j*x(ii),rR(ii)+j*x(ii),Center(ii),Radii(ii),anglestep);
   if ~isempty(find(x(ii)==main))
      Col=[0 0 1];
   else
      Col=[1 0 0];
   end
   plot(pnts, 'color',Col);
   plot(conj(pnts),'color', Col);
end

plot(exp(j*[0:360]*pi/180),'color', [0 0 1])
plot([-1 1],[0 0], 'color', [0 0 1])

axis equal
axis off

return
function pnts=points(zL,zR,C,R,anglestep)
% computes the complex points laying on a circle
% of radius R centered at C. The points are those between
% the values of impedance zL to zR which should be on the circle.
% anglestep is the angular step for computing the points

phiL=angle((zL-1)/(zL+1)-C); %this is the angle of rho-Center
phiL=(phiL>0)*phiL+(phiL<=0)*(phiL+2*pi); %convert -pi/pi to 0/2*pi
phiR=angle((zR-1)/(zR+1)-C);
phiR=(phiR>0)*phiR+(phiR<=0)*(phiR+2*pi);
nn=ceil(abs(phiL-phiR)/anglestep)+1; %number of points
pnts=R*exp(j*linspace(phiL,phiR,nn))+C;
return

