plot(ScopeTheta.time, ScopeTheta.signals.values)
title('Angle of cube as function of time')
xlabel('Time [s]')
ylabel('Angle [radians]')

figure;

plot(ScopeVoltage.time, ScopeVoltage.signals.values)
title('Voltage across motor as function of time')
xlabel('Time [s]')
ylabel('Voltage [V]')