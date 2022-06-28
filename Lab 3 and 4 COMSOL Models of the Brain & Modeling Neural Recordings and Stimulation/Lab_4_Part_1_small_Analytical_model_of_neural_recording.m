currents_small = load('currents_small.mat');

%% Currents Small Electrode 50 Away
positions50 = 1:531;

for index = 1:531
    positions50(index) = sqrt((currents_small.XYZ(index) - 50)^2 + 1^2);
end
voltages50 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        tempVoltage = tempVoltage + (currents_small.currents(k,index))/(4*pi*0.3333*10^-6* positions50(k));
    end
    voltages50(index) = tempVoltage;
end
time = 1:758;

plot(time, voltages50*10^6);


hold on
%% Currents Small Electrode 100 Away
positions100 = 1:531;

for index = 1:531
    positions100(index) = sqrt((currents_small.XYZ(index) - 100)^2 + 1^2);
end
voltages100 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        tempVoltage = tempVoltage + (currents_small.currents(k,index))/(4*pi*0.3333*10^-6* positions100(k));
    end
    voltages100(index) = tempVoltage;
end
time = 1:758;
plot(time, voltages100*10^6)
hold on
%% Currents Small Electrode 200 Away
positions200 = 1:531;

for index = 1:531
    positions200(index) = sqrt((currents_small.XYZ(index) - 200)^2 + 1^2);
end
voltages200 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        tempVoltage = tempVoltage + (currents_small.currents(k,index))/(4*pi*0.3333*10^-6* positions200(k));
    end
    voltages200(index) = tempVoltage;
end
time = 1:758;
plot(time, voltages200*10^6)
hold on
%% Currents Small Electrode 300 Away
positions300 = 1:531;

for index = 1:531
    positions300(index) = sqrt((currents_small.XYZ(index) - 300)^2 + 1^2);
end
voltages300 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        tempVoltage = tempVoltage + (currents_small.currents(k,index))/(4*pi*0.3333*10^-6* positions300(k));
    end
    voltages300(index) = tempVoltage;
end
time = 1:758;
plot(time, voltages300*10^6)
legend("50um", "100um", "200um", "300um")
title("Currents small Voltages Over Time")
xlabel("Time (ms)")
ylabel("Voltage (uV)")
