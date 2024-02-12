function makebigmp3mchannel

cd('C:\MATLAB71\work\WaFS\GUIfigure\Dry Source\puretone');
%[pathstr, name, ext, versn] = fileparts(filewav);

sudut = {'n30o';'30o';'n30o';'30o';'0o';'0o';'15o';'n15o';'n30';'30'};
jarak = [2;2;4;4;2;8;8;8;100;100];

filebesar(1) = 'AL5Chan';
filebesar(2) = 'SH5Chan';
filebesar(3) = 'SI5Chan';

name(1) = 'AL';
name(2) = 'SH';
name(3) = 'SI';

sigoutbesar = zeros(1,5);

for yt = 1:3
    for dr = 1:10
file = ([name(yt) (sudut{dr}) num2str(jarak(dr)) num2str(dr)]);
load file
sigoutbesar = cat(1,sigoutbesar,sigout);
clear sigout;
    end
end

for yt = 1:3
    for dd = 1:5
    ext = '.mp3';
    FS = 44100;
    NBITS = 16;
    ENCODING = 2;
    MP3WRITE(sigout(:,dd),FS,NBITS,sigoutbesar(yt),1);
    end
end
