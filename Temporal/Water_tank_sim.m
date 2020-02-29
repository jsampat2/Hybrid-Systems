%% Hybrid Control Homework #2
clc; clear; close all;
%% Problem 1 Temporal
%%%%% Parameters
r1 = 5;
r2 = 5;
v1 = 3;
v2 = 4;
w = 6;


epsilon = [0, 0.05, 0.2, 0.5, 0.6];

for j = 1:length(epsilon)
    %%%%% Initial conditions
    x1 = 7; 
    x2 = 7;
    x3 = 0;
    
    x0 = [x1; x2; x3];
    
    Tspan = [0 10] ;
    t0 = 0 ; % Initial Time
    t_vec = [] ; x = [] ;
    
    q0_bool = false;
    q1_bool = false;
    q2_bool = false;
    q3_bool = false;
    
    if x0(2) >= r2
        func = @(t,x) q0(t,x,w,v1,v2,r1,r2);
        options = odeset('Events',@(t,x) event_q0(t,x,w,v1,v2,r1,r2,epsilon(j)));
        q0_bool = true;

    else
        func = @(t,x) q2(t,x,w,v1,v2,r1,r2);
        options = odeset('Events',@(t,x) event_q2(t,x,w,v1,v2,r1,r2,epsilon(j)));
        q2_bool = true;
    end

    for i = 1:10
        % Continuous Dynamics
        [t,x_vec] = ode45(func, t0+Tspan, x0, options) ;
        % Save simulation data
        t_vec = [t_vec; t] ;
        x = [x; x_vec] ;
        % Discrete Impact Dynamics
        x0 = x_vec(end,:);
        t0 = t_vec(end);
        
        % Simulate the system until event (water tank) occurs
        if x0(2) <= r2 && q0_bool
            func = @(t,x) q1(t,x,w,v1,v2,r1,r2);
            options = odeset('Events',@(t,x) event_q1(t,x,w,v1,v2,r1,r2,epsilon(j)));
            x0(3) = 0;
            q0_bool = false;
            q1_bool = true;
            q2_bool = false;
            q3_bool = false;
            

        elseif x0(3) >= epsilon(j) && q1_bool 
            func = @(t,x) q2(t,x,w,v1,v2,r1,r2);
            options = odeset('Events',@(t,x) event_q2(t,x,w,v1,v2,r1,r2,epsilon(j)));
            %x0(4) = x0(2);
            q0_bool = false;
            q1_bool = false;
            q2_bool = true;
            q3_bool = false;
            
        elseif x0(1) <= r1 && q2_bool
            func = @(t,x) q3(t,x,w,v1,v2,r1,r2);
            options = odeset('Events',@(t,x) event_q3(t,x,w,v1,v2,r1,r2,epsilon(j)));
            x0(3) = 0;
            q0_bool = false;
            q1_bool = false;
            q2_bool = false;
            q3_bool = true;
            

        elseif x0(3) >= epsilon(j) && q3_bool 
            func = @(t,x) q0(t,x,w,v1,v2,r1,r2);
            options = odeset('Events',@(t,x) event_q0(t,x,w,v1,v2,r1,r2,epsilon(j)));
            %x0(4) = x0(2);
            q0_bool = true;
            q1_bool = false;
            q2_bool = false;
            q3_bool = false;
        end

    end
    
    figure();
    plot(t_vec,x(:,1));
    hold on;
    plot(t_vec,x(:,2));
    xlabel("time");
    ylabel("water level");
    k = epsilon;
    title("Epsilon");
    hold off;
end
