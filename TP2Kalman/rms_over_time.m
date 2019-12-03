function rmsVector=rms_over_time(x,Ts)

N=length(x);
rmsVector=zeros(N,1);

for i=1:N
    rmsVector(i)=sqrt(sum(x(1:i).^2)/i);
end
end
% Q 
% q