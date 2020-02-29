function [value, isterminal, direction] = event_q0(t,x,w,v1,v2,r1,r2, epsilon)
value = [x(1) <= x(3) - epsilon];
isterminal = 1;
direction = 0;
end