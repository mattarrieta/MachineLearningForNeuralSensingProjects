ecogData = load('ecogdatasnippet.mat');

index = find(ecogData.refChannels == 1);
carSignal = mean(ecogData.ecogData(index,:));
channel29Mean = zeros(1,8003);
for i = 1:8003
    channel29Mean(i) = ecogData.ecogData(29,i) - mean(carSignal);
end

low = bandpass(channel29Mean, [2 6], 1000);
middle = bandpass(channel29Mean, [14 46], 1000);
high = bandpass(channel29Mean, [54 114], 1000);

figure(1)
plot(channel29Mean)
hold on
plot(low)
legend("Channel 29 CAR ","Channel 29 CAR low filter")
title("Channel 29 CAR orginal and with low filter")
xlabel("Sample")
ylabel("Volage (mV)")
hold off

figure(2)
plot(channel29Mean)
hold on
plot(middle)
legend("Channel 29 CAR ","Channel 29 CAR middle filter")
title("Channel 29 CAR orginal and with middle filter")
xlabel("Sample")
ylabel("Volage (mV)")
hold off

figure(3)
plot(channel29Mean)
hold on
plot(high)
legend("Channel 29 CAR ","Channel 29 CAR high filter")
title("Channel 29 CAR orginal and with high filter")
xlabel("Sample")
ylabel("Volage (mV)")
hold off

lowPower = zeros(1,8003);
middlePower = zeros(1,8003);
highPower = zeros(1,8003);

for i=1:8003
    lowPower(i) = low(i).^2;
    middlePower(i) = middle(i).^2;
    highPower(i) = high(i).^2;
end

figure(4)
plot(smooth(lowPower, 100))
hold on
plot(smooth(middlePower, 100))
plot(smooth(highPower,100))
title("Powers of ")
xlabel("Sample")
ylabel("Volt^2 (mV^2)")
legend("Low Frequency Power", "Middle Frequency Power", "High Frequency Power")


