load("ecogclassifydata.mat")
trainingData = powervals(1:38,:);
testData = powervals(39,:);
testClass = classify(testData, trainingData, group(1:38), 'linear');
predicted = zeros(39,1);
numCorrect = 0;
for i=1:39
    trainingData = vertcat(powervals(1:-1+i,:), powervals(i+1:39,:));
    testData = powervals(i,:);
    trainingClasses = vertcat(group(1:-1+i,:), group(i+1:39,:));
    testClass = classify(testData, trainingData, trainingClasses, 'linear');
    if(testClass == group(i))
        numCorrect = numCorrect + 1;
    end
    predicted(i) = testClass;
end
accuracy = numCorrect/39
confusion = confusionmat(group, predicted)
sum = 0;
total = 0;
for i = 1:5
    for j = 1:5
        if i == j
            sum = sum + confusion(i,j);
        end
        total = total + confusion(i,j);
        confusion(i,j) = confusion(i,j)/7 * 100;
    end
end
sum/total
%size(confusion)
%figure
%pcolor(confusion)
%colorbar

%figure
imagesc(confusion)
%title("")
c = colorbar;  
c.Ruler.TickLabelFormat='%g%%';
%heatmap(confusion)
%colormap default
title("Percentage that data was classified for group in LDA")
xlabel("Group")
ylabel("Group")
