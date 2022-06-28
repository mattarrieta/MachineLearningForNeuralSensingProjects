load("Patient_A-1.mat");
load("Patient_B-1.mat");

[b,a] = butter(4, 100/3000,"high");

filteredAsignal = filtfilt(b, a, data(3,:));
filteredBsignal = filtfilt(b, a, data(2,:));
%filteredAsignal = bandpass(data(3,:),[80 500], 3000);
%filteredBsignal = bandpass(data(2,:),[80 500], 3000);
figure(1)
plot(filteredAsignal)
title("Filtered Patient A Data")
xlabel("Samples")
ylabel("ECoG Data")
figure(2)
plot(filteredBsignal)
title("Filtered Patient B Data")
xlabel("Samples")
ylabel("ECoG Data")

allAamplitude = zeros(1,180);
allBamplitude = zeros(1,180);
allCrossZerosAnum = zeros(1,180);
allCrossZerosBnum = zeros(1,180);
%allCrossZerosAloc = zeros(1,180,1000);
%allCrossZerosBloc = zeros(1,180,1000);
allLineLengthsA = zeros(1,180);
allLineLengthsB = zeros(1,180);
for k=1:90000
    pAseizure = (filteredAsignal((k*60 - 60 + 1): k*60));
    pBseizure = (filteredBsignal((k*60 - 60 + 1): k*60));
    pAamplitude = max(pAseizure) - min(pAseizure);
    pBamplitude = max(pBseizure) - min(pBseizure);
    allAamplitude(1,k) = pAamplitude;
    allBamplitude(1,k) = pBamplitude;

    crossZerosAnum = 0;
    crossZerosAloc = zeros(1,271);
    crossZerosBnum = 0;
    crossZerosBloc = zeros(1,271);
    for i = 1:59
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
    for i = 1:59
        lineLengthA = lineLengthA + sqrt((pAseizure(i)-pAseizure(i+1))^2+1^2);
        lineLengthB = lineLengthB + sqrt((pBseizure(i)-pBseizure(i+1))^2+1^2);
    end
    allLineLengthsA(1,k) = lineLengthA;
    allLineLengthsB(1,k) = lineLengthB;

end

aAmplitudeMean = mean(allAamplitude);
bAmplitudeMean = mean(allBamplitude);

aCrossZeroMean = mean(allCrossZerosAnum);
bCrossZeroMean = mean(allCrossZerosBnum);

aLineLengthsMean = mean(allLineLengthsA);
bLineLengthsMean = mean(allLineLengthsB);

patientAdetection = zeros(1,90000);
patientBdetection = zeros(1,90000);

for i = 1:90000
    if((allAamplitude(i) > aAmplitudeMean * 4) && (allLineLengthsA(i) > aLineLengthsMean *3/2) && allCrossZerosAnum(i) < aCrossZeroMean)
        patientAdetection(1,i) = 1;
    end
end

figure(3)
plot(filteredAsignal,"blue")
hold on
plot(repelem(patientAdetection,60) * 800,'red')
title("Patient A Detection")
hold off

for i = 1:90000
    if((allBamplitude(i) > bAmplitudeMean * 4) && (allLineLengthsB(i) > bLineLengthsMean * 3/2) && allCrossZerosBnum(i) < bCrossZeroMean)
        patientBdetection(1,i) = 1;
    end
end

figure(4)
plot(filteredBsignal,"blue")
hold on
plot(repelem(patientBdetection,60) * 2500,'red')
title("Patient B Detection")
hold off



graphAamplitude = repelem(allAamplitude,60);
graphBamplitude = repelem(allBamplitude,60);
graphCrossZerosA = repelem(allCrossZerosAnum, 60);
graphCrossZerosB = repelem(allCrossZerosBnum, 60);
graphLineLengthA = repelem(allLineLengthsA, 60);
graphLineLengthB = repelem(allLineLengthsB, 60);

allClassifiers = vertcat(allAamplitude,allCrossZerosAnum);
allClassifiers = vertcat(allClassifiers, allLineLengthsA);
allTesting = vertcat(allBamplitude, allCrossZerosBnum);
allTesting = vertcat(allTesting, allLineLengthsB);
classifiersNoZeros = vertcat   (allAamplitude, allLineLengthsA);
testingNoZeros = vertcat(allBamplitude, allLineLengthsB);

groups = zeros(1,90000);
groups(1,7425) = 1;
groups(1,38564) = 1;

tempClass = classify(transpose(allTesting), transpose(allClassifiers), groups);
tempClass = transpose(tempClass);

tempClassNoZeros = classify(transpose(testingNoZeros), transpose(classifiersNoZeros), groups);
tempClassNoZeros = transpose(tempClassNoZeros);

figure(6)
plot(filteredAsignal, "blue")
hold on
plot(repelem(tempClass,60)*800)
hold off
title("Classify with all Classifiers")

figure(7)
plot(filteredBsignal, "blue")
hold on
plot(repelem(tempClassNoZeros,60)*2500)
hold off
title("Classify with no zeros")


