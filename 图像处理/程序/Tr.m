function s = Tr(E)
L = 256;
m = L/2;
s = zeros(1,256);
for r = 1:256
    s(r) = 1/(1+(m/r)^E);
end
end

