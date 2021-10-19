param_step = 0.004;
param_end = 2*pi;

x = [0:param_step:param_end];
y = floor(sin(x) * 2^10);

file_id = fopen('lt.txt', 'w');
for index = (1:size(y,2))
    fprintf(file_id, "%d, ", y(index));
end

z = filtra(y);

plot(x,normalize(y,'range'));
hold;
%plot(x,normalize(z,'range'));
%hold;
plot(x,normalize(z,'range'));