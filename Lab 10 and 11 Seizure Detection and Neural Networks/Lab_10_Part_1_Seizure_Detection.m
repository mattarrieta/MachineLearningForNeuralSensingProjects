load("Patient_A-1.mat");
load("Patient_B-1.mat");
allAamplitude = zeros(1,180);
allBamplitude = zeros(1,180);
allCrossZerosAnum = zeros(1,180);
allCrossZerosBnum = zeros(1,180);
%allCrossZerosAloc = zeros(1,180,1000);
%allCrossZerosBloc = zeros(1,180,1000);
allLineLengthsA = zeros(1,180);
allLineLengthsB = zeros(1,180);
for k=1:180
    pAseizure = data(3, (k*30000 - 30000 + 1): k*30000);
    pBseizure = data(2, (k*30000 - 30000 + 1): k*30000);
    pAamplitude = max(pAseizure) - min(pAseizure);
    pBamplitude = max(pBseizure) - min(pBseizure);
    allAamplitude(1,k) = pAamplitude;
    allBamplitude(1,k) = pBamplitude;

    crossZerosAnum = 0;
    crossZerosAloc = zeros(1,271);
    crossZerosBnum = 0;
    crossZerosBloc = zeros(1,271);
    for i = 1:29999
        if((pAseizure(i) > 0 && pAseizure(i + 1) < 0) || (pAseizure(i) < 0 && pAseizure(i + 1) > 0) || (pAseizure(i) == 0))
            crossZerosAnum = crossZerosAnum + 1;
            %crossZerosAloc(1,crossZerosAnum) = pAseizure(i);
        end
        if((pBseizure(i) > 0 && pBseizure(i + 1) < 0) || (pBseizure(i) < 0 && pBseizure(i + 1) > 0) || (pBseizure(i) == 0))
            crossZerosBnum = crossZerosBnum + 1;
            %crossZerosBloc = zeros(1,271);
        end
    end
    allCrossZerosAnum(1,k) = crossZerosAnum;
    allCrossZerosBnum(1,k) = crossZerosBnum;
    %allCrossZerosAloc(1,k) = crossZerosAloc;
    %allCrossZerosBloc(1,k) = crossZerosBloc;
    lineLengthA = 0;
    lineLengthB = 0;
    for i = 1:29999
        lineLengthA = lineLengthA + sqrt((pAseizure(i)-pAseizure(i+1))^2+1^2);
        lineLengthB = lineLengthB + sqrt((pBseizure(i)-pBseizure(i+1))^2+1^2);
    end
    allLineLengthsA(1,k) = lineLengthA;
    allLineLengthsB(1,k) = lineLengthB;

end

graphAamplitude = repelem(allAamplitude,30000);
graphBamplitude = repelem(allBamplitude,30000);
graphCrossZerosA = repelem(allCrossZerosAnum, 30000);
graphCrossZerosB = repelem(allCrossZerosBnum, 30000);
graphLineLengthA = repelem(allLineLengthsA, 30000);
graphLineLengthB = repelem(allLineLengthsB, 30000);

%{
figure(1)
plot(data(3,:))
hold on
plot(graphAamplitude)
title("Patient A ECoG amplitude with ECoG")
xlabel("Sample over time")
ylabel("ECoG or Amplitude")
legend("ECoG", "Amplitude of ECoG")
hold off

figure(2)
plot(data(3,:))
hold on
plot(graphCrossZerosA)
title("Number of time patient A ECoG crosses zero with ECoG")
xlabel("Sample over time")
ylabel("ECoG or Cross Zero Count")
legend("ECoG", "Number of times ECoG crosses zero")
hold off
%}

figure(1)
plot(data(3,:))
hold on
title("Patient A ECoG Data")
xlabel("Sample over time")
ylabel("ECoG")
hold off

figure(2)
plot(data(2,:))
hold on
title("Patient B ECoG Data")
xlabel("Sample over time")
ylabel("ECoG")
hold off


