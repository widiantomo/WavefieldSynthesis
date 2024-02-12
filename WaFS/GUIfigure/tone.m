function out=tone(freq,leng,pha,ww)
% out = tone(frequency, length, phase shift (smaples))
% 
% This function creates a sinusoidal signal
% If 'frequency' is a vector, the function produces a
% set of sinusoids.
%
% Sampling rate is 44.1 kHz
%
% This file is a part of HUTear- Matlab toolbox for auditory
% modeling. The toolbox is available at 
% http://www.acoustics.hut.fi/software/HUTear/

% Copyrights: Aki Härmä, Helsinki University of Technology, 
% Laboratory of Acoustics and Audio Signal Processing, 
% Espoo, Finland.
% Date: August 20 1999
% Email: Aki.Harma@hut.fi

if nargin<3 pha=0; end
if nargin<4 ww=0; else ww=1;end

if length(freq)==1,
	if freq==22050,out=(-1).^(1:leng);
        else
	out=sin(2*pi*((1:leng)-pha)*freq/44100);
  	end;
	if ww==1, out=out.*hanning(length(out))';end    
    	break;
else
	out=zeros(1,leng);
	l=length(freq);
	for q=1:l,
		out=out+sin(2*pi*((1:leng)-pha)*freq(q)/44100);
	end
	out=out/max(out);
end

	if ww==1, out=out.*hanning(length(out))';end		
