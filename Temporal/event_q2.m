function [value, isterminal, direction] = event_q2(t,x,w,v1,v2,r1,r2,epsilon)
value = [x(1) <= r1];
isterminal = 1;
direction = 0;
end