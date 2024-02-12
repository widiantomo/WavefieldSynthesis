function savestereo    
FS = 44100;
load signalmulti
[file,path] = uiputfile('stereo.wav','Save file name');
wavwrite(sigout,FS,file);