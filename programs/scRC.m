function scRC(r, x, LinCol, xR, xL, rR, rL)


Center=r./(1+r);
Radii=1./(1+r);
step=pi/180; % 1 degree step

for ii=1:length(r)
   pnts=points(r(ii)+j*xL(ii),r(ii)+j*xR(ii),Center(ii),Radii(ii),step);
   plot(pnts);
   hold on
   plot(conj(pnts));
end

Center=1+j./x;
Radii=1./x;
for ii=1:length(x)
   pnts=points(rL(ii)+j*x(ii),rR(ii)+j*x(ii),Center(ii),Radii(ii),step);
   plot(pnts);
   hold on
   plot(conj(pnts));
end

plot(exp(j*[0:360]*pi/180))
plot([-1 1],[0 0])

axis equal

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

   