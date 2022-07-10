clear;
clc;

i_d = 0.68;
i_q = 0;
i_od = 0.68;
i_oq = 0;
v_od = 0.47;
v_oq = 0;
i_ld = 0.68;
i_lq = 0;
m_d = 0.3;
m_q = 0;

for i = 1:1
    t = 0:0.0032:0.0064;
    tic
    [t,x] = ode45(@(t,x)der_dyn(t,x),t,[i_d;i_q;i_od;i_oq;v_od;v_oq;i_ld;i_lq;m_d;m_q]);
    toc
%     s(i,:) = x(2,:);
%     i_d = x(2,1);
%     i_q = x(2,2);
%     i_od = x(2,3);
%     i_oq = x(2,4);
%     v_od = x(2,5);
%     v_oq = x(2,6);
%     i_ld = x(2,7);
%     i_lq = x(2,8);
%     m_d = x(2,9);
%     m_q = x(2,10);
end

plot(x(:,5))
% axis([0 10 0.465 0.48])

function f = der_dyn(t,z)

c_f = 2500;
r_f = 0.002;
l_f = 0.0001;
P_r = 1;
Q_r = 0.000001;
k_p = 0.5;
r_c = 0.0384;
r_n = 0.001;

i_d = z(1);
i_q = z(2);
i_od = z(3);
i_oq = z(4);
v_od = z(5);
v_oq = z(6);
i_ld = z(7);
i_lq = z(8);
m_d = z(9);
m_q = z(10);

w = 1/60;
I_ld = 2.08;
I_lq = 0.000001;
v_bd = 0.48;
v_bq = 0.000001;
% v_bd = r_n*(i_od-i_d);
% v_bq = r_n*(i_oq-i_q);
% v_err = 0.48 - v_bd;
% v_diesel = 0.03*v_err + 0.1*(v_err/(1 + v_err));
% v_err_bat = 0.48 - v_diesel;
% v_bat = 0.02*v_err_bat + 0.08*(v_err_bat/(1 + v_err_bat));
% v_bd = v_diesel + v_bat;

f = zeros(size(z));

f(1) = -P_r*i_d + w*i_q + v_bd;
f(2) = -Q_r*i_q - w*i_d + v_bq;
f(3) = -r_c*i_od + w*i_oq + v_od - v_bd;
f(4) = -r_c*i_oq - w*i_od + v_oq - v_bq;
f(5) = w*v_oq + (i_ld - i_od)/c_f;
f(6) = -w*v_od + (i_lq - i_oq)/c_f;
f(7) = -(r_f/l_f)*i_ld + w*i_lq + (m_d - v_od)/l_f;
f(8) = -(r_f/l_f)*i_lq - w*i_ld + (m_q - v_oq)/l_f;
f(9) = -w*i_lq + k_p*(I_ld - i_ld);
f(10) = -w*i_ld + k_p*(I_lq - i_lq);

end