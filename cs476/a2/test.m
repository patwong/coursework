x = zeros(3,3);
for i=0:2
    for j=0:2
        x(j+1,i+1) = i+j+1;
    end
end
x