param_step = 0.004;
param_end = 5*pi;
numero_bit = 32;
numero_bit_uscita = 17;
numero_bit_rimossi = numero_bit - numero_bit_uscita;
picco_max = 2^18;

x = [0:param_step:param_end];
y = floor((normalize(sin(x) + 1/4096*sin(3*x+5) - sin(1.5*x) + 1/10*sin(10*x),'range')) * picco_max);

y_MSB = floor(y / 2^numero_bit_rimossi) * 2^numero_bit_rimossi;
y_LSB = mod(y,2^numero_bit_uscita) * (picco_max/2^numero_bit_uscita);

plot(x,y);
hold;
%plot(x, y_MSB);
plot(x, y_LSB);