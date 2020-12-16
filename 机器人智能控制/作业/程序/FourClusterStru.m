function [localbest,localindex] = FourClusterStru(IndivBest,xm)
%NEUMANNSTRU 此处显示有关此函数的摘要
%   此处显示详细说明
[n,~] = size(IndivBest);
localbest = zeros(n,1);
localindex = zeros(n,1);
FirstCluster = zeros(n/4,1);
SecondCluster = zeros(n/4,1);
ThirdCluster = zeros(n/4,1);
FourthCluster = zeros(n/4,1);
%%%%四簇结构
for j = 1:n/4
    FirstCluster(j,1) = IndivBest(j);
end
for j = 1:n/4
    if j == 1
        IndivTemp11 = [FirstCluster;IndivBest(64)];
        localbest(1) = max(IndivTemp11);
        if localbest(1) == IndivBest(64)
             localindex(1) = xm(64,:);
        else
            for m = 1:16
                if localbest(1) == IndivBest(m)
                    localindex(1) = xm(m,:); 
                end
            end   
        end
    elseif j == 8
        IndivTemp12 = [FirstCluster;IndivBest(40)];
        localbest(8) = max(IndivTemp12);
        if localbest(8) == IndivBest(40)
             localindex(8) = xm(40,:);
        else
            for m = 1:16
                if localbest(8) == IndivBest(m)
                    localindex(8) = xm(m,:); 
                end
            end   
        end  
    elseif j == 16 %% 16
        IndivTemp13 = [FirstCluster;IndivBest(17)];
        localbest(16) = max(IndivTemp13);
        if localbest(16) == IndivBest(17)
             localindex(16) = xm(17,:);
        else
            for m = 1:16
                if localbest(16) == IndivBest(m)
                    localindex(16) = xm(m,:); 
                end
            end   
        end  
    else
        IndivTemp14 = FirstCluster;
        localbest(j) = max(IndivTemp14);
        for m = 1:16
            if localbest(j) == IndivBest(m)
                localindex(j) = xm(m,:);
            end
        end
    end
end
%%%%%%%5
for j = n/4+1:n/2
    SecondCluster(j,1) = IndivBest(j);
end
for j = n/4+1:n/2
    if j == 17
        IndivTemp21 = [SecondCluster;IndivBest(16)];
        localbest(17) = max(IndivTemp21);
        if localbest(17) == IndivBest(16)
             localindex(17) = xm(16,:);
        else
            for m = 17:32
                if localbest(17) == IndivBest(m)
                    localindex(17) = xm(m,:); 
                end
            end   
        end
    elseif j == 24
        IndivTemp22 = [SecondCluster;IndivBest(56)];
        localbest(24) = max(IndivTemp22);
        if localbest(24) == IndivBest(56)
             localindex(24) = xm(56,:);
        else
            for m = 17:32
                if localbest(24) == IndivBest(m)
                    localindex(24) = xm(m,:); 
                end
            end   
        end  
    elseif j == 32 %% 16
        IndivTemp23 = [SecondCluster;IndivBest(33)];
        localbest(32) = max(IndivTemp23);
        if localbest(32) == IndivBest(33)
             localindex(32) = xm(33,:);
        else
            for m = 17:32
                if localbest(32) == IndivBest(m)
                    localindex(32) = xm(m,:); 
                end
            end   
        end  
    else
        IndivTemp24 = SecondCluster;
        localbest(j) = max(IndivTemp24);
        for m = 17:32
            if localbest(j) == IndivBest(m)
                localindex(j) = xm(m,:);
            end
        end
    end  
end
%%%%%%%%
for j = n/2+1:(3*n)/4 
    ThirdCluster(j,1) = IndivBest(j);
end
for j = n/2+1:(3*n)/4  
    if j == 33
        IndivTemp31 = [ThirdCluster;IndivBest(32)];
        localbest(33) = max(IndivTemp31);
        if localbest(33) == IndivBest(32)
             localindex(33) = xm(32,:);
        else
            for m = 1:16
                if localbest(33) == IndivBest(m)
                    localindex(33) = xm(m,:); 
                end
            end   
        end
    elseif j == 40
        IndivTemp32 = [ThirdCluster;IndivBest(8)];
        localbest(40) = max(IndivTemp32);
        if localbest(40) == IndivBest(8)
             localindex(40) = xm(8,:);
        else
            for m = 33:48
                if localbest(40) == IndivBest(m)
                    localindex(40) = xm(m,:); 
                end
            end   
        end  
    elseif j == 48   %% 48 
        IndivTemp33 = [ThirdCluster;IndivBest(49)];
        localbest(48) = max(IndivTemp33);
        if localbest(48) == IndivBest(49)
             localindex(48) = xm(49,:);
        else
            for m = 33:48
                if localbest(48) == IndivBest(m)
                    localindex(48) = xm(m,:); 
                end
            end   
        end  
    else
        IndivTemp34 = ThirdCluster;
        localbest(j) = max(IndivTemp34);
        for m = 33:48
            if localbest(j) == IndivBest(m)
                localindex(j) = xm(m,:);
            end
        end
    end
end
%%%%%%%%
for j = (3*n)/4+1:n
    FourthCluster(j,1) = IndivBest(j);
end
for j = (3*n)/4+1:n
    if j == 49
        IndivTemp41 = [FourthCluster;IndivBest(48)];
        localbest(49) = max(IndivTemp41);
        if localbest(49) == IndivBest(48)
             localindex(49) = xm(48,:);
        else
            for m = 49:64
                if localbest(49) == IndivBest(m)
                    localindex(49) = xm(m,:); 
                end
            end   
        end
    elseif j == 56
        IndivTemp42 = [FourthCluster;IndivBest(24)];
        localbest(56) = max(IndivTemp42);
        if localbest(56) == IndivBest(24)
             localindex(56) = xm(24,:);
        else
            for m = 49:64
                if localbest(56) == IndivBest(m)
                    localindex(56) = xm(m,:); 
                end
            end   
        end  
    elseif j == 64 %% 64
        IndivTemp43 = [FourthCluster;IndivBest(1)];
        localbest(64) = max(IndivTemp43);
        if localbest(64) == IndivBest(1)
             localindex(64) = xm(1,:);
        else
            for m = 49:64
                if localbest(64) == IndivBest(m)
                    localindex(64) = xm(m,:); 
                end
            end   
        end  
    else
        IndivTemp44 = FourthCluster;
        localbest(j) = max(IndivTemp44);
        for m = 49:64
            if localbest(j) == IndivBest(m)
                localindex(j) = xm(m,:);
            end
        end
    end
end
end

