clear all
cd('c:\matlab7/work/lolita/out'); 
data_file=dir(fullfile(matlabroot,'work/lolita/out/*.csv'));
jumlahfile = length(data_file);

%for xx=1:jumlahfile
filename=data_file(1).name
fid= importdata(filename)