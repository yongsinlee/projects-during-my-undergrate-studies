close all; clear all;
% 12각형의 반지름 설정
R = 10;

n=64;
% 12각형의 각도 계산 (0에서 2*pi까지 12개의 각도로 나누기)
theta2 = linspace(0, 2*pi, n+1);  % 13개의 점, 12각형이므로 마지막 점은 첫 번째 점과 동일
theta2(end) = theta2(1);% 마지막 점을 첫 번째 점과 동일하게 설정하여 닫힌 도형 만들기

theta=theta2-2*pi/n/2;
% X, Y 좌표 계산
sx = R * cos(theta);  % x 좌표
sy = R * sin(theta);  % y 좌표
 %xi yi
R2=R*cos(theta(1));
xi=R2*cos(theta2);
yi=R2*sin(theta2);
% 12각형 그리기
figure;
plot(sx, sy, '-o', 'LineWidth', 2);  % 선과 마커로 그리기
%xi yi 그리기
plot(sx,sy,'LineWidth',2); hold on; plot(xi,yi,'ro','LineWidth',2); axis equal;
t= 0:0.01:2*pi; x=R*cos(t);y=R*sin(t);
plot(x,y,'-');
for i=1:n
    text(xi(i)+0.5,yi(i),num2str(i));
end
t_angle=[];
for i=1:n
    t_angle=[t_angle; atan2(sy(i+1)-sy(i),sx(i+1)-sx(i))];
end
for i=1:n
    if t_angle(i)<0
        t_angle(i)=t_angle(i)+2*pi;
    end
end
seta2=t_angle*180/pi;
beta=t_angle+pi/2;
%lambda
I=zeros(n,n);
for i=1:n
    for j=1:n
        if i==j
            I(i,j)=1/2;
        else
        A=-1*(xi(i)-sx(j))*cos(t_angle(j))-1*(yi(i)-sy(j))*sin(t_angle(j));
        B=(xi(i)-sx(j))^2+(yi(i)-sy(j))^2;
        C=sin(t_angle(i)-t_angle(j));
        D=(yi(i)-sy(j))*cos(t_angle(i))-(xi(i)-sx(j))*sin(t_angle(i));
        S=sqrt((sx(j+1)-sx(j))^2+(sy(j+1)-sy(j))^2);
        E=(xi(i)-sx(j))*sin(t_angle(j))-(yi(i)-sy(j))*cos(t_angle(j));
        u=atan2(S+A,E);
        v=atan2(A,E);
        if u<0
            u=u+2*pi;
        end
        if v<0
            v=v+2*pi;
        end 
        % I(i,j)=(C/2*log((S^2+2*A*S+B)/B)+(D-A*C)/E*(atan((S+A)/E)-atan(A/E)))/(2*pi);
                I(i,j)=(C/2*log((S^2+2*A*S+B)/B)+(D-A*C)/E*(u-v))/2/pi*-1;

        end
    end
end
vel_x=1;
vcos=[];
for i=1:n
    vcos=[vcos; vel_x*sin(t_angle(i))];
end
vec=-vel_x*cos(beta);
lambda=-I\vec;
% Cp
S_ij=zeros(n,n);
for i=1:n
    for j=[1:i-1 i+1:n]
        A=-1*(xi(i)-sx(j))*cos(t_angle(j))-1*(yi(i)-sy(j))*sin(t_angle(j));
        B=(xi(i)-sx(j))^2+(yi(i)-sy(j))^2;
        C=sin(t_angle(i)-t_angle(j));
        D=(yi(i)-sy(j))*cos(t_angle(i))-(xi(i)-sx(j))*sin(t_angle(i));
        S=sqrt((sx(j+1)-sx(j))^2+(sy(j+1)-sy(j))^2);
        E=(xi(i)-sx(j))*sin(t_angle(j))-(yi(i)-sy(j))*cos(t_angle(j));
        u=atan2(S+A,E);
        v=atan2(A,E);
        if u<0
            u=u+2*pi;
        end
        if v<0
            v=v+2*pi;
        end 
        S_ij(i,j)=(D-A*C)/2/E*log((S^2+2*A*S+B)/B)-C*(u-v);
        
    end
end
vel_cp=vel_x*sin(beta)+S_ij*lambda/(2*pi);
Cp= 1.- (vel_cp/vel_x).^2;
figure; plot(theta2(1:n+1)*180/pi, [Cp; Cp(1)],'d'); hold on; plot(t*180/pi,1-4*sin(t).^2);
legend('Pannel','Potential');
xlabel('\theta [deg.]'); ylabel('Cp'); grid on;


Ns=100;
yy=-2*R:R/Ns:2*R;
xx=-4*R:R/Ns:4*R;
[Xs Ys]=meshgrid(xx,yy); [Ni,Nj]=size(Xs);
Us=zeros(size(Xs)); Vs=zeros(size(Xs)); uL=Us; vL=Us;
Sj=sqrt(diff(sx).^2+diff(sy).^2);

for i=1:Ni
    for j=1:Nj
        for k=1:n
            xL=cos(t_angle(k))*(Xs(i,j)-xi(k))+sin(t_angle(k))*(Ys(i,j)-yi(k));
            yL=-sin(t_angle(k))*(Xs(i,j)-xi(k))+cos(t_angle(k))*(Ys(i,j)-yi(k));
            uL=lambda(k)/(2.*pi)*0.5*log(  ((xL+0.5*Sj(k))^2+yL^2) ...
                /((xL-0.5*Sj(k))^2 +yL^2) );

            vL = lambda(k)/(2*pi)*(atan( (xL+0.5*Sj(k))/yL)- atan( (xL-0.5 *Sj(k))/yL));
            Us(i,j)=uL*cos(t_angle(k)) - vL.*sin(t_angle(k)) + Us(i,j);
            Vs(i,j)=uL*sin(t_angle(k))+ vL.*cos(t_angle(k)) + Vs(i,j);
        end
    end
end
%velocity field
vel_y=0;
Us=Us +vel_x;
Vs=Vs+vel_y;
Sx= Xs(35:4:Ni-34,1); Sy = Ys(35:4:Ni-34,1);
figure;
h =streamline(Xs,Ys,Us,Vs,Sx,Sy); set(h,'Color','red'); 
hold on; plot(sx,sy,'LineWidth',2);plot(x,y,'-'); axis equal;
figure;
% Cp 
Cp= 1 - (Us.^2 + Vs.^2)/(vel_x^2+vel_y^2);
contour(Xs,Ys,Cp); colorbar; axis equal; title('Cp');

