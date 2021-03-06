% function [k2]=LeeSch2(xn, yn, os, R, A, swap, delay)
%
% k2 is the second order kernel of Wiener series according to Lee-Schetzen 
% method, which will contain not-a-NaN values ony within the set of 
% fundamental points, which is the minimum set of non-diagonal points which 
% allows the reconstruction of non-diagonal kernel points by symmetry 
% (see symmetrize function).
% For diagonal points refer to WVdiag2 function.
%
% xn is the input sequence.
%
% yn the output sequence.
%
% os is the input/output sequences index from where the cross-correlation is 
% started, all the sequence values before os are thrown. In can be used when
% xn and yn have been obtained from an A/D conversion and we the initial 
% transient conditions cut away.
%
% R is the length corresponding to length(k2)-1. The lags domain interval 
% corresponding to k2 is [0,R]x[0,R].
%
% A is the second order moment of xn (i.e. power).
%
% swap it's an optional parameter for speed optimization (see fastxcorr for 
% insights), it depends on the machine you're on, and on having compiled this 
% code or not. If you don't know what to do use default value. 
% (We choose 23 in octave environment and 11 in the standalone version)
%
% delay gives the result restricted to the lags domain interval 
% [0+delay,R]x[0+delay,R], most useful for higher order kernels.
%
% If you want to contact the authors, please write to s.orcioni@univpm.it,
% or Simone Orcioni, DII, Università Politecnica delle Marche,
% via Brecce Bianche, 12 - 60131 Ancona, Italy.

% Copyright (C) 2006 Massimiliano Pirani
%
%  This program is free software; you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation; either version 2 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License along
%  with this program; if not, write to the Free Software Foundation, Inc.,
%  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


function [k2]=LeeSch2(xn,yn,os,R,A,swap,delay)

    L=length(xn(os:end-delay));
    k2=NaNmat(R+1,R+1);   
    A2=A*A;
    for sgm1=1:R
        
        k2(sgm1+1,1:sgm1)=0.5/A2*frxcorr(xn(os:end-delay),...
            [zeros(sgm1,1);xn(os:end-sgm1-delay)].*yn(os+delay:end),...
            L,...
            sgm1-1,0,swap)';
    end
end

