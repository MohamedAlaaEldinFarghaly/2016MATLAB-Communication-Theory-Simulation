function [ BER,BERt ] = BER( original,output,PAMlevels,SNRb,N0)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(output);
switch PAMlevels
    case 2
        % BER
        for i=1:n;%length(SNRb)
            diff(:,i)=output(:,i)-original
            BER(i)=nnz(diff(:,i))/(m);
            BERt(i)=0.5*erfc(sqrt(1/N0(i)));  %theoretical BER
        end
        figure,semilogy(SNRb,BER,'*','linestyle','none'),hold on

        semilogy(SNRb,BERt), title('BER vs N0/Eb'),legend('Measured','Analytical','theoretical')

        
        
    case 4
end


end

