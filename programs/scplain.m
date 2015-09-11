%scplain.m
%test program
% computes the r and x values for drawing a smith chart
% similar to the one printed by Kay electric co.
%and draws the smith chart using the routines of Mohammad Ashfaq
%ICS 10-1-02

%GridSpacing=[10  2  1 0.2 0.1 0.05 0.02 0.01]; %Ramo
%GridSize=   [50 20 10 5   2   1    0.5  0.2 ]; %Ramo

%GridSpacing=[50  5  1 0.5 0.2 0.1 0.05]; %Ashfaq
%GridSize=   [50 20 10 5   3   2   1   ]; %Ashfaq
%[r,xL,xR]=scgrid(GridSize,GridSpacing);

[r,xL,xR]=scgrid;
scplot(r, r, 'k', xR, xL, xR, xL);

%return
rPrint = [[0.1:0.1:1.0] [1.2:.2:2] 3.0 4.0 5.0 10 20 50];
xPrint = rPrint;
ChColor='k';

% PRINT r VALUES
scPrnVal(rPrint, 'r');

% PRINT x VALUES
scPrnVal(xPrint, 'x');

% DRAW THE ANGLE BOUNDARY
scConCirc(1.01,'r');
scConCirc(1.08,'r');
scAngles(1.01, 1.08, 'r');

% DRAW THE LENGTH BOUNDARY
scConCirc(1.085,'m');
scConCirc(1.16,'m');
scLength(1.085, 1.16, 'm');


scScales(0);
