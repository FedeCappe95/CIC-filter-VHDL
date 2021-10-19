function y = filtra(x)
    par_R = 4;
    par_M = 1;
    par_N = 4;
    %numeroBit = 16;
    
    s = size(x);
    sampleNumber = s(2);
    
    y = [0 0 0 0];

    sumTop = par_R * par_M;
    for n = sumTop:(sampleNumber-1)
       sum = 0;
       for k = 0:sumTop
           index = n-k+1;
           sum = sum + x(index);
       end
       sum = sum ^ par_N;
       y = [y sum];
    end
    
    y = floor(y);
end