JumLS = 10
Spasi = 0.25

%Built the array boy!!!
%1. View the centre of the room
cent = 10/2;
side = floor(JumLS/2);
remind = mod(JumLS,2);

LSxpost = zeros(JumLS,1);
LSypost = zeros(JumLS,1);

if remind == 1
% make the speaker side by side
centre = ceil(JumLS/2);
%centre of the speaker
LSxpost(centre,1)=cent;

for kk=1:side
    %kanan
    LSxpost(centre+kk)= kk*Spasi + cent;
    %kiri
    LSxpost(centre-kk) = cent - kk*Spasi;
end    
for kk=1:JumLS
line(LSxpost(kk,1),LSypost(kk,1), ...
           'LineStyle','none', ...
           'Marker','.', ...
           'Color','b', ...
           'MarkerSize',15, ...
           'EraseMode','none');
end
else 
centre = JumLS/2;
kan=centre+1;
kiri=side-1;
startka = (cent+(Spasi/2));
startki = (cent-(Spasi/2));
for kk=0:1:kiri
    %kanan
    LSxpost(kan+kk) = startka + kk*Spasi;
    LSxpost(centre-kk) = startki - kk*Spasi;
end
end

LSxpost