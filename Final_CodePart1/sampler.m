function [ xsig_sampled] = sampler( xsig,fs,fs2 )
% mt is sympolic function of t
%ezplot(mt,[0,1])
%hold on
xsig_sampled=downsample(xsig,round(fs2/fs));

xsig_sampled=upsample(xsig_sampled,round(fs2/fs));

xsig_sampled=xsig_sampled(1:length(xsig));

end

