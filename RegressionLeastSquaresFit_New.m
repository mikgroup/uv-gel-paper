close all
load T1T2fit.mat
load T1T2proc.mat
%% Separate MICR and Gadolinium Volumes
% MICR Volume
km = [0;0.15;0.15;0.15;0.15;0.3;0.3;0.45;0.45;0.45;0.6;0.6;0.75;0.75;0.9;0.9;1.05;1.05;1.2;1.35;1.35;0.820;0.576];
% Gadolinium volume
kg = [0;0;0.2;0.6;0.8;0.4;0.9;0.1;0.3;0.8;0.2;0.5;0;0.8;0.6;0.3;0.1;0.4;0.5;0;0.3;0.717;0.132];
%% Miki's Code
y = [R1s';R2s'];
ka = [km];% MICR
kb = [kg];% Gad
A = [[ka,kb,kb*0,kb*0,kb*0+1,kb*0];
    [ka*0,ka*0,ka,kb,ka*0,ka*0+1]];
%%
STD = [R1std';R2std'];% [MICR R1 STD, Gad R1 STD, MICR R2 STD, Gad R2 STD]
Q = diag(STD).^2;
% phi = inv(A'*A)*A'*y; %previous rendition
% phi = inv(A'* Q.^(-2)*A)*A'*Q.^(-2) * y; % from Slack
phi = (A' * inv(Q) * A) \ (A' * inv(Q) * y); % Inverting a 40x40 matrix
%% 
imshow3(abs(images.imTE), [])

%% Target Values
WM_R1 = 1/1.100;
WM_R2 = 1/0.070;
GM_R1 = 1/1.800;
GM_R2 = 1/0.100;

%% Results Display
WM_target=[WM_R1;WM_R2];

Intercept=phi(5:6);

m1=phi(1:2);
m2=phi(3:4);

M=[m1';m2'];
WM_volume = inv(M)*(WM_target-Intercept);

GM_target = [GM_R1;GM_R2];

GM_volume = inv(M)*(GM_target-Intercept);
disp('Coefficients:')
fprintf('m1 MICR : %.4f\n', phi(1));
fprintf('m1 Gad  : %.4f\n', phi(2));
fprintf('m2 MICR : %.4f\n', phi(3));
fprintf('m2 Gad  : %.4f\n', phi(4));
fprintf('R1w     : %.4f\n', phi(5));
fprintf('R2w     :%.4f\n', phi(6));
%%
%%
est = A*phi;
figure, plot(R1s,R2s,'*', est(1:end/2),est(end/2+1:end),'*r'); 
ylabel('R2')
title('Measurement and Regression')
legend('Measurement','Regression')
xlabel('R1')
%% Finding the concentrations from a 20 percent range
% WM T1= 1.100ss & T2= 0.070 s
% GM T1= 1.800 s & T2= 0.100 s
T1_target_WM= 1.1;
T2_target_WM= 0.07;
T1_target_GM= 1.8;
T2_target_GM= 0.1;
percent=0.10;

T1_range =[T1_target_WM-(T1_target_WM*percent);T1_target_WM;T1_target_WM+(T1_target_WM*percent);
           T1_target_GM-(T1_target_GM*percent);T1_target_GM;T1_target_GM+(T1_target_GM*percent)];
T2_range =[T2_target_WM-(T2_target_WM*percent);T2_target_WM;T2_target_WM+(T2_target_WM*percent);
           T2_target_GM-(T2_target_GM*percent);T2_target_GM;T2_target_GM+(T2_target_GM*percent)];

T1T2_combined=[T1_range(1),T2_range(1);
               T1_range(1),T2_range(2);
               T1_range(1),T2_range(3);

               T1_range(2),T2_range(1);
               T1_range(2),T2_range(2);
               T1_range(2),T2_range(3);
               
               T1_range(3),T2_range(1);
               T1_range(3),T2_range(2);
               T1_range(3),T2_range(3);

               T1_range(4),T2_range(4);
               T1_range(4),T2_range(5);
               T1_range(4),T2_range(6);

               T1_range(5),T2_range(4);
               T1_range(5),T2_range(5);
               T1_range(5),T2_range(6);
               
               T1_range(6),T2_range(4);
               T1_range(6),T2_range(5);
               T1_range(6),T2_range(6);
                                        ];
R1R2_combined=1./T1T2_combined;
%%
volume = zeros(size(R1R2_combined));

for i = 1:size(R1R2_combined, 1)
    R1 = R1R2_combined(i, 1);
    R2 = R1R2_combined(i, 2);
    WM_target = [R1; R2];

    m1 = phi(1:2);
    m2 = phi(3:4);
    M = [m1'; m2'];
    Intercept = phi(5:6);

    % Calculate volume for each row
    volume_calc = inv(M) * (WM_target - Intercept);
    
    % Store the volume values in the volume matrix
    volume(i, :) = volume_calc';
end
disp(volume);
%% chat gpt
[T1, T2] = meshgrid(T1_range(1:3), T2_range(1:3));
T1T2_combined_new = [T1(:), T2(:)];

[T1, T2] = meshgrid(T1_range(4:6), T2_range(4:6));
T1T2_combined_new = [T1T2_combined_new; [T1(:), T2(:)]];

%%

%% Debugging
% p_hat_debug_G2 = inv(G_R2'*G_R2)*G_R2'*R2_G';
% p_hat_debug_G1 = inv(G_R1'*G_R1)*G_R1'*R1_G';
% p_hat_debug_M1 = inv(M_R1'*M_R1)*M_R1'*R1_M';
% p_hat_debug_M2 = inv(M_R2'*M_R2)*M_R2'*R2_M';

% figure;
% 
% % Plotting the data or function
% plot(kg, R2_G, 'b-', 'LineWidth', 2), hold on, plot(kg,G_R2*p_hat_debug_G2,'+r'); % Blue solid line with a linewidth of 2
% 
% % Add labels and title (Replace with your labels and title)
% xlabel('Gad Vol');
% ylabel('R2 scan values');
% title('Gad R2 vs Gad R2 * P hat');
% 
% figure;
% 
% % Plotting the data or function
% plot(kg, R1_G, 'b-', 'LineWidth', 2), hold on, plot(kg,G_R1*p_hat_debug_G1,'+r'); % Blue solid line with a linewidth of 2
% 
% % Add labels and title (Replace with your labels and title)
% xlabel('Gad Vol');
% ylabel('R2 scan values');
% title('Gad R1 vs Gad R1 * P hat');
 


