voltages = load('Lab3Part2VoltagesAdaptive.txt');
neuron = load('currents_big.mat');
neuron.XYZ(:,2) = 50;
neuron.XYZ(:,1)
interpolation = griddata(voltages(:,1)*10^6,voltages(:,2)*10^6, voltages(:,3)*10^6, voltages(:,4), neuron.XYZ(:,1), neuron.XYZ(:,2), neuron.XYZ(:,3));
%Vext = neuron.currents * interpolation
Vext = zeros(758, 1);
for i = 1:758
    Vtemp = 0;
    for k = 1:531
        Vtemp = Vtemp + neuron.currents(k,i) * interpolation(k);
    end
    Vext(i) = Vtemp;
end
time = 1:758;
plot(time, Vext*10^6);
title("COMSOL Voltages vs Time")
xlabel("Time (ms)")
ylabel("Voltage (uV)")