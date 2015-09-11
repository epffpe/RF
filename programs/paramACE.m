%%%  Funció per editar els paràmetres para diseño amplifidor ACE  %%%
%%%           NDU      %%%

function paramACE (control)

%Variables globals

global hc hw_edit

if nargin<1
   
      
   hw_edit=figure;
   set(hw_edit,'Menubar','none','number','off','units','norm','pos',...
      [0.05,0.15,0.80,0.75],'name','DESIGN PARAMETERS (input conjugate matching)','color','white');
   
   
   % Definició text dels diferents paràmetres
   
   uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.1,0.8,0.2,0.05],'string','Amplitude S(1,1):','hori','left');
   uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.1,0.7,0.2,0.05],'string','Amplitude S(1,2):','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.1,0.6,0.2,0.05],'string','Amplitude S(2,1):','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.1,0.5,0.2,0.05],'string','Amplitude S(2,2):','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.5,0.8,0.2,0.05],'string','Phase S(1,1)º:','hori','left');
    uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.5,0.7,0.2,0.05],'string','Phase S(1,2)º :','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.5,0.6,0.2,0.05],'string','Phase S(2,1)º :','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.5,0.5,0.2,0.05],'string','Phase S(2,2)º :','hori','left');
    uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.1,0.4,0.2,0.05],'string','Amplitude(Gamma_opt) :','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.5,0.4,0.2,0.05],'string','Phase(Gamma_opt) º :','hori','left');
    
    uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.1,0.3,0.2,0.05],'string','Fmin (dB):','hori','left');
	uicontrol(hw_edit,'style','text','fore','b','back','w','units','norm','pos',...
      [0.5,0.3,0.2,0.05],'string','rn:','hori','left');
  
  
   % Definició requadres editables dels valors dels diferents paràmetres
   
   hc(1)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.3,0.8,0.1,0.05],'string','','hori','left');
   
   hc(2)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.3,0.7,0.1,0.05],'string','','hori','left');
 
	hc(3)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.3,0.6,0.1,0.05],'string','','hori','left');
   
 	hc(4)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.3,0.5,0.1,0.05],'string','','hori','left');
   
 	hc(5)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.7,0.8,0.1,0.05],'string','','hori','left');
  
    hc(6)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.7,0.7,0.1,0.05],'string','','hori','left');
 
	hc(7)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.7,0.6,0.1,0.05],'string','','hori','left');
   
 	hc(8)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.7,0.5,0.1,0.05],'string','','hori','left');
  
   hc(9)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.3,0.4,0.1,0.05],'string','','hori','left');
   
 	hc(10)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.7,0.4,0.1,0.05],'string','','hori','left');
  
    %hc(11)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
     % [0.3,0.3,0.1,0.05],'string','','hori','left');
   
 	%hc(12)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
   %   [0.7,0.3,0.1,0.05],'string','','hori','left');
  
   hc(13)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.3,0.3,0.1,0.05],'string','','hori','left');
   
 	hc(14)=uicontrol(hw_edit,'style','edit','fore','b','units','norm','pos',...
      [0.7,0.3,0.1,0.05],'string','','hori','left');
   
       
  
   % Definició botons OK i CANCEL
   
  	uicontrol(hw_edit,'style','push','units','norm','pos',...
      [0.1,0.1,0.2,0.05],'string','OK','call','paramACE(''leer'')');
   
	uicontrol(hw_edit,'style','push','units','norm','pos',...
      [0.5,0.1,0.2,0.05],'string','CANCEL','call','paramACE(''close'')');
   
   
else
   
	if strcmp(control,'leer')   
  
  %      load par_ACE.mat S11 S12 S21 S22 F11 F12 F21 F22 ropt Fropt FmindB rn
    
   %     set(hc(1),'string',num2str(S11));
    %    set(hc(2),'string',num2str(S12));
     %   set(hc(3),'string',num2str(S21));
      %  set(hc(4),'string',num2str(S22));
       % set(hc(5),'string',num2str(F11));
        %set(hc(6),'string',num2str(F12));
        %set(hc(7),'string',num2str(F21));
        %set(hc(8),'string',num2str(F22));
        %set(hc(9),'string',num2str(ropt));
        %set(hc(10),'string',num2str(Fropt));

        %Yopt=str2num(get(hc(11),'string'));
        %FYopt=str2num(get(hc(12),'string'));
        %set(hc(13),'string',num2str(FmindB));
        %set(hc(14),'string',num2str(rn));

 
  
   		S11=str2num(get(hc(1),'string'));
      	S12=str2num(get(hc(2),'string'));
      	S21=str2num(get(hc(3),'string'));  
	   	S22=str2num(get(hc(4),'string'));
      	F11=str2num(get(hc(5),'string'));
        F12=str2num(get(hc(6),'string'));
        F21=str2num(get(hc(7),'string'));
        F22=str2num(get(hc(8),'string'));
        ropt=str2num(get(hc(9),'string'));
        Fropt=str2num(get(hc(10),'string'));
        %Yopt=str2num(get(hc(11),'string'));
        %FYopt=str2num(get(hc(12),'string'));
        FmindB=str2num(get(hc(13),'string'));
        rn=str2num(get(hc(14),'string'));
        
        
        
       save par_ACE.mat S11 S12 S21 S22 F11 F12 F21 F22 ropt Fropt FmindB rn
      % close(hw_edit);  
       %clear hw_edit  hc
       
   	end;
      
      
   	if strcmp(control,'close')
         
         close(hw_edit);
         clear hw_edit hc
         
  	end;
       	
end;