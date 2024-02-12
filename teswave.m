r = [5 0;5.25 0;5.5 0];
s = [5 1];
f = 250;

% 5 meter
x = 1:0.02:5;

for ttt=1:size(r,1)
vt(ttt,1) = s(1)-r(ttt,1);
vt(ttt,2) = s(2)-r(ttt,2);
gg(ttt) = sqrt((vt(ttt,1)^2)+(vt(ttt,2)^2));
end

z=min(gg);
for ttt=1:length(r)
ph(ttt) = gg(ttt)-z;
Phase(ttt) = ph(ttt)*2*pi*f/344;
%drive
r = cos((2*pi*x*250/344)+Phase(ttt));
muke(:,ttt)=r;
end

Phase
plot(x,muke)

