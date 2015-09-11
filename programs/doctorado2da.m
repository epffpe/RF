
warning off
%programa para dibujar los circulos de estabilidad en la Carta de Smith para F=F1 Y M=M1.
%representacion de la carta de smith


global hw_Fmin
 
   hw_Fmin=figure;
   set(hw_Fmin,'Menubar','none','number','off','units','norm','pos',...
      [0.2,0.2,0.6,0.6],'name','TSC Amplifier design with F and M_1 selected.','color','white');
   

%cargar parametros
load temp.mat

scplain;
TITLE('SMITH CHART FOR \Gamma_L');
%en estas primeras líneas se colocan los datos del transistor
s(1,1)=S11*(cos(F11*pi/180)+j*sin(F11*pi/180));
s(2,1)=S21*(cos(F21*pi/180)+j*sin(F21*pi/180));
s(1,2)=S12*(cos(F12*pi/180)+j*sin(F12*pi/180));
s(2,2)=S22*(cos(F22*pi/180)+j*sin(F22*pi/180));

%punto de factor de ruido minimo (Gama optima)
x=ropt*cos(Fropt*pi/180);
y=ropt*sin(Fropt*pi/180);

%aquí se acaban los datos de entrada


%clear hw_main;



% VALORES A ESCOGER. PROBAR VARIAS OPCIONES!!
%FACTOR DE RUIDO A LA ENTRADA
% Escogemos el valor de la desadaptacion a la entrada:
%escogemos la separación entre los círculos de ganancia de potencia (se dibujaran 10)
%Gp=incrgp*(ii-1);%10 valores para Gp (en lineal) se puede cambiar 

incrgp=5;%es un valor de incremento en unidades lineales. 

det=s(1,1)*s(2,2)-s(1,2)*s(2,1);
%estabilidad incondicional
k=(1+(abs(det))^2-(abs(s(1,1)))^2-(abs(s(2,2)))^2)/2/abs(s(1,2)*s(2,1))
%dibujo la carta de Smith:
AXIS([-1.2 +1.2 -1.5 +1.3]);


%circulo estabilidad para gama_1 (gama_1=1)   

denom=((abs(s(2,2)))^2-(abs(det))^2);
centro=(conj(s(2,2))-conj(det)*s(1,1))/denom;
radio=abs(s(1,2)*s(2,1))/abs(denom);

limitinfx=real(centro)-radio;
limitsupx=real(centro)+radio;
x=linspace(limitinfx,limitsupx,1000);
y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
x=[x x];
plot(x,y,'.b');

%circulos de ganancia Gp constante:
for ii=1:20
   Gp=incrgp*(ii-1);%10 valores para Gp que estan entre 0 y 45 (en lineal) se puede cambiar 
   %valores de la ganancia en dB:
   GpdB=10*log10(Gp);
   g=Gp/abs(s(2,1))^2;
   c2=s(2,2)-det*conj(s(1,1));
   term1=abs(s(2,2))^2-abs(det)^2;
   centro=g*conj(c2)/(1+g*term1);
   radio=sqrt(abs(s(1,2)*s(2,1))^2*g^2-2*k*abs(s(1,2)*s(2,1))*g+1)/abs(1+g*term1);
   limitinfx=real(centro)-radio;
   limitsupx=real(centro)+radio;
   x=linspace(limitinfx,limitsupx);
   y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
   x=[x x];
   plot(x,y,'.k');
end
x=ropt*cos(Fropt*pi/180);
y=ropt*sin(Fropt*pi/180);
F=10^(FdB/10);
Fmin=10^(FmindB/10);

