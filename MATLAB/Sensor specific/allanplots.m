%%ALLAN thesis
AD = sqrt(AVAR);

ARW = AD(95)
bias = min(AD)
%Deg2counts
ARWd=ARW*8.75/1000
biasd = bias*8.75/1000
figure
loglog(tau, AD)
title('Gyroscope Allan variance')
xlabel('Hej')
ylabel('puh')