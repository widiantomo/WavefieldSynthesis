load signalmulti
[x,y] = size(sigout);
ext = '.wav';
for dd = 1:y
    file = [num2str(dd) ext];
    wavwrite(sigout(:,dd),44100,file);
end
