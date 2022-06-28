% Blue line = 20,000 Imaginary Ohms or 0 real Ohms
% Red line = 205,000 Real Ohms
ZredReal = 410000;
ZredIm = 250000;
RenRexRed = 205000;
alphaRed = .637;
Kred = (ZredReal - ZredIm*j - RenRexRed)*(1j*2*pi*100)^(alphaRed);
KredMag = abs(Kred);
ZredTot = RenRexRed + KredMag/((j*2*pi*1000)^alphaRed);
ZredTotAbs = abs(ZredTot)

ZblueReal = 180000;
ZblueIm = 250000;
RenRexBlue = 0;
alphaBlue = .590;
Kblue = (ZblueReal - ZblueIm*j - RenRexBlue)*(1j*2*pi*100)^(alphaBlue);
KblueMag = abs(Kblue);
ZblueTot = RenRexBlue + KblueMag/((j*2*pi*1000)^alphaBlue);
ZblueTotAbs = abs(ZblueTot)

