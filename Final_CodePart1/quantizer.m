function [qindex,q_out,delta,sqnr,q_level]=quantizer(sig_in,L,mode,mp,Mu)
%mode 0 for uniform mode 1 for non uniform

%q_out is the quantized o/p
%delta is the quanization interval
%sqnr: the actual signal to quanization error
delta=(2*mp)/L;

q_level=-mp+delta/2:delta:mp-delta/2;

if (mode==0)

%L_sig=length(sig_in);
sigp=(sig_in+mp)/delta + (1/2);
qindex=round(sigp);
qindex=min(qindex,L);
qindex=max(qindex,1);
q_out=q_level(qindex);
sqnr=20*log10(norm(sig_in)/norm(sig_in-q_out));

elseif(mode ==1)
    if(Mu~=0) 
       comp = mp.*sign(sig_in).*(log(1+(Mu*abs(sig_in))/mp))/(log(1+Mu));
    else
        comp=sig_in;
    end
    
  sigp=(comp+mp)/delta + (1/2);
qindex=round(sigp);
qindex=min(qindex,L);
qindex=max(qindex,1);
q_out=q_level(qindex);
sqnr=(3*L^2)/(log(1+Mu))^2;
      
        
        
end
end
%expand=mp.*sign(comp).*((((Mu+1).^abs(comp/mp))-1)/Mu);

