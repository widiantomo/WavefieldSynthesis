% data = int8(data);

[xdata,ydata]=size(data);

for i=1:xdata
    for j=1:ydata
        tempd= (data{i,j});
        if tempd>0 
            data{i,j}=data{i,j};
        else
            data{i,j}=0;
        end
    end
end