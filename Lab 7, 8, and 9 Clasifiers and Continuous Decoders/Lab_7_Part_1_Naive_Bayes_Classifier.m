data = load("firingrate.mat");
load("firingrate.mat")
training = data.firingrate(:,1:91,:);
testing = data.firingrate(:,92:182,:);
%% Testing Training Data

meanFeatureClass = mean(training,2);
predicted = zeros(91,8,1);
for trial =1:91
    for target = 1:8
        feature = training(:,trial,target);
        probabilities = zeros(1,8);
        for targetGuess = 1:8
            totalProbability = 0;
            for neuron = 1:95
                totalProbability = totalProbability + log(poisspdf(feature(neuron),meanFeatureClass(neuron,1,targetGuess)));
            end
            probabilities(targetGuess) = totalProbability;
        end
        [val, index] = max(probabilities);
        predicted(trial,target) = index;
    end
end

totalNum = 0;
numCorrect = 0;
for trial = 1:91
    for target = 1:8
        totalNum = totalNum + 1;
        if(predicted(trial, target) == target)
            numCorrect = numCorrect + 1;
        end
    end
end
resultTraining = numCorrect/totalNum;

%% Testing Test Data

meanFeatureClassTrain = mean(training,2);
predictedTest = zeros(91,8,1);
for trial =1:91
    for target = 1:8
        feature = testing(:,trial,target);
        probabilities = zeros(1,8);
        for targetGuess = 1:8
            totalProbability = 0;
            for neuron = 1:95
                totalProbability = totalProbability + log(poisspdf(feature(neuron),meanFeatureClassTrain(neuron,1,targetGuess)));
            end
            probabilities(targetGuess) = totalProbability;
        end
        [val, index] = max(probabilities);
        predictedTest(trial,target) = index;
    end
end

totalNum = 0;
numCorrect = 0;
for trial = 92:182
    for target = 1:8
        totalNum = totalNum + 1;
        if(predictedTest(trial-91, target) == target)
            numCorrect = numCorrect + 1;
        end
    end
end
resultTest = numCorrect/totalNum

%% Testing Spoof Data


overallMean = mean(data.firingrate,2);
meanMean = mean(overallMean,3);
spoof = zeros(95,182,8);
for i = 1:95
    for j = 1:182
        for k = 1:8
            spoof(i,j,k) = poissrnd(meanMean(i));
        end
    end
end

meanFeatureClassTrain = mean(training,2);
predictedSpoof = zeros(182,8,1);
for trial =1:182
    for target = 1:8
        feature = spoof(:,trial,target);
        probabilities = zeros(1,8);
        for targetGuess = 1:8
            totalProbability = 0;
            for neuron = 1:95
                totalProbability = totalProbability + log(poisspdf(feature(neuron),meanFeatureClassTrain(neuron,1,targetGuess)));
            end
            probabilities(targetGuess) = totalProbability;
        end
        [val, index] = max(probabilities);
        predictedSpoof(trial,target) = index;
    end
end

totalNum = 0;
numCorrect = 0;
for trial = 1:182
    for target = 1:8
        totalNum = totalNum + 1;
        if(predictedSpoof(trial, target) == target)
            numCorrect = numCorrect + 1;
        end
    end
end
resultSpoof = numCorrect/totalNum;


