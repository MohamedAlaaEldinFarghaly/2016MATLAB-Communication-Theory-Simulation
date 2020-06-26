function [ yawgn,yawgnfiltered] = awgnoiseISI( Bits,Ts,PAMlevel,N0,EyeDuration,PulseShape )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

symbolrate=1;
A=1;
SPS=Ts;
    switch PulseShape
        case 'rcosinesqrt'
            
        %generate sqrt rcosine and rcosine filters
            PulseShape='sqrtrcosine';
            [hsqrt,hsqrtnorm]=genPulse(Ts,PulseShape,symbolrate,PAMlevel);

        
         %sqrt rcosine transmiter and reciever filters
            ysqrt=PAM(Bits,PAMlevel,A,SPS,hsqrt);

            Slength=length(ysqrt);
            %figure,stem(ysqrt(1:50)),title('sqrt before noise');
            
            noises=wgnoise( N0,Slength );
            %figure,stem(noises(1:50))

            %eyediagram(ysqrt,EyeDuration*SPS),title('sqrt without noise')

            yawgn1=ysqrt+noises;
            %yediagram(yawgn,EyeDuration*SPS)
            %figure,stem(yawgnsqrt(1:50)),title('sqrt after noise');
          %matched sqrt filter at reciever
            mhsqrt=hsqrt;
            yawgn=filter(mhsqrt,1,yawgn1); 
            yawgnfiltered=filter(mhsqrt,1,yawgn1);
            eyediagram(yawgn(Ts:end),EyeDuration*SPS), title('eyediagram after mfilter')
            figure,stem(yawgnfiltered(1:50)),title('sqrt after filter');
        
        otherwise
        
            [h,hnorm]=genPulse(Ts,PulseShape,symbolrate,PAMlevel);
            %figure,stem(h);
            y=PAM(Bits,PAMlevel,A,SPS,h);
            Slength=length(y);
            figure,stem(y(1:50)),title('before noise');
            noise=wgnoise( N0,Slength );
            

            eyediagram(y,EyeDuration*SPS),title('without noise')

            yawgn=y+noise;
            eyediagram(yawgn,EyeDuration*SPS,2*SPS,SPS/2)
            figure,stem(yawgn(1:50)),title('after noise');

            %filter at reciever
            yawgnfiltered=filter(h,1,yawgn);
            figure,stem(yawgnfiltered(1:50)),title('after filter');
            %eyediagram(yawgnfiltered(1:100),EyeDuration*SPS),title('filtered')
    end
end