n=(F-Fmin)/4/rn*(abs(1+x+j*y))^2;
centro=(x+j*y)/(1+n);
radio=sqrt((n*(1+n-(abs(x+j*y))^2)))/(1+n);
limitinfx=real(centro)-radio;
limitsupx=real(centro)+radio;
x=linspace(limitinfx,limitsupx,100);
y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
x=[x x];
%plot(x,y,'.y');
%Hemos de escoger n puntos sobre este círculo que son justo los anteriores:
gamas=x+j*y;%tengo 100 puntos.
%deberíamos eliminar los puntos sobre este círculo que son inestables si es
%que los hay
gama2=s(2,2)+(s(1,2)*s(2,1)*gamas./(1-s(1,1)*gamas));
gama2=gama2(abs(gama2)<1);
for ii=1:size(gama2,2)
   m1=M1*(1-abs(gamas(ii))^2);
   term1=conj((s(2,2))-det*conj(s(1,1)));
   term2=gamas(ii)*det-s(2,2);
   term3=1-gamas(ii)*s(1,1);
   num=m1*term1+conj(term2)*term3;
   term4=abs(s(2,2))^2-abs(det)^2;
   denom=m1*term4-abs(term2)^2;
   centro=num/denom;
   radio=sqrt(abs(centro)^2+(abs(term3)^2-m1*(1-abs(s(1,1)^2)))/denom);
   limitinfx=real(centro)-radio;
   limitsupx=real(centro)+radio;
   x=linspace(limitinfx,limitsupx,1000);
   y=[imag(centro)+sqrt(radio^2-(x-real(centro)).^2) imag(centro)-sqrt(radio^2-(x-real(centro)).^2)];
   x=[x x];
   plot(x,y,'.y');
  
   %deberíamos guardar para cada círculo el punto que tiene ganancia máxima
   gamal=x+j*y;
   gamal=gamal(find(abs(gamal)<1));
   gama1=s(1,1)+s(1,2)*s(2,1)*gamal./(1-s(2,2).*gamal);
   gain=abs(s(2,1))^2*(1-abs(gamal).^2)./abs(1-s(2,2)*gamal).^2./(1-abs(gama1).^2);
   if ~isempty(gain)
   [gainmax(ii),cual]=max(10*log10(gain));
   gamalopt(ii)=gamal(cual);
   else
       gainmax(ii)=NaN;
       gamalopt(ii)=NaN;
   end
end
gainmax=gainmax(isfinite(gainmax));
gamalopt=gamalopt(isfinite(gamalopt));
gamas=gamas(isfinite(gamalopt));
[maxgainmax,cual]=max(gainmax);
gamaloptima=gamalopt(cual);
  gamasopt=gamas(cual);
   annotation('textbox',[.8 .7 .1 .1],'String','BEST SOLUTION');
 annotation('textbox',[.8 .5 .1 .1],'String',{['$\Gamma_S$=' num2str(abs(gamasopt),'%.2f') '$\angle$' num2str(180/pi*angle(gamasopt),'%.2f') '$^\circ$']},'Interpreter','latex');
   annotation('textbox',[.8 .4 .1 .1],'String',{['$\Gamma_L$=' num2str(abs(gamaloptima),'%.2f') '$\angle$' num2str(180/pi*angle(gamaloptima),'%.2f') '$^\circ$']},'Interpreter','latex');
   annotation('textbox',[.8 .3 .1 .1],'String',['G_P=' num2str(maxgainmax,'%.2f') 'dB']);
   uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.8,0.1,0.05],'string','S(1,1):','hori','left');
   uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.75,0.1,0.05],'string','S(1,2):','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.7,0.1,0.05],'string','S(2,1):','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.65,0.1,0.05],'string','S(2,2):','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.6,0.1,0.05],'string','Phase(1,1):','hori','left');
    uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.55,0.1,0.05],'string','Phase(1,2):','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.5,0.1,0.05],'string','Phase(2,1):','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.45,0.1,0.05],'string','Phase(2,2):','hori','left');
   uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.4,0.1,0.05],'string','Gamma_opt','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.35,0.1,0.05],'string','Phase_Gamma_opt','hori','left'); 
  
    uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.3,0.1,0.05],'string','FmindB:','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.25,0.1,0.05],'string','rn:','hori','left'); 
  uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.2,0.1,0.05],'string','FdB:','hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.05,0.15,0.1,0.05],'string','M1:','hori','left'); 
  
  
 
  
  uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.8,0.1,0.05],'string',S11,'hori','left');
  uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.75,0.1,0.05],'string',S12,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.7,0.1,0.05],'string',S21,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.65,0.1,0.05],'string',S22,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.6,0.1,0.05],'string',F11,'hori','left');
    uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.55,0.1,0.05],'string',F12,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.5,0.1,0.05],'string',F21,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.45,0.1,0.05],'string',F22,'hori','left');
  uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.4,0.1,0.05],'string',ropt,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.14,0.35,0.1,0.05],'string',Fropt,'hori','left'); 
  
    uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.16,0.3,0.1,0.05],'string',FmindB,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.09,0.25,0.1,0.05],'string',rn,'hori','left'); 
  uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.12,0.2,0.1,0.05],'string',FdB,'hori','left');
	uicontrol(hw_Fmin,'style','text','fore','b','back','w','units','norm','pos',...
      [0.12,0.15,0.1,0.05],'string',M1,'hori','left'); 
  

