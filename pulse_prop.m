%Pulse propagation:
%
%           /\   /\
% E(x,t) =  | dw | dx {E(kx,w) * exp[i*(w*t - kx*x - kz*z)]}
%          \/   \/
%
%              /    /                    \               \
%        = FT <  FT | E(kx,w), (kx -> x) |, (w -> t-|k|z) >
%              \    \                    /               /
% kz	= sqrt(|k|^2 - kx^2) - |k|
% |k|	= w/c
%
% Note this is in the time frame moving along the propagation axis.
%
% Angular dispersion is when the propagation direction is dependant on frequency:
%	k -> k - alpha * w
%
% This is equivalent in the spatial domain to a linear phase:
%	E(x, w) -> |E(x, w)| * exp(i * alpha * w * x)
%
% This is then equivalent to a spatially dependant shift in the time domain:
%	E(x, t) -> E(x, t - alpha * x)
%
% This thus represents pulse front tilt.
% As the pulse propagates along axis (z direction), it will diffract. Thus the dominant
% phase term is the radius of curvature (almost quadratic) sqrt(|k| - kx^2)*z. Thus any
% STC is lost, except that the pulses is delayed the further from the propagation axis.


%%	Some useful functions
gauss = @(x, x0, FWHM) 2^(-(2*(x-x0)./FWHM).^2);%	Gaussian of full width half max (FWHM) centred at x0
chng_rng = @(x, c) 2*pi*c./x;					%	Changed between wavelength and angular frequency


%%	Initialise array sizes
Nx = 256;										%   # spatial points
Nk = Nx;										%   # k-vector points (FT of x)
Nw = 256;										%   # freq. points
Nt = Nw;										%   # temporal points (FT of w)
c = .3;											%	Speed of light um/fs


%%	Setup frequency data
wmin = chng_rng(1, c);							%	Min w value
wmax = chng_rng(.5, c);							%	Max w value
w0 = mean([wmin, wmax]);						%   Central wavelength (rad/fs)
wFWHM = w0*.01;									%   Bandwidth
w = (0:Nw-1)*(wmax-wmin)/(Nw-1) + wmin;			%   Freq. range rad/fs
t = ((0:Nt-1)-Nt/2)*2*pi/(wmax-wmin);			%	Time domain /fs
W = ones(Nx, 1)*w;								%	Freq. range for all kx

EW = gauss(W, w0, wFWHM);						%	Spectrum


%%	Setup spatial data & angular dispersion
x = ((2*(0:Nx-1)'/(Nx-1))-1)*1e4;				%   Spatial co-ord /um
k = fftshift(((0:Nk-1)'-Nk/2)*2*pi/(max(x)-min(x)));
												%   kx-values
K = k*ones(1, Nw);								%	kx values for all w.
alpha = 0.5;									%	Angular dispersion
xFWHM = 500;									%	Beam width /um

EX = (gauss(x, 0, xFWHM)*ones(1,Nw)) ...		%	Spatial profile
	.* exp(i*alpha*x*(2*(0:Nw-1)/(Nw-1)-1));	%	Angular dispersion

EK = abs(ifft(ifftshift(EX, 1), [], 1));		%	k-vector components


%%	Propagation phase & Electric field
phi_kw = @(z) (sqrt((W/c).^2-K.^2)-W/c)*z;		%	Phase along z-axis

E_kw = @(z) EK.*EW.*exp(-i*phi_kw(z));
												%	Electric field for each k-w plane wave

%%	Initial Pulse
figure(1)
imagesc(t, x*1e-3, abs(fftshift(fft2(E_kw(0)))).^2);
axis([-50 50 -1 1]);
grid on;


%% Pulse Propagation
delta = 5;										%	Used for plotting above & below axis profile
for z=0:.2e5:1e6
	I_xt = abs(fftshift(fft2(E_kw(z)))).^2;		%	Pulse intensity in space & time at pos z
	
	subplot(2,1,1)
	imagesc(t, x*1e-3, I_xt);
 	axis([-350 350 -2 2])
	grid on;
	title(['z = ' num2str(z*1e-6, '%.3f') 'm']);
	xlabel('Time /fs');
	ylabel('Beam profile /mm');
	
	subplot(2,1,2)
	plot(t, I_xt([Nx/2-delta+1 Nx/2 Nx/2+delta+1], :));
	title('Pulse profile along propagation axis');
	xlabel('Time /fs');
	ylabel('Intensity /arb.');
	legend('Above axis', 'On axis', 'Below axis');
	axis([-350 350 0 max(max(I_xt([Nx/2-delta Nx/2 Nx/2+delta], :), [], 2))]);
	getframe;
end