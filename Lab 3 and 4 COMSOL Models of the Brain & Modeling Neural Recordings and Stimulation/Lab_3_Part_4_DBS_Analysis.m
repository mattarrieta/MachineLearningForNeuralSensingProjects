voltages = load('Lab3Part3Voltages.txt');
size(voltages);
X = -1:.0001:1;
Y = zeros(1,20001);
Z = zeros(1,20001);
%size(X)
%size(Y)
%size(Z)
%interpolation = griddata(voltages(:,1),voltages(:,2), voltages(:,3), voltages(:,4), neuron.XYZ(:,1), neuron.XYZ(:,2), neuron.XYZ(:,3));
interpolation = griddata(voltages(:,1),voltages(:,2), voltages(:,3), voltages(:,4),X, Y, Z);
size(interpolation);
figure(1);
plot(X, interpolation);
title("Voltage vs Distance")
xlabel("Distance along line (m)")
ylabel("Voltage")

secondDerivative = diff(diff(interpolation));
%size(interpolation)
%size(X)
length(secondDerivative)
length(X)
figure(2)
plot(X(1:19999), secondDerivative);
title("Second Derivative of Voltage vs Distance")
xlabel("Distance along line (m)")
ylabel("Second Derivative of Voltage")


