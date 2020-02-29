function [value, isterminal, direction] = event_before_ground(t,x,h)
value = [x(3) - h >= 0.0001];
isterminal = 1;
direction = 0;
end