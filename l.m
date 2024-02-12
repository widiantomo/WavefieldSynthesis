transisik = round(rand(5,5)*10);

bawah = sum(transisik,1)
kanan = sum(transisik,2);

for cv=1:5
    upgrade(cv) = bawah(cv)-sum(transisik(1:cv,cv))
    downgrade(cv) = kanan(cv) - sum(transisik(cv,1:cv))
end