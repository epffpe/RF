function file (op)
%%% Funcion opciones Men� FILE %%%
%%% M.A. Llamas%%%

global hw_main
control=op;


% Opci� LOAD

if control==1
   [FILENAME,PATHNAME]=uigetfile('*.mat','Open');
   if ~isempty(FILENAME),dos(['copy ',PATHNAME,FILENAME,'par_ACE.mat']);
   end;
%op=4;   
end;

% Opci� SAVE

if control==2
   [FILENAME,PATHNAME]=uiputfile('*.mat','Save As');
   if ~isempty(FILENAME),dos(['copy par_ACE.mat ',PATHNAME,FILENAME]);
      end;
end;

% Opci� EXIT

if control==3
   close(hw_main);
   clear hw_main;
end;

end;

