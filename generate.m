% The MIT License (MIT)
%
% Copyright (c) 2022 Roman Szewczyk
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
% 
%
% DESCRIPTION:
% Script generating .msz file connected with the paper:
% A. Ostaszewska-Lizewska, D. Kopala, R. Szewczyk
% "Improved control of mesh density in adaptive tetrahedral meshes 
% for finite element modeling"
% submitted to Measurement Automation Robotics Journal
% (Pomiary Automatyka Robotyka), www.par.pl
%

clear all
clc

% ---- Definition of parameters values ----

% - Physical parameters -

mi0=4.*pi.*1e-7;      % maqgnetic constant

mi = 1e3.*mi0;        % relative magnetic permeability

ro = 1.6e-7;          % resitivity (Ohm*m)

R=1e-3;               % Radius of the wire (m)

I=1;                  % Total driving current in the wire (A)

f=3000;               % Driving current frequency (Hz)

% - Modelling parameters -

b=3;                  % Number of dividing point

nlay=3;               % Number of layers in each section

hmax=0.2;             % Maximal height of the tetrahedral element

zmin=-5;              % X - position of the beginning of the wire 
zmax=5;               % X - position of the ending of the wire 

% - Calculated parameters -

w=2.*pi.*f;

k=sqrt(-1.*w.*mi.*i./ro);


% ---- Calculation of the eddy current distribution ---

r = 0:0.01.*R:R;

J=[];

for m=1:numel(r)

  J=[J abs(k.*I./(2.*pi.*R).*J0(k.*r(m))./J1(k.*R))];

end
%

% Plot eddy current distribution

plot(r.*1e3,J./1e6,'-k','linewidth',2);
set(gca,'fontsize',24);
%set(gca(), 'xticklabel', {'0.0','0.2','0.4','0.6','0.8','1.0'});
%set(gca(), 'yticklabel', {'0.0','0.5','1.0','1.5','2.0'});
xlabel('{\it distance from cable axis r (mm)}');
ylabel('{\it current density i (MA/m^2)}');
grid;                                           

hold on;

% Determine and plot division points 

rb=0;
Jb=min(J);

for m=1:b
  
  x=interp1(J,r,max(J).*m./b);
  if ~isnan(x)
    rb=[rb x];
    Jb=[Jb interp1(r,J,rb(end))];
  end
  
end
%

plot(rb.*1e3,Jb./1e6,'or','linewidth',2);

for m=1:numel(rb)
  plot([rb(m).*1e3,rb(m).*1e3],[0, J(end)./1e6],'-r','linewidth',1);
end
%

if numel(rb)==2
  fprintf('\n nothing to do \n\n');
  return
end
%

% Create .msz file

fid=fopen('simple.temp','w');

n=0;


for m=numel(rb):-1:3

%  nlay=3 fixed

  L=[];
  
  L=rb(m);
  plot([rb(m).*1e3,rb(m).*1e3],[0, J(end)./1e6],':b','linewidth',2);
  
  n_=DoCircleSet(fid, zmin, zmax, rb(m).*1e3, (rb(m)-rb(m-1))./3.*1e3)
  n=n+n_;
  
  for m2=nlay-1:-1:1
  
   L=[L rb(m-1)+m2./nlay.*(rb(m)-rb(m-1))];
   plot([(rb(m-1)+m2./nlay.*(rb(m)-rb(m-1))).*1e3, ...
         (rb(m-1)+m2./nlay.*(rb(m)-rb(m-1))).*1e3], ...
        [0, J(end)./1e6],':b','linewidth',2);
  
   n_=DoCircleSet(fid, zmin, zmax, (rb(m-1)+m2./nlay.*(rb(m)-rb(m-1))).*1e3,...
                                   (rb(m)-rb(m-1))./nlay.*1e3)
   n=n+n_;
  
  end
  
end
%

L=rb(2);
plot([rb(2).*1e3,rb(2).*1e3],[0, J(end)./1e6],':b','linewidth',2);

n_=DoCircleSet(fid, zmin, zmax, rb(2).*1e3, (rb(3)-rb(2))./3.*1e3)
n=n+n_;
%
hold off;

% Finalize .msz file

fclose(fid);

fid=fopen('simple.head','w');
fprintf(fid,'0\n%i\n',n);
fclose(fid);

system('copy simple.head + simple.temp simple.msz > nul');

unlink('simple.temp');
unlink('simple.head');

% - End of the script -
