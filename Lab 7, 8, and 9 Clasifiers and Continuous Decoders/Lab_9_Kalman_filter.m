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

training = transpose(binData(1:15707, :));
testing = transpose(binData(15708:end, :));

Xt = transpose(X(1:(15707-1),:));
Xt1 = transpose(X(2:15707,:));

A  = Xt*transpose(Xt1)*inv(Xt1*transpose(Xt1));
C = training(:,1:15706)*transpose(Xt)*inv(Xt*transpose(Xt));
%firstDeterm = det(C*transpose(C));
W = 1/(15707-1) *(Xt-A*Xt1)*transpose(Xt-A*Xt1);
Q = (1/15707)*(training(:,1:(15707-1)) - C*Xt)*transpose(training(:,1:(15707-1))-C*Xt);

Pt1 = W;
xt1 = transpose(X(15708,:));
predict = zeros(15706,4);
for i = 1:15706
    xtt1 = A * xt1;
    Ptt1 = A*Pt1*transpose(A)+W;
    %tempOriginal = C*Ptt1*transpose(C)+Q;
    %temp = inv(C*transpose(C)*Ptt1);
    withQ = C*Ptt1*transpose(C)+Q;
    withoutQ = C*Ptt1*transpose(C);
    determ = det(C*Ptt1*transpose(C)+Q);
    Kt = Ptt1*transpose(C)*inv(C*Ptt1*transpose(C)+Q);
    xt = xtt1 + Kt*(testing(:,i)-C*xtt1);
    Pt = (eye(4)-Kt*C)*Ptt1;
    predict(i,1) = xt(1,1);
    predict(i,2) = xt(2,1);
    predict(i,3) = xt(3,1);
    predict(i,4) = xt(4,1);

    xt1 = xt;
    Pt1 = Pt;
    
    
end

figure(1)
%plot(X(15708:15708+250,1))
plot(X(15708:end,1))
hold on
plot(predict(15708:end,1))
title("X Position over time")
xlabel("Time (ms)")
ylabel("X Position (mm)")
legend("Real X Values", "Predicted X Values")
hold off

figure(2)
%plot(X(15708:15708+250,2))
plot(X(15708:end,2))
hold on
%plot(predict(1:250,2))
plot(predict(1:end,2))
title("Y Position over time")
xlabel("Time (ms)")
ylabel("Y Position (mm)")
legend("Real Y values", "Predicted Y values")

figure(3)
%plot(X(15708:15708+250,3))
plot(X(15708:end,3))
hold on
%plot(predict(1:250,3))
plot(predict(1:end,3))
title("X Velocity over time")
xlabel("Time (ms)")
ylabel("X veloctiy (mm/ms)")
legend("Real X velocity values", "Predicted X velocity values")

figure(4)
%plot(X(15708:15708+250,4))
plot(X(15708:end,4))
hold on
%plot(predict(1:250,4))
plot(predict(1:end,4))
title("Y Velocity over time")
xlabel("Time (ms)")
ylabel("Y veloctiy (mm/ms)")
legend("Real Y velocity values", "Predicted Y velocity")

kalmanMSExPos = sum((predict(:,1)-X(15708:end,1)).^2)/15707;
kalmanMXEyPos = sum((predict(:,2)-X(15708:end,2)).^2)/15707;
kalmanMSExVel = sum((predict(:,3)-X(15708:end,3)).^2)/15707;
kalmanMSEyVel = sum((predict(:,4)-X(15708:end,4)).^2)/15707;
kalmanCorrXpos = corr2(predict(:,1),X(15708:end,1));
kalmanCorrYpos = corr2(predict(:,2),X(15708:end,2));
kalmanCorrXvel = corr2(predict(:,3),X(15708:end,3));
kalmanCorrYvel = corr2(predict(:,4),X(15708:end,4));