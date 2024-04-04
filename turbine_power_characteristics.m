% Clearing workspace variables
clearvars;

% Defining the parameters of the power coefficient
c1 = 0.73;
c2 = 151;
c3 = 0.58;
c4 = 0.002;
c5 = 2.14;
c6 = 13.2;
c7 = 18.4;
c8 = -0.02;
c9 = -0.003;

% Defining other variables
Beta = 0;
omega_m = linspace(0,25,100);
radius = 3.79;
area = pi*radius^2;
air_density = 1.225;
wind_speed = [7,8,9,10,11,12];

% Calculating the values of lambda
Lambda = zeros(6,100);

for m = 1:length(wind_speed)
    Lambda(m,:) = radius*omega_m/wind_speed(m);
end

% Calculating the power coefficient curves
L = zeros(6,100);
Cp = zeros(6,100);

for k = 1:length(wind_speed)
    L(k,:) =  (1./(Lambda(k,:)+c8*Beta)) - (c9/(Beta^3 + 1));
    Cp(k,:) = c1*(c2*L(k,:) - c3*Beta - c4*Beta^c5 - c6).*exp(-c7*L(k,:));
end

% Calculating the power curves
Pm = zeros(6,100);

for i = 1:length(wind_speed)
    Pm(i,:) = Cp(i,:)*0.5*area*air_density*(wind_speed(i))^3;
end

% % Plotting the curves
plot(omega_m,Pm.','b-')
ylim([-0.1 25e3])
grid;
xlabel('Speed Turbine (\omega_{m})')
ylabel('Output Power (W)')
legend('7 m/s', '8 m/s', '9 m/s', '10 m/s', '11 m/s', '12 m/s')
hold off