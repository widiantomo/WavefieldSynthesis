sigout = rand(10,3);
[x,y] = size(sigout);

waveblast = zeros(x,10);
waveblast(:,(1:y)) = waveblast(:,(1:y))+sigout;

size(waveblast)