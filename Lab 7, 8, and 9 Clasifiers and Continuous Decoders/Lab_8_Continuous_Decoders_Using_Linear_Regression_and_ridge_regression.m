load("contdata95.mat");
binData = ones(31413, 950);

allOnes = ones(31413, 1);

for i = 1:95
   
    binData(:,10*i-9) = Y(:,i);

    binData(:,10*i-8) = circshift(Y(:,i),1);
    binData(1,10*i-8) = 0;
    
    binData(:,10*i-7) = circshift(Y(:,i),2);
    binData(1:2,10*i-7) = 0;
    
    binData(:,10*i-6) = circshift(Y(:,i),3);
    binData(1:3,10*i-6) = 0;
    
    binData(:,10*i-5) = circshift(Y(:,i),4);
    binData(1:4,10*i-5) = 0;
    
    binData(:,10*i-4) = circshift(Y(:,i),5);
    binData(1:5,10*i-4) = 0;
    
    binData(:,10*i-3) = circshift(Y(:,i),6);
    binData(1:6,10*i-3) = 0;
    
    binData(:,10*i-2) = circshift(Y(:,i),7);
    binData(1:7,10*i-2) = 0;
    
    binData(:,10*i-1) = circshift(Y(:,i),8);
    binData(1:8,10*i-1) = 0;
    
    binData(:,10*i) = circshift(Y(:,i),9);
    binData(1:9,10*i) = 0;
    
end

binData = horzcat(allOnes, binData);

training = binData(1:15707, :);
testing = binData(15708:end, :);

B = inv(transpose(training)* training) * transpose(training)* X(1:15707,:);
Xprediction = testing* B;

figure(1)
plot(X(15708:15708+250,1))
hold on
plot(Xprediction(1:250,1))
title("X Position over 250 ms")
xlabel("Time (ms)")
ylabel("X Position (mm)")
legend("Real X Values", "Predicted X Values")
hold off

figure(2)
plot(X(15708:15708+250,2))
hold on
plot(Xprediction(1:250,2))
title("Y Position over 250 ms")
xlabel("Time (ms)")
ylabel("Y Position (mm)")
legend("Real Y values", "Predicted Y values")

figure(3)
plot(X(15708:15708+250,3))
hold on
plot(Xprediction(1:250,3))
title("X Velocity over 250 ms")
xlabel("Time (ms)")
ylabel("X veloctiy (mm/ms)")
legend("Real X velocity values", "Predicted X velocity values")

figure(4)
plot(X(15708:15708+250,4))
hold on
plot(Xprediction(1:250,4))
title("Y Velocity over 250 ms")
xlabel("Time (ms)")
ylabel("Y veloctiy (mm/ms)")
legend("Real Y velocity values", "Predicted Y velocity")


%size(training)
%size(B)
%size(training*B)
%size(Xprediction)
%error = training*B-Xprediction
%error = transpose(training*B-Xprediction)*(B*training-Xprediction)
%errorFirst = transpose(B)*transpose(training)*training*B;
%errorSecond = 2*transpose(training)*X(1:15707,:);
%errorThird = transpose(X)*X;
%error = errorFirst - errorSecond;
%MSEXPOS = sum((Xprediction(:,1)-X(15708:end,1)).^2)/15707;

meanSquaredErrorXpos = immse(Xprediction(:,1),X(15708:end,1));
MSExPos = sum((Xprediction(:,1)-X(15708:end,1)).^2)/15707;
meanSquaredErrorYpos = immse(Xprediction(:,2),X(15708:end,2));
MXEyPos = sum((Xprediction(:,2)-X(15708:end,2)).^2)/15707;
meanSquaredErrorXvel = immse(Xprediction(:,3),X(15708:end,3));
MSExVel = sum((Xprediction(:,3)-X(15708:end,3)).^2)/15707;
meanSquaredErrorYvel = immse(Xprediction(:,4),X(15708:end,4));
MSEyVel = sum((Xprediction(:,4)-X(15708:end,4)).^2)/15707;

corrXpos = corr2(Xprediction(:,1),X(15708:end,1));
corrYpos = corr2(Xprediction(:,2),X(15708:end,2));
corrXvel = corr2(Xprediction(:,3),X(15708:end,3));
corrYvel = corr2(Xprediction(:,4),X(15708:end,4));

lambda = linspace(0,.1,15);
%t = ["Xpos Correlation", corrXpos];

MESlambdas = zeros(1,15);
Corrlambdas = zeros(1,15);

%disp(t)
%Br = inv(transpose(training)* training + lambda(1)*eye(951)*(15707*951)) * transpose(training)* X(1:15707,:);

