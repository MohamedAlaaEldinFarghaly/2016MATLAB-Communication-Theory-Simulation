function [s_rec,S_rec,faxis,lfft]=reconstruction(q_out,fs,fs2,fc)

% xsig_sampled=downsample(xsig,round(fs2/fs));
% 
% xsig_sampled=upsample(xsig_sampled,round(fs2/fs));
% 
% xsig_sampled=xsig_sampled(1:length(xsig));
lfft=2^ceil(log2(length(q_out))+1);
fmax=fs2/2;
faxis=linspace(-fmax,fmax,lfft);
s_out=q_out;

S_out=fftshift(fft(s_out,lfft));


S_out(abs(faxis)>fc)=0;
S_out=S_out*(fs2/fs);
s_rec=real(ifft(fftshift(S_out)));

S_rec=S_out;

s_rec=s_rec(1:length(q_out));

end