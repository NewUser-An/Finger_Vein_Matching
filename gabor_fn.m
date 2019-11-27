% % ������������gabor�˲���, ����Ϊ����׼��, �Ƕ�, ����, ����, �ռ䷽��ȣ�
function gb = gabor_fn(sigma, theta, lambda, psi, gamma)
sigma_x = sigma;
sigma_y = sigma / gamma;
theta = theta /180 * pi;

% 3 sigma
nstds = 3;
% ��ȡgabor�˲����Ĵ�С
xmax = max(abs(nstds * sigma_x * cos(theta)),abs(nstds * sigma_y * sin(theta)));
xmax = ceil(max(1, xmax));
ymax = max(abs(nstds * sigma_x * sin(theta)),abs(nstds * sigma_y * cos(theta)));
ymax = ceil(max(1, ymax));
xmin = -xmax; 
ymin = -ymax;
[x,y] = meshgrid(xmin : xmax,ymin : ymax);

% ����gabor�˲���
x_theta = x * cos(theta) + y * sin(theta);
y_theta = -x * sin(theta) + y * cos(theta);

gb = exp(-.5 * (x_theta .^ 2 / sigma_x ^ 2 + y_theta .^ 2 / sigma_y ^ 2)) .* cos(2 * pi / lambda * x_theta + psi);