for i = 1:15
    %Make sure N is correct
    Btemp = inv(transpose(training)* training + lambda(i)*eye(951)*(15706)) * transpose(training)* X(1:15707,:);
    XpredictionTemp = testing* Btemp;
    %meanSquaredErrorXposTemp = immse(XpredictionTemp(:,1),X(15708:end,1));
    meanSquaredErrorXposTemp = sum((XpredictionTemp(:,1)-X(15708:end,1)).^2)/15707;
    %meanSquaredErrorYposTemp = immse(XpredictionTemp(:,2),X(15708:end,2));
    meanSquaredErrorYposTemp = sum((XpredictionTemp(:,2)-X(15708:end,2)).^2)/15707;
    %meanSquaredErrorXvelTemp = immse(XpredictionTemp(:,3),X(15708:end,3));
    meanSquaredErrorXvelTemp = sum((XpredictionTemp(:,3)-X(15708:end,3)).^2)/15707;
    %meanSquaredErrorYvelTemp = immse(XpredictionTemp(:,4),X(15708:end,4));
    meanSquaredErrorYvelTemp = sum((XpredictionTemp(:,4)-X(15708:end,4)).^2)/15707;
    print1 = [i, "Mean squared error Xpos", meanSquaredErrorXposTemp];
    print2 = [i, "Mean squared error Ypos", meanSquaredErrorYposTemp];
    print3 = [i, "Mean squared error Xvel", meanSquaredErrorXvelTemp];
    print4 = [i, "Mean squared error Yvel", meanSquaredErrorYvelTemp];
    
    MESlambdas(1,i) = meanSquaredErrorXposTemp;

    corrXposTemp = corr2(XpredictionTemp(:,1),X(15708:end,1));
    corrYposTemp = corr2(XpredictionTemp(:,2),X(15708:end,2));
    corrXvelTemp = corr2(XpredictionTemp(:,3),X(15708:end,3));
    corrYvelTemp = corr2(XpredictionTemp(:,4),X(15708:end,4));

    Corrlambdas(1,i) = corrXposTemp;

    print5 = [i, "Correlation Xpos", corrXposTemp];
    print6 = [i, "Correlation Ypos", corrYposTemp];
    print7 = [i, "Correlation Xvel", corrXvelTemp];
    print8 = [i, "Correlation Yvel", corrYvelTemp];
%{
    disp(print1)
    disp(print2)
    disp(print3)
    disp(print4)
    disp(print5)
    disp(print6)
    disp(print7)
    disp(print8)
%}
end

bestLambda = lambda(5);

Btemp = inv(transpose(training)* training + bestLambda*eye(951)*(15706)) * transpose(training)* X(1:15707,:);
Xprediction1= testing* Btemp;

Bempty = inv(transpose(training)* training + 0*eye(951)*(15706)) * transpose(training)* X(1:15707,:);
XpredictionEmpty = testing * Bempty;
ridgeNoLambdaMSE = immse(XpredictionEmpty(:,1),X(15708:end,1));

%ridgeMeanSquaredErrorXposTemp = immse(Xprediction1(:,1),X(15708:end,1));
ridgeMeanSquaredErrorXposTemp = sum((Xprediction1(:,1)-X(15708:end,1)).^2)/15707;
%ridgeMeanSquaredErrorYposTemp = immse(Xprediction1(:,2),X(15708:end,2));
ridgeMeanSquaredErrorYposTemp = sum((Xprediction1(:,2)-X(15708:end,2)).^2)/15707;
%ridgeMeanSquaredErrorXvelTemp = immse(Xprediction1(:,3),X(15708:end,3));
ridgeMeanSquaredErrorXvelTemp = sum((Xprediction1(:,3)-X(15708:end,3)).^2)/15707;
%ridgeMeaanSquaredErrorYvelTemp = immse(Xprediction1(:,4),X(15708:end,4));
ridgeMeaanSquaredErrorYvelTemp = sum((Xprediction1(:,4)-X(15708:end,4)).^2)/15707;
print1 = ["Mean squared error Xpos best lambda", ridgeMeanSquaredErrorXposTemp];
print2 = ["Mean squared error Ypos best lambda", ridgeMeanSquaredErrorYposTemp];
print3 = ["Mean squared error Xvel best lambda", ridgeMeanSquaredErrorXvelTemp];
print4 = ["Mean squared error Yvel best lambda", ridgeMeaanSquaredErrorYvelTemp];


ridgeCorrXposTemp = corr2(Xprediction1(:,1),X(15708:end,1));
ridgeCorrYposTemp = corr2(Xprediction1(:,2),X(15708:end,2));
ridgeCorrXvelTemp = corr2(Xprediction1(:,3),X(15708:end,3));
ridgeCorrYvelTemp = corr2(Xprediction1(:,4),X(15708:end,4));

print5 = ["Correlation Xpos best lambda", ridgeCorrXposTemp];
print6 = ["Correlation Ypos best lambda", ridgeCorrYposTemp];
print7 = ["Correlation Xvel best lambda", ridgeCorrXvelTemp];
print8 = ["Correlation Yvel best lambda", ridgeCorrYvelTemp];

disp(print1)
disp(print2)
disp(print3)
disp(print4)
disp(print5)
disp(print6)
disp(print7)
disp(print8)

figure(5)
plot(X(15708:15708+250,2))
hold on
plot(Xprediction1(1:250,2))
title("Y Position over 250 ms")
xlabel("Time (ms)")
ylabel("Y - Position (mm)")
legend("Real Y values", "Predicted Y values")

figure(6)
plot(X(15708:15708+250,3))
hold on
plot(Xprediction1(1:250,3))
title("X Velocity over 250 ms")
xlabel("Time (ms)")
ylabel("X veloctiy (mm/ms ?)")
legend("Real X velocity values", "Predicted X velocity values")

figure(7)
plot(lambda, MESlambdas)
title("Mean Error Square of X position for various lambdas")
xlabel("Lambda")
ylabel("Mean Error Sqaure")


figure(8)
plot(lambda, Corrlambdas)
title("Correleation of X position for various lambdas")
xlabel("Lambda")
ylabel("Correlation")
