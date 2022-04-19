# The MIT License (MIT)
#
# Copyright (c) 2022 Roman Szewczyk
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
#
# DESCRIPTION:
# NETGEN .geo file connected with the paper:
# A. Ostaszewska-Lizewska, D. Kopala, R. Szewczyk
# "Improved control of mesh density in adaptive tetrahedral meshes 
# for finite element modeling"
# submitted to Measurement Automation Robotics Journal
# (Pomiary Automatyka Robotyka), www.par.pl
#
algebraic3d

# core 

solid Core = cylinder ( 0, 0, -6; 0, 0, 6; 1)
	and plane (0, 0, -5; 0, 0, -1)
	and plane (0, 0,  5; 0, 0, 1) -maxh = 0.2;  # or 0.35

# Sfera

solid Sfera = sphere (0, 0, 0; 50) 
	 and not Core;


tlo Core -col=[0,0,1];
tlo Sfera -col=[1,20,40] -transparent;
