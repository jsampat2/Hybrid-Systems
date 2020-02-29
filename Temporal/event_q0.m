function [value, isterminal, direction] = event_q0(t,x,w,v1,v2,r1,r2, epsilon)
value = [x(2) <= r2];
isterminal = 1;
direction = 0;
end