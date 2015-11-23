% Copyright (C) 2014 Simone Orcioni
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
%
% If you want to contact the authors, please write to s.orcioni@univpm.it,
% or Simone Orcioni, DEIT, Università Politecnica delle Marche,
% via Brecce Bianche, 12 - 60131 Ancona, Italy.
% If you are using this program for a scientific work, we encourage you to cite
% the following paper (the file cite.bib, containing the reference in bibtex
					   % format is also provided):
% Simone Orcioni. Improving the approximation ability of Volterra series identified
% with a cross-correlation method. Nonlinear Dynamic, 2014.
%
% Simone Orcioni, Massimiliano Pirani, and Claudio Turchetti. Advances in
% Lee-Schetzen method for Volterra filter identification. Multidimensional
% Systems and Signal Processing, 16(3):265-284, 2005.

memspan=10;
sigma_noise=[0.3,0.6,1.2,2.4];

Vkernel_n2 = ident_volt_20(2,memspan,sigma_noise,4e6,'nl_system');

tic
Vkernel03 = ident_volt(2,memspan,sigma_noise(1),4e6,'nl_system');
toc
tic
Vkernel06 = ident_volt(2,memspan,sigma_noise(2),4e6,'nl_system');
toc
tic
Vkernel12 = ident_volt(2,memspan,sigma_noise(3),4e6,'nl_system');
toc
tic
Vkernel24 = ident_volt(2,memspan,sigma_noise(4),4e6,'nl_system');
toc

xn = randn(1e6,1);

mseyn03 = test_sigma(Vkernel03, 2, 0.3,2.4, 'nl_system');
mseyn06 = test_sigma(Vkernel06, 2, 0.3,2.4, 'nl_system');
mseyn12 = test_sigma(Vkernel12, 2, 0.3,2.4, 'nl_system');
mseyn24 = test_sigma(Vkernel24, 2, 0.3,2.4, 'nl_system');

mseyn_n2 = test_sigma(Vkernel_n2, 2, 0.3,2.4, 'nl_system');

figure;
semilogy(mseyn03(:,1),mseyn03(:,2),'-or');hold
semilogy(mseyn06(:,1),mseyn06(:,2),'-or');
semilogy(mseyn12(:,1),mseyn12(:,2),'-or');
semilogy(mseyn24(:,1),mseyn24(:,2),'-or');

semilogy(mseyn_n2(:,1),mseyn_n2(:,2),'-xb');

save 'ident_nonlin2_kernel.mat' Vkernel_n2 Vkernel03 Vkernel06 Vkernel12 Vkernel24
save 'ident_nonlin2_err.mat' mseyn03 mseyn06 mseyn12 mseyn24 mseyn_n2