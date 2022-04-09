clc
clear
load H_35H300;load B_35H300;
 mu0=4*pi*10^-7;
load par_gs_inv4;
% load hs;%the output of the inverse model
% load bs;%the output of the direct model
Ms=par_gs_inv4(1);k=par_gs_inv4(2);c=par_gs_inv4(3);alpha=par_gs_inv4(4);a=par_gs_inv4(5);
 Hm1=H_35H300;Bmm1=B_35H300;Hmax=max(H_35H300);
n_points=length(H_35H300);
Hm1 = [Hm1;Hm1;Hm1;Hm1;Hm1;Hm1];
Bmm1= [Bmm1;Bmm1;Bmm1;Bmm1;Bmm1;Bmm1];
 Tsim=length(Hm1);Tstart=1;step=1;
 Mm=Bmm1/mu0-Hm1;
mu0=4*pi*10^-7;
  out=[Hm1,Bmm1];
 t1=[linspace(1,length(Hm1),length(Hm1))]';
  Hinput=[t1,Hm1]; % we have to enter the number of sample with the data
Hm=Hinput;
 
 Binput=[t1,Bmm1];
 Bm2=Binput;
 Hsimmax=1.4195e+03;% for the scaling fator
 open_system('IJAM_simulink');
 sim('IJAM_simulink',Tsim)
load('Hout.mat') % the out put data of the modle
hs=[Hsim(2,:)]';
 figure(1)
 plot(Hm1(end-n_points:end),Bmm1(end-n_points:end),'r',hs(end-n_points:end),Bmm1(end-n_points:end),'b','Linewidth',1.5);
   legend('Meas','Simu','Location','northwest')
 xlabel('H[A/m]'),ylabel('B[T]')
set(gca,'FontSize',15,'fontweight','bold')

 dens=7650; % density in kg/m^3
f=1; % frequency in Hz
 Px=(1000*f/dens).*polyarea(hs(end-n_points:end),Bmm1(end-n_points:end)); 
  P=Px;
 disp(strcat('Simul Power Loss=',num2str(P),' [mW/kg]'));
 
  Pmx=(1000*f/dens).*polyarea(Hm1(end-n_points:end),Bmm1(end-n_points:end)); 
 Pm=Pmx;
  disp(strcat('Meas Power Loss=',num2str(Pm),' [mW/kg]'));