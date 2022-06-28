neuron1 = load('currents_big.mat');
neuron1.XYZ(:,3) = 10;
voltages1 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron1.XYZ(k,1))^2 + (neuron1.XYZ(k,2))^2 + (neuron1.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron1.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages1(index) = tempVoltage;
end
%total1 = 1:40000;
total1 = zeros(40000,1);
for i = 1:2
    ind = floor((40000/3)*i);
    total1(ind + 1: ind + 758) = voltages1;
end

neuron2 = load('currents_big.mat');
neuron2.XYZ(:,3) = 10;
neuron2.XYZ(:,2) = 10;
voltages2 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron2.XYZ(k,1))^2 + (neuron2.XYZ(k,2))^2 + (neuron2.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron2.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages2(index) = tempVoltage;
end
total2 = zeros(40000,1);
for i = 1:6
    ind = floor((40000/7)*i);
    total2(ind + 1: ind + 758) = voltages2;
end

neuron3 = load('currents_big.mat');
neuron3.XYZ(:,3) = 10;
neuron3.XYZ(:,2) = -10;
voltages3 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron3.XYZ(k,1))^2 + (neuron3.XYZ(k,2))^2 + (neuron3.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron3.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages3(index) = tempVoltage;
end
total3 = zeros(40000,1);
for i = 1:8
    ind = floor((40000/9)*i);
    total3(ind + 1: ind + 758) = voltages3;
end

neuron4 = load('currents_big.mat');
neuron4.XYZ(:,3) = -78;
neuron4.XYZ(:,2) = 57;
voltages4 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron4.XYZ(k,1))^2 + (neuron4.XYZ(k,2))^2 + (neuron4.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron4.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages4(index) = tempVoltage;
end
total4 = zeros(40000,1);
for i = 1:11
    ind = floor((40000/12)*i);
    total4(ind + 1: ind + 758) = voltages4;
end


neuron5 = load('currents_big.mat');
neuron5.XYZ(:,3) = 88;
neuron5.XYZ(:,2) = -26;
voltages5 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron5.XYZ(k,1))^2 + (neuron5.XYZ(k,2))^2 + (neuron5.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron5.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages5(index) = tempVoltage;
end
total5 = zeros(40000,1);
for i = 1:18
    ind = floor((40000/19)*i);
    total5(ind + 1: ind + 758) = voltages5;
end


neuron6 = load('currents_big.mat');
neuron6.XYZ(:,3) = -15;
neuron6.XYZ(:,2) = 7;
voltages6 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron6.XYZ(k,1))^2 + (neuron6.XYZ(k,2))^2 + (neuron6.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron6.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages6(index) = tempVoltage;
end
total6 = zeros(40000,1);
for i = 1:21
    ind = floor((40000/22)*i);
    total6(ind + 1: ind + 758) = voltages6;
end


neuron7 = load('currents_big.mat');
neuron7.XYZ(:,3) = 25;
neuron7.XYZ(:,2) = -25;
voltages7 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron7.XYZ(k,1))^2 + (neuron7.XYZ(k,2))^2 + (neuron7.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron7.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages7(index) = tempVoltage;
end
total7 = zeros(40000,1);
for i = 1:27
    ind = floor((40000/28)*i);
    total7(ind + 1: ind + 758) = voltages7;
end

neuron8 = load('currents_big.mat');
neuron8.XYZ(:,3) = -33;
neuron8.XYZ(:,2) = -54;
voltages8 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron8.XYZ(k,1))^2 + (neuron8.XYZ(k,2))^2 + (neuron8.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron8.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages8(index) = tempVoltage;
end
total8 = zeros(40000,1);
for i = 1:33
    ind = floor((40000/34)*i);
    total8(ind + 1: ind + 758) = voltages8;
end

neuron9 = load('currents_big.mat');
neuron9.XYZ(:,3) = -63;
neuron9.XYZ(:,2) = 82;
voltages9 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron9.XYZ(k,1))^2 + (neuron9.XYZ(k,2))^2 + (neuron9.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron9.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages9(index) = tempVoltage;
end
total9 = zeros(40000,1);
for i = 1:43
    ind = floor((40000/44)*i);
    total9(ind + 1: ind + 758) = voltages9;
end

neuron10 = load('currents_big.mat');
neuron10.XYZ(:,3) = 44;
neuron10.XYZ(:,2) = -32;
voltages10 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron10.XYZ(k,1))^2 + (neuron10.XYZ(k,2))^2 + (neuron10.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron10.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages10(index) = tempVoltage;
end
total10 = zeros(40000,1);
for i = 1:48
    ind = floor((40000/49)*i);
    total10(ind + 1: ind + 758) = voltages10;
end

time = 1:40000;
total = total1 + total2 + total3 + total4 + total5 + total6 + total7 + total8 + total9 + total10;
%plot(time, total)
%title("Recording with 10 neurons")
cn = dsp.ColoredNoise('Color','pink','SamplesPerFrame',40000);
recordedNoise = cn();
subplot(2,1,1)
plot(time, total * 10^6,'b')
hold on
plot(time, recordedNoise,'b')
title("Multiple Neuron Voltage Trace Without Dead Zone")
xlabel("Time (ms)")
ylabel("Voltage (uV)")

%% Same With Dead Zone

neuron4 = load('currents_big.mat');
neuron4.XYZ(:,3) = -78;
neuron4.XYZ(:,2) = 57;
voltages4 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron4.XYZ(k,1))^2 + (neuron4.XYZ(k,2))^2 + (neuron4.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron4.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages4(index) = tempVoltage;
end
total4 = zeros(40000,1);
for i = 1:11
    ind = floor((40000/12)*i);
    total4(ind + 1: ind + 758) = voltages4;
end


neuron5 = load('currents_big.mat');
neuron5.XYZ(:,3) = 88;
neuron5.XYZ(:,2) = -26;
voltages5 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron5.XYZ(k,1))^2 + (neuron5.XYZ(k,2))^2 + (neuron5.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron5.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages5(index) = tempVoltage;
end
total5 = zeros(40000,1);
for i = 1:18
    ind = floor((40000/19)*i);
    total5(ind + 1: ind + 758) = voltages5;
end



neuron7 = load('currents_big.mat');
neuron7.XYZ(:,3) = 25;
neuron7.XYZ(:,2) = -25;
voltages7 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron7.XYZ(k,1))^2 + (neuron7.XYZ(k,2))^2 + (neuron7.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron7.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages7(index) = tempVoltage;
end
total7 = zeros(40000,1);
for i = 1:27
    ind = floor((40000/28)*i);
    total7(ind + 1: ind + 758) = voltages7;
end

neuron8 = load('currents_big.mat');
neuron8.XYZ(:,3) = -33;
neuron8.XYZ(:,2) = -54;
voltages8 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron8.XYZ(k,1))^2 + (neuron8.XYZ(k,2))^2 + (neuron8.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron8.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages8(index) = tempVoltage;
end
total8 = zeros(40000,1);
for i = 1:33
    ind = floor((40000/34)*i);
    total8(ind + 1: ind + 758) = voltages8;
end

neuron9 = load('currents_big.mat');
neuron9.XYZ(:,3) = -63;
neuron9.XYZ(:,2) = 82;
voltages9 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron9.XYZ(k,1))^2 + (neuron9.XYZ(k,2))^2 + (neuron9.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron9.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages9(index) = tempVoltage;
end
total9 = zeros(40000,1);
for i = 1:43
    ind = floor((40000/44)*i);
    total9(ind + 1: ind + 758) = voltages9;
end

neuron10 = load('currents_big.mat');
neuron10.XYZ(:,3) = 44;
neuron10.XYZ(:,2) = -32;
voltages10 = 1:758;
for index = 1:758
    tempVoltage = 0;
    for k = 1:531
        distance = sqrt((neuron10.XYZ(k,1))^2 + (neuron10.XYZ(k,2))^2 + (neuron10.XYZ(k,3))^2);
        tempVoltage = tempVoltage + (neuron10.currents(k,index))/(4*pi*0.3333*10^-6* distance);
    end
    voltages10(index) = tempVoltage;
end
total10 = zeros(40000,1);
for i = 1:48
    ind = floor((40000/49)*i);
    total10(ind + 1: ind + 758) = voltages10;
end

time = 1:40000;
total = total4 + total5 + total7 + total8 + total9 + total10;
%plot(time, total)
%title("Recording with 10 neurons")
cn = dsp.ColoredNoise('Color','pink','SamplesPerFrame',40000);
recordedNoise = cn();
subplot(2,1,2)

plot(time, total * 10^6,'b')
hold on
plot(time, recordedNoise,'b')
title("Multiple Neuron Voltage Trace With Dead Zone")
xlabel("Time (ms)")
ylabel("Voltage (uV)")