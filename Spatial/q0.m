function [xdot] = q0(t,x,w,v1,v2,r1,r2)
    xdot(1) = -v1;
    xdot(2) = w-v2;
    xdot(3) = 0;
    xdot(4) = 0;
    xdot = [xdot(1); xdot(2); xdot(3); xdot(4)];
end