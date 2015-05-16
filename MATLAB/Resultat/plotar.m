%open datots
close all
% Hörn utsida
subplot(2,3,1)
plot(sparvektor1(1,:),sparvektor1(2,:))
subplot(2,3,2)
plot(sparvektor2(1,:), sparvektor2(2,:))
subplot(2,3,3)
plot(sparvektor3(1,:),sparvektor3(2,:))
subplot(2,3,4)
plot(sparvektor4(1,:),sparvektor4(2,:))
subplot(2,3,5)
plot(sparvektor5(1,:),sparvektor5(2,:))
subplot(2,3,6)
plot(sparvektor6(1,:),sparvektor6(2,:))

v1 = std(sparvektor1(2,:));
v2 = std(sparvektor2(2,:));
v3 = std(sparvektor3(2,:));
v4 = std(sparvektor4(2,:));
v5 = std(sparvektor5(2,:));
v6 = std(sparvektor6(2,:));

e1 = mean(sparvektor1(2,:));
e2 = mean(sparvektor2(2,:));
e3 = mean(sparvektor3(2,:));
e4 = mean(sparvektor4(2,:));
e5 = mean(sparvektor5(2,:));
e6 = mean(sparvektor6(2,:));

medel1 = mean([v1 v2 v3 v4 v5 v6])
vante1 = mean([e1 e2 e3 e4 e5 e6])
%%
%Hörn insida
figure
subplot(2,3,1)
plot(asparvektor1(1,:),asparvektor1(2,:))
subplot(2,3,2)
plot(asparvektor2(1,:), asparvektor2(2,:))
subplot(2,3,3)
plot(asparvektor3(1,:),asparvektor3(2,:))
subplot(2,3,4)
plot(asparvektor4(1,:),asparvektor4(2,:))
subplot(2,3,5)
plot(asparvektor5(1,:),asparvektor5(2,:))
subplot(2,3,6)
plot(asparvektor6(1,:),asparvektor6(2,:))

v1 = std(asparvektor1(2,:));
v2 = std(asparvektor2(2,:));
v3 = std(asparvektor3(2,:));
v4 = std(asparvektor4(2,:));
v5 = std(asparvektor5(2,:));
v6 = std(asparvektor6(2,:));

e1 = mean(asparvektor1(2,:));
e2 = mean(asparvektor2(2,:));
e3 = mean(asparvektor3(2,:));
e4 = mean(asparvektor4(2,:));
e5 = mean(asparvektor5(2,:));
e6 = mean(sparvektor6(2,:));

medel2 = mean([v1 v2 v3 v4 v5 v6])
vante2 = mean([e1 e2 e3 e4 e5 e6])
%%
%mitten insida
figure
subplot(2,3,1)
plot(bsparvektor1(1,:),bsparvektor1(2,:))
subplot(2,3,2)
plot(bsparvektor2(1,:), bsparvektor2(2,:))
subplot(2,3,3)
plot(bsparvektor3(1,:),bsparvektor3(2,:))
subplot(2,3,4)
plot(bsparvektor4(1,:),bsparvektor4(2,:))
subplot(2,3,5)
plot(bsparvektor5(1,:),bsparvektor5(2,:))
subplot(2,3,6)
plot(bsparvektor6(1,:),bsparvektor6(2,:))

v1 = std(bsparvektor1(2,:));
v2 = std(bsparvektor2(2,:));
v3 = std(bsparvektor3(2,:));
v4 = std(bsparvektor4(2,:));
v5 = std(bsparvektor5(2,:));
v6 = std(bsparvektor6(2,:));

e1 = mean(bsparvektor1(2,:));
e2 = mean(bsparvektor2(2,:));
e3 = mean(bsparvektor3(2,:));
e4 = mean(bsparvektor4(2,:));
e5 = mean(bsparvektor5(2,:));
e6 = mean(bsparvektor6(2,:));

medel3 = mean([v1 v2 v3 v4 v5 v6])
vante3 = mean([e1 e2 e3 e4 e5 e6])
%%
%nära motor insida
figure
subplot(2,3,1)
plot(csparvektor1(1,:),csparvektor1(2,:))
subplot(2,3,2)
plot(csparvektor2(1,:), csparvektor2(2,:))
subplot(2,3,3)
plot(csparvektor3(1,:),csparvektor3(2,:))
subplot(2,3,4)
plot(csparvektor4(1,:),csparvektor4(2,:))
subplot(2,3,5)
plot(csparvektor5(1,:),csparvektor5(2,:))
subplot(2,3,6)
plot(csparvektor6(1,:),csparvektor6(2,:))

