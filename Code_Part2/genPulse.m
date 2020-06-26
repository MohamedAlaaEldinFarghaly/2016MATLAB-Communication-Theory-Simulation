function [ pulseshape,normshape ] = genPulse( width,shape ,symbolRate,PAMlevel)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

ns=width;
w=0.5*symbolRate;
SPS=width;
%length=2*SPS+1;
rolloff=1;

switch shape
    case 'NRZ'
        NRZ=ones(1,ns);  %NRZ Pulse Shape sampled
        NRZnorm=NRZ/sqrt(sum(NRZ));   %normalization
        pulseshape=NRZ; normshape=NRZnorm;
    case 'RZ'
        RZ=[ones(1,floor(ns/2)) zeros(1,ceil(ns/2))];  %RZ Pulse Shape
        RZnorm=RZ/sqrt(sum(RZ));   %normalization
        pulseshape=RZ; normshape=RZnorm;
    case 'Ideal Nyquist'
        t=-ns:ns;
        n=t/ns;
        Nyq=sinc(2*w*n);     %Ideal Nyquist Pulse shape
        Nyq=Nyq(1:2:end)/max(Nyq);
        Nyqnorm=Nyq/sqrt(sum(Nyq));   %normalization
        pulseshape=Nyq; normshape=Nyqnorm;
    case 'rcosine'
        H = rcosdesign(rolloff, PAMlevel, SPS, 'normal');
        H=H(1:2:end)/max(H);
        Hnorm=H/sqrt(sum(H));
        pulseshape=H; normshape=Hnorm;
    case 'sqrtrcosine'
        H = rcosdesign(rolloff, PAMlevel, SPS, 'sqrt');
        H=H(1:2:end)/max(H);

         Hnorm=H/sqrt(sum(H));
         
        pulseshape=H; normshape=Hnorm;
end


end

