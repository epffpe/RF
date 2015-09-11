%%%%%%%%%%%   Diseño Amplificadores microondas por el metodo de adaptacion conjugada a la entrada   %%%%%                                                       %%%%%%                                                        
%%%%%    programa para dibujar los circulos de estabilidad en la Carta de Smith para ACE.  




global hw_ACE

hw_ACE=figure;
   set(hw_ACE,'Menubar','none','number','off','units','norm','pos',...
      [0.2,0.2,0.6,0.6],'name','TSC Amplifiers Design. Input conjugate matching.','color','white');
   
 
%cargar parametros
load par_ACE.mat

scplain;
TITLE('SMITH CHART FOR \Gamma_S');

%en estas primeras líneas se colocan los datos del transistor
s(1,1)=S11*(cos(F11*pi/180)+j*sin(F11*pi/180));
s(2,1)=S21*(cos(F21*pi/180)+j*sin(F21*pi/180));
s(1,2)=S12*(cos(F12*pi/180)+j*sin(F12*pi/180));
s(2,2)=S22*(cos(F22*pi/180)+j*sin(F22*pi/180));

%punto de factor de ruido minimo (Gama optima)
xopt=ropt*cos(Fropt*pi/180);
yopt=ropt*sin(Fropt*pi/180);

%aquí se acaban los datos de entrada

det=s(1,1)*s(2,2)-s(1,2)*s(2,1);
%estabilidad incondicional
k=(1+(abs(det))^2-(abs(s(1,1)))^2-(abs(s(2,2)))^2)/2/abs(s(1,2)*s(2,1));
%dibujo la carta de Smith:
AXIS([-1.2 +1.2 -1.5 +1.3]);


clear hw_main;

%estabilidad a la salida:

denom=((abs(s(1,1)))^2-(abs(det))^2);
centro=(conj(s(1,1))-conj(det)*s(2,2))/denom;
radio=abs(s(1,2)*s(2,1))/abs(denom);

limitinfx=real(centro)-radio;
limitsupx=real(centro)+radio;
x=linspace(limitinfx,limitsupx,1000);
y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
x=[x x];
figure(hw_ACE);
plot(x,y,'.b');

%punto de factor de ruido minimo
figure(hw_ACE);
plot(xopt,yopt,'*y')
legend ('location','NorthOutside','blue circle: | \Gamma _2 | =1', 'Yellow circles: F(dB), increment: 0.2dB','black circle: | \Gamma_L |=1');

%circulos de factor de ruido constante:
for ii=1:5
    Fmin=10^(FmindB/10);
    FdB=FmindB+0.2*ii;
    F=10^(FdB/10);
n=(F-Fmin)/4/rn*(abs(1+xopt+j*yopt))^2;
centro=(xopt+j*yopt)/(1+n);
radio=sqrt((n*(1+n-(abs(xopt+j*yopt))^2)))/(1+n);
limitinfx=real(centro)-radio;
limitsupx=real(centro)+radio;
x=linspace(limitinfx,limitsupx);
y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
x=[x x];
figure(hw_ACE);
plot(x,y,'.y');
end;
%circulo de estabilidad para gamaL (gamaL=1)
c1=s(1,1)-det*conj(s(2,2));
centro=conj(c1)/(1-(abs(s(2,2)))^2);
radio=abs(s(1,2)*s(2,1))/(1-(abs(s(2,2)))^2);
limitinfx=real(centro)-radio;
limitsupx=real(centro)+radio;
x=linspace(limitinfx,limitsupx);
y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
x=[x x];
figure(hw_ACE);
plot(x,y,'.k');

uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.8,0.14,0.05],'string','S(1,1):','hori','left');
 uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.75,0.14,0.05],'string','S(1,2):','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.7,0.14,0.05],'string','S(2,1):','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.65,0.14,0.05],'string','S(2,2):','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.6,0.14,0.05],'string','Phase(1,1):','hori','left');
    uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.55,0.14,0.05],'string','Phase(1,2):','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.5,0.14,0.05],'string','Phase(2,1):','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.45,0.14,0.05],'string','Phase(2,2):','hori','left');
  
    uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.4,0.14,0.05],'string','Gamma_opt:','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.35,0.14,0.05],'string','Phase_Gamma _opt:','hori','left'); 
   
    uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.3,0.14,0.05],'string','FmindB:','hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.01,0.25,0.14,0.05],'string','rn:','hori','left'); 
  
  
  
  
  
  
  
  uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.8,0.1,0.05],'string',S11,'hori','left');
 uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.75,0.1,0.05],'string',S12,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.7,0.1,0.05],'string',S21,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.65,0.1,0.05],'string',S22,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.6,0.1,0.05],'string',F11,'hori','left');
    uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.55,0.1,0.05],'string',F12,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.5,0.1,0.05],'string',F21,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.45,0.1,0.05],'string',F22,'hori','left');
    uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.4,0.1,0.05],'string',ropt,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.35,0.1,0.05],'string',Fropt,'hori','left'); 
 
    uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.16,0.3,0.1,0.05],'string',FmindB,'hori','left');
	uicontrol(hw_ACE,'style','text','fore','b','back','w','units','norm','pos',...
      [0.09,0.25,0.1,0.05],'string',rn,'hori','left'); 
  
  
      