figure(3)
plot(graphLineLengthA)
title("Patient A ECoG Line Length")
xlabel("Sample over time")
ylabel("Line Length")

figure(4)
plot(graphAamplitude)
title("Patient A ECoG Amplitude")
xlabel("Sample over time")
ylabel("ECoG Amplitude")
hold off

figure(5)
plot(graphCrossZerosA)
title("Number of time patient A ECoG crosses zero")
xlabel("Sample over time")
ylabel("Cross Zero Count")
hold off


patientAdetection = zeros(1,180);
for i = 1:180
    if((allAamplitude(i) > 4500) && (allLineLengthsA(i) > 5.4e+05) && allCrossZerosAnum(i) < 750)
        patientAdetection(1,i) = 1;
    end
end
%{
figure(6)
plot(data(3,:),"blue")
hold on
plot(repelem(patientAdetection,30000) * 9500,'red')
title("Patient A Detection")
hold off
%}
patientBdetection = zeros(1,180);
for i = 1:180
    if((allBamplitude(i) > 4500) && (allLineLengthsB(i) > 5.4e+05) && allCrossZerosBnum(i) < 750)
        patientBdetection(1,i) = 1;
    end
end

figure(6)
plot(data(2,:),"blue")
hold on
plot(repelem(patientBdetection,30000) * 14000,'red')
title("Patient B Detection")
xlabel("Samples")
ylabel("ECoG Data")
legend("ECoG data","Predicted Seizure")
hold off


figure(7)
plot(graphBamplitude)
title("Patient B ECoG Amplitude")
xlabel("Sample over time")
ylabel("ECoG Amplitude")
hold off

figure(8)
plot(graphCrossZerosB)
title("Number of time patient B ECoG crosses zero")
xlabel("Sample over time")
ylabel("Cross Zero Count")
hold off

figure(9)
plot(graphLineLengthB)
title("Patient B ECoG Line Length")
xlabel("Sample over time")
ylabel("Line Length")


allClassifiers = vertcat(allAamplitude,allCrossZerosAnum);
allClassifiers = vertcat(allClassifiers, allLineLengthsA);
allTesting = vertcat(allBamplitude, allCrossZerosBnum);
allTesting = vertcat(allTesting, allLineLengthsB);
classifiersNoZeros = vertcat(allAamplitude, allLineLengthsA);
testingNoZeros = vertcat(allBamplitude, allLineLengthsB);

groups = zeros(1,180);
groups(1,97) = 1;
groups(1,98) = 1;
groups(1,99) = 1;
groups(1,100) = 1;
groups(1,101) = 1;
groups(1,102) = 1;

numCorrectAll = 0;
numCorrectNoZeros = 0;

tempClass = classify(transpose(allTesting), transpose(allClassifiers), groups);
tempClass = transpose(tempClass);

tempClassNoZeros = classify(transpose(testingNoZeros), transpose(classifiersNoZeros), groups);
tempClassNoZeros = transpose(tempClassNoZeros);

%for i = 1:180
%    if

figure(10)
plot(data(2,:), "blue")
hold on
plot(repelem(tempClass,30000)*14000)
hold off
title("Patient B Seizure Prediction With All Classifier")
xlabel("Samples")
ylabel("ECoG Data")
legend("ECoG", "Predicted Seizure")

figure(11)
plot(data(2,:), "blue")
hold on
plot(repelem(tempClassNoZeros,30000)*14000)
hold off
title("Patient B Seizure Prediction With 2 Classifiers")
xlabel("Samples")
ylabel("ECoG Data")
legend("ECoG", "Predicted Seizure")

%{
for i = 1:180
    %plot(correctAmplitude)
    if(tempClass(1,i) ~=  0)
        plot(repelem(c))
        %plot([(i*30000 - 30000) (i*30000)], [-15000 15000], "red");
    end
end
hold off
%}
