%%%Allan
function [tau, AVAR] = Allanvar(time, data)

if nargin < 2,
    disp ('Usage: allanVAR(time, data)')
else
    numtaus = floor(length(time)/9);
    for b = 1:numtaus
        tau(b) = time(b+1)-time(1);
    end
    
    %For each tau, calculate the average variance
    for h = 1:numtaus
        binvar = 0;
        avebin = 0;
        totalbins = floor(time(length(time)) / tau(h));
        lengthbins = floor(length(time) / totalbins);
        for j = 1:totalbins
            avebin(j) = mean(data((lengthbins * (j-1)) + 1:lengthbins*(j)));
        end
        for j = 1:(totalbins-1)
            binvar(j) = (avebin(j+1) - avebin(j))^2;
        end
        AVAR(h) = sqrt(sum(binvar) / (2*(totalbins-1)));
        AD(h) = sqrt(AVAR(h));
    end
    loglog(tau, AVAR)
    figure
    %AD = sqrt(AVAR);
    loglog(tau, AD)
end
end