v1 = std(csparvektor1(2,:));
v2 = std(csparvektor2(2,:));
v3 = std(csparvektor3(2,:));
v4 = std(csparvektor4(2,:));
v5 = std(csparvektor5(2,:));
v6 = std(csparvektor6(2,:));

e1 = mean(csparvektor1(2,:));
e2 = mean(csparvektor2(2,:));
e3 = mean(csparvektor3(2,:));
e4 = mean(csparvektor4(2,:));
e5 = mean(csparvektor5(2,:));
e6 = mean(csparvektor6(2,:));

medel4 = mean([v1 v2 v3 v4 v5 v6])
vante4 = mean([e1 e2 e3 e4 e5 e6])
%%
%utan ström nära motor insida
figure
subplot(2,3,1)
plot(dsparvektor1(1,:),dsparvektor1(2,:))
subplot(2,3,2)
plot(dsparvektor2(1,:), dsparvektor2(2,:))
subplot(2,3,3)
plot(dsparvektor3(1,:),dsparvektor3(2,:))
subplot(2,3,4)
plot(dsparvektor4(1,:),dsparvektor4(2,:))
subplot(2,3,5)
plot(dsparvektor5(1,:),dsparvektor5(2,:))
subplot(2,3,6)
plot(dsparvektor6(1,:),dsparvektor6(2,:))

v1 = std(dsparvektor1(2,:));
v2 = std(dsparvektor2(2,:));
v3 = std(dsparvektor3(2,:));
v4 = std(dsparvektor4(2,:));
v5 = std(dsparvektor5(2,:));
v6 = std(dsparvektor6(2,:));

e1 = mean(dsparvektor1(2,:));
e2 = mean(dsparvektor2(2,:));
e3 = mean(dsparvektor3(2,:));
e4 = mean(dsparvektor4(2,:));
e5 = mean(dsparvektor5(2,:));
e6 = mean(dsparvektor6(2,:));

medel5 = mean([v1 v2 v3 v4 v5 v6])
vante5 = mean([e1 e2 e3 e4 e5 e6])

%%
% mitten mitten insida
figure
subplot(2,3,1)
plot(esparvektor1(1,:),esparvektor1(2,:))
subplot(2,3,2)
plot(esparvektor2(1,:),esparvektor2(2,:))
subplot(2,3,3)
plot(esparvektor3(1,:),esparvektor3(2,:))
subplot(2,3,4)
plot(esparvektor4(1,:),esparvektor4(2,:))
subplot(2,3,5)
plot(esparvektor5(1,:),esparvektor5(2,:))
subplot(2,3,6)
plot(esparvektor6(1,:),esparvektor6(2,:))

v1 = std(esparvektor1(2,:));
v2 = std(esparvektor2(2,:));
v3 = std(esparvektor3(2,:));
v4 = std(esparvektor4(2,:));
v5 = std(esparvektor5(2,:));
v6 = std(esparvektor6(2,:));

e1 = mean(esparvektor1(2,:));
e2 = mean(esparvektor2(2,:));
e3 = mean(esparvektor3(2,:));
e4 = mean(esparvektor4(2,:));
e5 = mean(esparvektor5(2,:));
e6 = mean(esparvektor6(2,:));

medel6 = mean([v1 v2 v3 v4 v5 v6])
vante6 = mean([e1 e2 e3 e4 e5 e6])

%% Plottar occh vektorer till resultat
close all
figure
plot(dsparvektor4(1,:),dsparvektor4(2,:))
xlabel('Time, [s]')
ylabel('Angle, [Degrees]')
title('Angle at position E (motor disabled)')
figure
plot(esparvektor1(1,:),esparvektor1(2,:))
xlabel('Time, [s]')
ylabel('Angle, [Degrees]')
title('Angle at position D')

vante_varde = [vante5; vante1; vante2; vante3; vante6; vante4]
standard_deviation = [medel5; medel1; medel2; medel3; medel6; medel4]