function [localbest,localindex] = NeumannStru(IndivBest,xm)
%NEUMANNSTRU 此处显示有关此函数的摘要
%   此处显示详细说明
[n,~] = size(IndivBest);
localbest = zeros(n,1);
localindex = zeros(n,1);
%%%%冯诺依曼结构
for j = 1:n
    if j == 1
        IndivTemp1 = [IndivBest(1),IndivBest(2),IndivBest(9)];
        localbest(1) = max(IndivTemp1);
        if localbest(1) == IndivBest(1)
            localindex(1) = xm(1,:);
        elseif localbest(1) == IndivBest(2)
            localindex(1) = xm(2,:);
        else
            localindex(1) = xm(9,:);
        end
    elseif j == 8 %% 8
        IndivTemp2 = [IndivBest(7),IndivBest(8),IndivBest(16)];
        localbest(8) = max(IndivTemp2);
        if localbest(8) == IndivBest(7)
            localindex(8) = xm(7,:);
        elseif localbest(8) == IndivBest(8)
            localindex(8) = xm(8,:);
        else
            localindex(8) = xm(16,:);
        end
    elseif j == 57  %%%57
        IndivTemp3 = [IndivBest(49),IndivBest(57),IndivBest(58)];
        localbest(57) = max(IndivTemp3);
        if localbest(57) == IndivBest(49)
            localindex(57) = xm(49,:);
        elseif localbest(57) == IndivBest(57)
            localindex(57) = xm(57,:);
        else
            localindex(57) = xm(58,:);
        end
    elseif j == 64  %%%64
        IndivTemp4 = [IndivBest(63),IndivBest(64),IndivBest(56)];
        localbest(64) = max(IndivTemp4);
        if localbest(64) == IndivBest(63)
            localindex(64) = xm(63,:);
        elseif localbest(64) == IndivBest(64)
            localindex(64) = xm(64,:);
        else
            localindex(64) = xm(56,:);
        end 
    elseif j == 2 || j == 3 || j == 4 || j == 5 || j == 6 || j == 7
        IndivTemp5 = [IndivBest(j-1),IndivBest(j),IndivBest(j+1),IndivBest(j+sqrt(n))];
        localbest(j) = max(IndivTemp5);
        if localbest(j) == IndivBest(j-1)
            localindex(j) = xm(j-1,:);
        elseif localbest(j) == IndivBest(j)
            localindex(j) = xm(j,:);
        elseif localbest(j) == IndivBest(j+1)
            localindex(j) = xm(j+1,:);
        else
            localindex(j) = xm(j+sqrt(n),:);
        end
    elseif j == 9 || j == 17 || j == 25 || j == 33 || j == 41 || j == 49
        IndivTemp6 = [IndivBest(j-sqrt(n)),IndivBest(j),IndivBest(j+sqrt(n)),IndivBest(j+1)];
        localbest(j) = max(IndivTemp6);
        if localbest(j) == IndivBest(j-sqrt(n))
            localindex(j) = xm(j-sqrt(n),:);
        elseif localbest(j) == IndivBest(j)
            localindex(j) = xm(j,:);
        elseif localbest(j) == IndivBest(j+sqrt(n))
            localindex(j) = xm(j+sqrt(n),:);
        else
            localindex(j) = xm(j+1,:);
        end
    elseif j == 16 || j == 24 || j == 32 || j == 40 || j == 48 || j == 56
        IndivTemp7 = [IndivBest(j-sqrt(n)),IndivBest(j),IndivBest(j+sqrt(n)),IndivBest(j-1)];
        localbest(j) = max(IndivTemp7);
        if localbest(j) == IndivBest(j-sqrt(n))
            localindex(j) = xm(j-sqrt(n),:);
        elseif localbest(j) == IndivBest(j)
            localindex(j) = xm(j,:);
        elseif localbest(j) == IndivBest(j+sqrt(n))
            localindex(j) = xm(j+sqrt(n),:);
        else
            localindex(j) = xm(j-1,:);
        end
    elseif j == 58 || j == 59 || j == 60 || j == 61 || j == 62 || j == 63
        IndivTemp8 = [IndivBest(j-1),IndivBest(j),IndivBest(j+1),IndivBest(j-sqrt(n))];
        localbest(j) = max(IndivTemp8);
        if localbest(j) == IndivBest(j-1)
            localindex(j) = xm(j-1,:);
        elseif localbest(j) == IndivBest(j)
            localindex(j) = xm(j,:);
        elseif localbest(j) == IndivBest(j+1)
            localindex(j) = xm(j+1,:);
        else
            localindex(j) = xm(j-sqrt(n),:);
        end
    else
        IndivTemp9 = [IndivBest(j-1),IndivBest(j),IndivBest(j+1),IndivBest(j-sqrt(n)),IndivBest(j+sqrt(n))];
        localbest(j) = max(IndivTemp9);
        if localbest(j) == IndivBest(j-1)
            localindex(j) = xm(j-1,:);
        elseif localbest(j) == IndivBest(j)
            localindex(j) = xm(j,:);
        elseif localbest(j) == IndivBest(j+1)
            localindex(j) = xm(j+1,:);
        elseif localbest(j) == IndivBest(j-sqrt(n))
            localindex(j) = xm(j-sqrt(n),:);
        else
            localindex(j) = xm(j+sqrt(n),:);
        end
    end
end
end

