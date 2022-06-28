data = load('spikes.mat');
meanData = mean(data.spikes, 1);
standardD = std(data.spikes);
normalize = (data.spikes - meanData)./ standardD;

[coeff, score, latent, tsquared, explained, mu] = pca(normalize);
%idx = find(cumsum(explained)> .90, 1);
result = cumsum(latent)./sum(latent);
k_90 = find(result == min(result(result > .90)));
%cumsum(latent)
%sum(latent)
%result
result == min(result(result > .90));

%{
figure(1)
plot(score(5,1)*coeff(:,1))
title("First Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(2)
plot(score(5,2)*coeff(:,2))
title("Second Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(3)
plot(score(5,3)*coeff(:,3))
title("Third Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(4)
plot(score(5,4)*coeff(:,4))
title("Fourth Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(5)
plot(score(5,5)*coeff(:,5))
title("Fifth Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(6)
plot(score(5,6)*coeff(:,6))
title("Sixth Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(7)
plot(score(5,7)*coeff(:,7))
title("Seventh Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(8)
plot(score(5,8)*coeff(:,8))
title("Eigth Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")

figure(9)
plot(score(5,9)*coeff(:,9))
title("Ninth Principal Component of Data")
xlabel("Sample")
ylabel("Normalized Data Point")


figure(10)
plot(normalize(5,:))
title("Original Normalized Spike 5")
xlabel("Sample")
ylabel("Normalized Data Point")
hold on

figure(11)
plot(data.spikes(5,:))
title("Original  Spike 5")
xlabel("Sample")
ylabel("Voltage")
hold on
%}

sp1_rec = score(5,:)*coeff(:,:)';
%plot(sp1_rec);
hold off
%figure(11)
unnormal = sp1_rec .*standardD + meanData;
plot(data.spikes(5,:))
hold on
plot(unnormal)
title("Original spike 5 and recreted spike with all principal components")
xlabel("Sample")
ylabel("Voltage (mV)")
legend("Original Spike", "Recreated Spike")
hold off 

figure(12)
plot(score(:,1),score(:,2),'o')
title("Principal Component 1 vs Principal Component 2")
xlabel("PC1")
ylabel("PC2")
