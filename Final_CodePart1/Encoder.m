%%%% Inputs
% I : array containing the index of the quantization level of each sample
% Type : indicates the type of encoding used where
%        1 : Unipolar NRZ
%        2 : Polar NRZ
%        3 : Manchester
%%%% Outputs 
% ES : Encoded Signal
function [ES,Zx,Zy] = Encoder(I,Type)
I=I-1;
B_I = de2bi(I,'left-msb');     % Converting the index to binary code [de2bi() requires Communication System toolbox]
[m,l] = size(B_I);
ES = reshape(B_I',[1,m*l]);    % Converting the index matrix into a 1D array (which is the encoded signal)
X=0:1:length(ES)-1;
XMan=0:0.5:length(ES)-0.5;
i=1;
for pp=1:length(ES)
    EsMan(i)=ES(pp);
    if ES(pp)==1
        EsMan(i+1)=0;
    else    EsMan(i+1)=1; 
    end
    i=i+2;
end


switch Type
    case 1  % Unipolar NRZ
        [Zx,Zy] = stairs(X,ES);
        figure('Name','Unipolar NRZ','NumberTitle','off')
        plot(Zx,Zy)
        axis([0 20 -1.5 1.5])
    case 2  % Polar NRZ
        [Zx,Zy] = stairs(X,2*(ES)-1);
        figure('Name','Polar NRZ','NumberTitle','off')
        plot(Zx,Zy)
        axis([0 20 -2 2])
    case 3  % Manchester
        [Zx,Zy] = stairs(XMan,2*(EsMan)-1);
        figure('Name','Manchester','NumberTitle','off')
        plot(Zx,Zy)
        axis([0 20 -2 2])
end
end
