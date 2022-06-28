data = load('spikes.mat');
meanData = mean(data.spikes, 1);
standardD = std(data.spikes);
normalize = (data.spikes - meanData)./ standardD;

[coeff,score] = pca(normalize);

first = score(:,1);
second = score(:,2);
size(first);
%figure(1)
%plot(first, second,'o')

k = 3;
r1 = floor(1 + (41568-1)*rand());
r1x = first(r1)
r1y = second(r1)
r2 = floor(1 + (41568-1)*rand());
while r1 == 2
    r2 = floor(1 + (41568-1)*rand());
end
r2x = first(r2);
r2y = second(r2);
r3 = floor(1 + (41568-1)*rand());
while r3 == r1 || r3 == r2
    r3 = floor(1 + (41568-1)*rand());
end
r3x = first(r3);
r3y = second(r3);
distance = zeros(1, 41568);
cluster = zeros(1, 41568);

r1new = 0;
r1newx = 0;
r1newy = 0;
r2new = 0;
r2newx = 0;
r2newy = 0;
r3new = 0;
r3newx = 0;
r3newy = 0;

while (r1newx ~= r1x) && (r1newy ~= r1y) && (r2newx ~= r2x) && (r2newy ~= r2y) && (r3newx ~= r3x) && (r3newy ~= r3y)
   r1newx = r1x;
   r1newy = r1y;
   r2newx = r2x;
   r2newy = r2y;
   r3newx = r3x;
   r3newy = r3y;
   for i = 1:41568
    distance1 = (r1newx - first(i))^2 + (r1newy - second(i))^2;
    distance2 = (r2newx - first(i))^2 + (r2newy - second(i))^2;
    distance3 = (r3newx - first(i))^2 + (r3newy - second(i))^2;
    if(distance1 < distance2 && distance1 < distance3)
        cluster(i) = 1;
        distance(i) = distance1;
    end
    if(distance2 < distance1 && distance2 < distance3)
        cluster(i) = 2;
        distance(i) = distance2;
    end
    if(distance3 < distance1 && distance3 < distance2)
        cluster(i) = 3;
        distance(i) = distance3;
    end 
   end
   mean1x = 0;
   mean1y = 0;
   mean2x = 0;
   mean2y = 0;
   mean3x = 0;
   mean3y = 0;
   count1 = 0;
   count2 = 0;
   count3 = 0;
   for k = 1:41568
     if cluster(k) == 1
        mean1x = mean1x + first(k);
        mean1y = mean1y + second(k);
        count1 = count1 + 1;
     end
     if cluster(k) == 2
        mean2x = mean2x + first(k);
        mean2y = mean2y + second(k);
        count2 = count2 + 1;
     end
        mean3x = mean3x + first(k);
        mean3y = mean3y + second(k);
        count3 = count3 + 1;
   end
   %disp("r1 end of while loop")
   %mean1
   %count1
   r1x = mean1x/count1;
   r1y = mean1y/count1;
   r2x = mean2x/count2;
   r2y = mean2y/count2;
   r3x = mean3x/count3;
   r3y = mean3y/count3;
end
disp("Out of while loop")
%{
cluster(3)
figure(2)
scatter(first(1), second(1),"red")
hold on
scatter(first(3), second(3),"green")
%}

redElements = find(cluster == 1);
greenElements = find(cluster == 2);
blueElements = find(cluster == 3);
figure(1)
scatter(first(redElements), second(redElements), 'red')
hold on
scatter(first(blueElements), second(blueElements), 'blue')
scatter(first(greenElements), second(greenElements), 'green')
title("Principal Component 1 vs Principal Component 2", "with Colored Clusters Using K-means")
xlabel("PC1")
ylabel("PC2")
hold off

time = 1:32;
%figure(2)
%size(mean(data.spikes(redElements,:)))
%hold on
redMean = mean(data.spikes(redElements,:));
redStd = std(data.spikes(redElements,:));
blueMean = mean(data.spikes(blueElements,:));
blueStd = std(data.spikes(blueElements,:));
greenMean = mean(data.spikes(greenElements,:));
greenStd = std(data.spikes(greenElements,:));
disp("Green Stuff")
size(greenMean)
size(greenStd)
%plot(time, redMean, 'red')
%plot(time, blueMean, 'blue')
%plot(time, greenMean, 'green')
%legend('Red','Blue','Green');
%hold off

figure(3)
shadedErrorBar(time,redMean,redStd, 'lineProps', 'r');
hold on
shadedErrorBar(time,blueMean,blueStd,'lineProps', 'b');
shadedErrorBar(time,greenMean,greenStd,'lineProps', 'g');
xlabel("Samples")
ylabel("Average Spike Voltage (mV)")
title("Average Spike For Each Cluster With Standard Deviation")


%red1Mean = mean(data.spikes(redElements));
%redstd = std(data.spikes(redElements));
%size(red1Mean)
%x = red1Mean
%y = redstd;
%time = 1:32;
%plot(time, x)
%shadedErrorBar(x,y,'lineProps','g');




