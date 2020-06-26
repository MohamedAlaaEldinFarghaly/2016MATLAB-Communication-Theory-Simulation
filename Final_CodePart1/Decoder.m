%%%% Inputs
% Zx,Zy : The two arrays representing the plot of the encoded signal 
% n: number of bits per sample
% q_level : mapping of the levels
%%%% Outputs 
% Q : quantized signal

function Q = Decoder(Zx,Zy,q_level,L,Type)
    switch Type
        case 1
            p=1;
            for i=1:ceil(length(Zx)/2)
                coded_Q(i)=Zy(p);
                p=p+2;
            end
            n=ceil(log2(L));
            u=length(coded_Q);
            for j=1:u/n
                for k=1:n
                    R(j,k)=coded_Q(k+(j-1)*n);
                end
            end
            Q_leveled=bi2de(R,'left-msb');
            Q_leveled=Q_leveled';
            Q_leveled=Q_leveled+1;
            for r=1:length(Q_leveled)
                Q(r)=q_level(Q_leveled(r)); 
            end

        case 2    
            Zy=(Zy+1)/2;
            p=1;
            for i=1:ceil(length(Zx)/2)
                coded_Q(i)=Zy(p);
                p=p+2;
            end
            n=ceil(log2(L));
            u=length(coded_Q);
            for j=1:u/n
                for k=1:n
                    R(j,k)=coded_Q(k+(j-1)*n);
                end
            end
            Q_leveled=bi2de(R,'left-msb');
            Q_leveled=Q_leveled';
            Q_leveled=Q_leveled+1;
            for r=1:length(Q_leveled)
                Q(r)=q_level(Q_leveled(r)); 
            end

        case 3
          
            Zy=(Zy+1)/2;
            p=1;
            for i=1:ceil(length(Zx)/2)
                ESMAN(i)=Zy(p);
                p=p+2;
            end
    %%%%%%%
    i=1;
    for pp=1:2:length(ESMAN)
    
    if ESMAN(pp)==1
        coded_Q(i)=1;
    else    coded_Q(i)=0; 
    end
    i=i+1;
    end
    n=ceil(log2(L));
    u=length(coded_Q);
    for j=1:u/n
        for k=1:n
            R(j,k)=coded_Q(k+(j-1)*n);
        end
    end
    Q_leveled=bi2de(R,'left-msb');
    Q_leveled=Q_leveled';
    Q_leveled=Q_leveled+1;
    for r=1:length(Q_leveled)
        Q(r)=q_level(Q_leveled(r)); 
    end
    
    end
end
