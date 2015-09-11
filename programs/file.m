function file (op)
%%% Funcion opciones Menú FILE %%%
%%% M.A. Llamas%%%

global hw_main
control=op;


% Opció LOAD

if control==1
   [FILENAME,PATHNAME]=uigetfile('*.mat','Open');
   if ~isempty(FILENAME),dos(['copy ',PATHNAME,FILENAME,'par_ACE.mat']);
   end;
%op=4;   
end;

% Opció SAVE

if control==2
   [FILENAME,PATHNAME]=uiputfile('*.mat','Save As');
   if ~isempty(FILENAME),dos(['copy par_ACE.mat ',PATHNAME,FILENAME]);
      end;
end;

% Opció EXIT

if control==3
   close(hw_main);
   clear hw_main;
end;

end;

