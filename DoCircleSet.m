function n=DoCircleSet(fid, zmin, zmax, r, hmax)
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
% Function creating the line of .msz file connected with the paper:
% A. Ostaszewska-Li¿ewska, D. Kopala, R. Szewczyk
% "Improved control of mesh density in adaptive tetrahedral meshes 
% for finite element modeling"
% submitted to Measurement Automation Robotics Journal
% (Pomiary Automatyka Robotyka), www.par.pl
%
  
  
n=(1+floor(2.*pi.*r./hmax)).*3;
  
for i=0:1:n

    fprintf(fid,'%1.3f %1.3f %1.3f %1.3f %1.3f %1.3f %1.3f\n', ...
               r.*cos(2.*pi.*i./n),r.*sin(2.*pi.*i./n), zmax, ...
               r.*cos(2.*pi.*i./n),r.*sin(2.*pi.*i./n), zmin, hmax);
  
end
%  

end  
