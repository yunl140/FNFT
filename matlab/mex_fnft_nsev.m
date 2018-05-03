% MEX_FNFT_NSEV Fast nonlinear Fourier transform for the nonlinear
% Schroedinger equation with vanishing boundaries.
%
%   [contspec, bound_states, normconsts] = MEX_FNFT_NSEV(q, T, XI, kappa)
%   [contspec, bound_states, normconsts] = MEX_FNFT_NSEV(q, T, XI, kappa,
%       OPTIONAL INPUTS)
%
% DESCRIPTION
%   Provides an interface to the C routine fnft_nsev.
%
% INPUTS
%   q               Complex row vector of length D=2^n
%   T               Real 1x2 vector
%   XI              Real 1x2 vector
%   kappa           +1.0 or -1.0
%
% OPTIONAL INPUTS
%   It is possible to provide additional inputs. These come either in the
%   form of a single string or of a string followed by a value.
%
%   'bsloc_fasteigen'   Use fast eigenvalue method to locate bound states.
%                   This method is very reliable, but requires O(D^2)
%                   flops. This input is not followed by a value.
%   'bsloc_newton'  Use Newton's method to locate bound states. This method
%                   is reliable if good intial guesses for the bound states
%                   are known. Followed by a complex row vector of K
%                   initial guesses. It requires O(niter KD) flops.
%   'bsloc_subsamp_refine' Use a mixed method to locate bound states. First
%                   get initial guesses for the bound states by applying
%                   the 'fasteigen' method to a subsampled version of the
%                   signal. Then refine using 'newton' based on the full
%                   signal. This method is reliable if D is not too low.
%                   It requires O(niter D log^2 D) flops if Dsub (see
%                   below) is set by the algorithm. Not followed by a
%                   value.
%   'bsloc_niter'   Number of iterations to be carried by Newton's method.
%                   Followed by a scalar double.
%   'bsloc_Dsub'    The desired number of samples for the subsampled signal
%                   in the 'subsamp_refine' method. Less samples in the
%                   subsampled stage result in faster execution time, but
%                   might also lead to a loss of precision. Followed
%                   by scalar value. Note that the routine treates Dsub as
%                   as an indication. The actually used value might differ.
%   'bsfilt_none'   Do not filter bound states at all.
%   'bsfilt_basic'  Basic bound state filtering. Removes duplicates and
%                   bound states in the lower half plane.
%   'bsfilt_full'   Full bound state filtering. Additionally removes
%		            physically implausible bound states.
%   'discr_modal'   Use modified Ablowitz-Ladik discretization.
%   'discr_2split2A' Use split Boffetta-Osborne discretization.
%   'discr_2split4A' Use fifth order splitting with 4th degree polynomial.
%   'discr_2split4B' Use fifth order splitting with 2nd degree polynomial.
%   'dstype_residues'   Return residues instead of norming constants
%   'cstype_ab'     Returns values of a(xi) and b(xi) individually instead
%                   of the values of reflection coefficient b(xi)/a(xi)
%   'skip_cs'       Skip computation of the continuous spectrum.
%   'skip_bs'       Skip computation of the bound states. Implies 'skip_nc'.
%   'skip_nc'       Skip computation of the norming constants.
%   'quiet'         Turns off messages generated by then FNFT C library.
%                   (To turn off the messages generated by the mex
%                   interface functions, use Matlab's warning and error
%                   commands instead.)
%
% OUTPUTS
%   contspec        Complex row vector of length D (or [] if skipped)
%   bound_states    Complex row vector of length K (or [] if skipped)
%   normconsts      Complex row vector of length K (or [] if skipped)


% This file is part of FNFT.  
%                                                                  
% FNFT is free software; you can redistribute it and/or
% modify it under the terms of the version 2 of the GNU General
% Public License as published by the Free Software Foundation.
%
% FNFT is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%                                                                      
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.
%
% Contributors:
% Sander Wahls (TU Delft) 2017-2018.
