function [value, isterminal, direction] = event_q1(t,x,w,v1,v2,r1,r2, epsilon)
value = [x(2) <= x(4) - epsilon];
isterminal = 1;
direction = 0;
end