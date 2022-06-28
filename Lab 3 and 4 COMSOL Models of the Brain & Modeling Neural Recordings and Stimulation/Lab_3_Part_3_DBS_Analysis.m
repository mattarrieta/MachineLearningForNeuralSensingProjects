voltages = load('Lab3Part2Voltages.txt');
x = voltages(:,1);
y = voltages(:,2);
z = voltages(:,3);
distance = 1:3799;
for i = 1:3799
    distance(i) = sqrt(x(i)^2+y(i)^2+z(i)^2);
end
plot(distance,voltages(:,4), 'o')
title("Distance From Stimulus vs. Voltage")
xlabel("Distance From Stimulus (m)")
ylabel("Voltage (V)")
%Line through the middle contact. Calculate voltage at every part of that
%line. Find closest XYZ. 
