function [delta, S, V, t] = deltaBinomial(S0, r, sig, T, N, fpayoff,K)
    dt = T/N;
    p0 = 0.5*(exp(-r*dt)+exp((r+sig^2)*dt)); %Initial probability
    u=p0+sqrt(p0^2-1); %Up
    d = 1/u; %down
    qu = (exp(r*dt)-d)/(u-d);% Probability up
    qd = 1-qu; %Probability down
    
    S = zeros(N+1,N+1); %pre-allocate Price Vector
    V = zeros(N+1,N+1); %pre-allocate value vector
    delta = zeros(N+1,N+1); %pre-allocate delta vector
    
    %Price at time T. Use colons for shifting
    for i=N:-1:1
        S(1:i+1,i+1) = S0*d.^([i:-1:0]').*u.^([0:i]');
    end
    S(1,1)=S0;% for efficiency
    
    V(1:N+1,N+1) = fpayoff(S(1:N+1,N+1),K);
    % Retrace back
    for i = N:-1:1
        % Calculate and store option value using risk neutral pricing
        V(1:i,i) = exp(-r*dt)*(qu*V(2:i+1,i+1) + qd*V(1:i,i+1));
        % use vector division (./)
        delta(1:i,i) = (V(2:i+1,i+1)-V(1:i,i+1))./((u-d)*S(1:i,i));
    end
    t = [0:dt:T];
    % tested to match example on
    % http://library.wolfram.com/examples/deltahedging/
end

