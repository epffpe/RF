%%%	     AMPLIFIERS DESIGN      %%%%%%%
%%%%%%%%%%       N.DUFFO     %%%%%%%%%%%

function amplifier

%Variables globals

global hw_main
global tipus_test
logo=1;

if nargin<1
   
   hw_main=figure;
   set(hw_main,'Menubar','none','number','off','units','norm','pos',...
      [0.2,0.2,0.6,0.6],'name',' Amplifiers Design','color','white');
   
   
   
control=0;


menu_principal=str2mat(' File','Design','?');

	menu_file=str2mat('Exit');
   
   	menu_design=str2mat('Input Conjugate Matching','Design with F and M_1 selected ');
   
   		menu_adaptacion_conjugada=str2mat('Parameters','Computing');
         
        menu_factor_min_ruido=str2mat('Parameters','Computing');
         
   
         
% menu principal
   
for i=1:prod(size(menu_principal(:,1))),
   hmp(i)=uimenu('Position',i,'Label',menu_principal(i,:));
end;


% menu file

for i=1:prod(size(menu_file(:,1)))
   hmf(i)=uimenu(hmp(1),'Position',i,'Label',menu_file(i,:));
end;



set(hmf(1),'Callback','file(3);');




%%% menu Design %%%

for i=1:prod(size(menu_design(:,1)))
   hmcond(i)=uimenu(hmp(2),'Position',i,'Label',menu_design(i,:));
end;

	% Submenu adaptacio conjugada

	for i=1:prod(size(menu_adaptacion_conjugada(:,1)))
   		hm2p(i)=uimenu(hmcond(1),'Position',i,'Label',menu_adaptacion_conjugada(i,:));
	end;
   
   	set(hm2p(1),'Callback','paramACE;');
	set(hm2p(2),'Callback','doctoradoda;');
	
   
   % Submenu Factor de ruido minimo

	for i=1:prod(size(menu_factor_min_ruido(:,1)))
   		hm3p(i)=uimenu(hmcond(2),'Position',i,'Label',menu_factor_min_ruido(i,:));
	end;
   
  	set(hm3p(1),'Callback','paramFyM;');
	set(hm3p(2),'Callback','doctorado2da;');
	
end;		





