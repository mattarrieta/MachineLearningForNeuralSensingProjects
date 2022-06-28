data = load('spikes.mat');
meanData = mean(data.spikes, 1);
standardD = std(data.spikes);
normalize = (data.spikes - meanData)./ standardD;
[coeff,score] = pca(normalize);
first = score(:,1);
second = score(:,2);
options = statset('display','final');
obj = gmdistribution.fit(score(:,1:2),3,'options',options);
clusters = cluster(obj, score(:,1:2));

redElements = find(clusters == 1);
greenElements = find(clusters == 2);
blueElements = find(clusters == 3);
%cyanElements = find(clusters == 4);
%magentaElements = find(clusters == 5);

figure(2)
scatter(first(redElements), second(redElements), 'red')
hold on
scatter(first(blueElements), second(blueElements), 'blue')
scatter(first(greenElements), second(greenElements), 'green')
%scatter(first(cyanElements), second(cyanElements), 'cyan')
%scatter(first(magentaElements), second(magentaElements), 'magenta')

centroids = obj.mu;
size(centroids)
plot(centroids(:,1),centroids(:,2), 'x')

ezcontour(@(x,y)pdf(obj, [x y]), [-15 15], [-15 15])
title("Principal Component 1 vs Principal Component 2", "with Colored Clusters using GMM K = 3")
xlabel("PC1")
ylabel("PC2")