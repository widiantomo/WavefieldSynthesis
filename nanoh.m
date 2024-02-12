[x,y] = size(fff);

for yu = 1:x
    hhh = isnan(fff(yu,:));
    for re = 1:y
        if hhh(re) == 1
            fff(yu,re) = 0;
        else
            fff(yu,re) = fff(yu,re);
        end
    end
    disp(yu)
end