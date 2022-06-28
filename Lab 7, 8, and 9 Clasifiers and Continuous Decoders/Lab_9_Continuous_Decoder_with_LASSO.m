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

lambda = linspace(0,.1,15);

%Btemp = inv(transpose(training)* training + lambda(5)*eye(951)*(15706)) * transpose(training)* X(1:15707,:);
%XpredictionTemp = testing* Btemp;

B1 = lasso(training, X(1:15707, 1), 'Lambda', lambda(5));
Xprediction1 = testing*B1;

B2 = lasso(training, X(1:15707, 2), 'Lambda', lambda(5));
Xprediction2 = testing*B2;

B3 = lasso(training, X(1:15707, 3), 'Lambda', lambda(5));
Xprediction3 = testing*B3;

B4 = lasso(training, X(1:15707, 4), 'Lambda', lambda(5));
Xprediction4 = testing*B4;


%lassoMeanSquaredErrorXpos = immse(Xprediction1(:),X(15708:end,1));
%MSExPos = sum((Xprediction(:,1)-X(15708:end,1)).^2)/15707;
lassoMeanSquaredErrorXpos = sum((Xprediction1(:,1)-X(15708:end,1)).^2)/15707;
%lassoMeanSquaredErrorYpos = immse(Xprediction2(:),X(15708:end,2));
lassoMeanSquaredErrorYpos = sum((Xprediction2(:,1)-X(15708:end,2)).^2)/15707;
%lassoMeanSquaredErrorXvel = immse(Xprediction3(:),X(15708:end,3));
lassoMeanSquaredErrorXvel = sum((Xprediction3(:,1)-X(15708:end,3)).^2)/15707;
%lassoMeanSquaredErrorYvel = immse(Xprediction4(:),X(15708:end,4));
lassoMeanSquaredErrorYvel = sum((Xprediction4(:,1)-X(15708:end,4)).^2)/15707;

lassoCorrXpos = corr2(Xprediction1(:),X(15708:end,1));
lassoCorrYpos = corr2(Xprediction2(:),X(15708:end,2));
lassoCorrXvel = corr2(Xprediction3(:),X(15708:end,3));
lassoCorrYvel = corr2(Xprediction4(:),X(15708:end,4));



