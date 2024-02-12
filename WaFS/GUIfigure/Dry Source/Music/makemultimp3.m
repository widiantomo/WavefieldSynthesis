function makemultimp3
[Filename,PathName] = uigetfile('*.wav','Select wave to be encoded');
y = wavread(Filename);
'[x,y] = size(sigout);
ext = '.mp3';
FS = 44100;
NBITS = 16;
ENCODING = 2;

for dd = 1:y
    file = [Filename '-' num2str(dd) ext];
    'wavwrite(sigout(:,dd),44100,file);
    MP3WRITE(Y,FS,NBITS,file,ENCODING)
end
