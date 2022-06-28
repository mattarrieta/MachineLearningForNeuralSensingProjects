neuron = 0:.005:5;
Vext = zeros(1,1001);
for i=1:1001
    Vext(i) = -.001/(4*pi*0.3333*sqrt((1*10^-3)^2 + ((neuron(i)*10^-3) - (2.5*10^-3))^2));
end

figure(1)
plot(neuron, Vext);
title("External Voltage vs. Position of Neuron")
xlabel("Position of Neuron (mm)")
ylabel("Extracellula Voltage (V)")

Iint = zeros(1,999);
for i = 2:1000
    Iint(i) = (3*10^-5)*(Vext(i-1)- 2*Vext(i) + Vext(i+1));
end

figure(2)
plot(neuron(2:1001), Iint)
title("Intracellular Current vs. Position of Neuron")
xlabel("Position of Neuron (mm)")
ylabel("Intracellular Current (A)")
%Peak negative current is -1.78983 * 10^-11 A
% 1 mA -> -1.78983 * 10^-11 A
% Minimum current inside is 76 nA
% minimum 1mm away is 4.26 Amps
max(Iint)