function plotTraj(ts1, getcolumn1, getcolumn2, getcolumn3, getcolumn4, getcolumn5)
%CREATEFIGURE(TS1, GETCOLUMN1, GETCOLUMN2, GETCOLUMN3, GETCOLUMN4, GETCOLUMN5)
%  TS1:  x 数据的矢量
%  GETCOLUMN1:  y 数据的矢量
%  GETCOLUMN2:  y 数据的矢量
%  GETCOLUMN3:  y 数据的矢量
%  GETCOLUMN4:  y 数据的矢量
%  GETCOLUMN5:  stairs y

%  由 MATLAB 于 12-Mar-2018 21:37:40 自动生成

% 创建 figure
figure1 = figure;

% 创建 subplot
subplot1 = subplot(2,3,1,'Parent',figure1);
hold(subplot1,'on');

% 创建 plot
plot(ts1,getcolumn1,'Parent',subplot1,'DisplayName','dis','LineWidth',2,...
    'Color',[0 0 1]);

% 创建 xlabel
xlabel('time (s)');

% 创建 ylabel
ylabel('dis (mm)');
axis tight;
% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot1,[0 0.3]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot1,[-0.00299999999997336 0.0629999999994405]);
% 设置其余坐标轴属性
% set(subplot1,'FontSize',20,'XGrid','on',...
%     'YGrid','on','YTickLabel',{'0','20','40','60'});
set(subplot1,'FontSize',20,'XGrid','on',...
    'YGrid','on');
% 创建 legend
% legend1 = legend(subplot1,'show');
% set(legend1,'Interpreter','none');

% 创建 subplot
subplot2 = subplot(2,3,2,'Parent',figure1);
hold(subplot2,'on');

% 创建 plot
plot(ts1,getcolumn2,'Parent',subplot2,'DisplayName','vel','LineWidth',2,...
    'Color',[0 0 1]);
% axis tight;
% 创建 xlabel
xlabel('time (s)');

% 创建 ylabel
ylabel('vel (mm/s)');
axis tight;
% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot2,[0 0.3]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot2,[-0.0125000000168535 0.262500000000627]);
% 设置其余坐标轴属性
% set(subplot2,'FontSize',20,'XGrid','on',...
%     'YGrid','on','YTickLabel',{'0','100','200'});
set(subplot2,'FontSize',20,'XGrid','on',...
    'YGrid','on');
% 创建 legend
% legend2 = legend(subplot2,'show');
% set(legend2,'Interpreter','none');

% 创建 subplot
subplot3 = subplot(2,3,3,'Parent',figure1);
hold(subplot3,'on');

% 创建 plot
plot(ts1,getcolumn3,'Parent',subplot3,'DisplayName','acc','LineWidth',2,...
    'Color',[0 0 1]);
% axis tight;
% 创建 xlabel
% ylim([-10,10]);
xlabel('time (s)');

% 创建 ylabel
ylabel('acc (m/s^2)');
axis tight;
% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot3,[0 0.3]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot3,[-11.0000000000416 10.9999999999984]);
% 设置其余坐标轴属性
set(subplot3,'FontSize',20,'XGrid','on',...
    'YGrid','on');
% 创建 legend
% legend3 = legend(subplot3,'show');
% set(legend3,'Interpreter','none');

% 创建 subplot
subplot4 = subplot(2,3,4,'Parent',figure1);
hold(subplot4,'on');

% 创建 plot
plot(ts1,getcolumn4,'Parent',subplot4,'DisplayName','jerk','LineWidth',2,...
    'Color',[0 0 1]);

% 创建 xlabel
xlabel('time (s)');

% 创建 ylabel
ylabel('jerk (m/s^3)');
axis tight;
% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot4,[0 0.3]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot4,[-880.00000000036 879.999999999876]);
% 设置其余坐标轴属性
set(subplot4,'FontSize',20,'XGrid','on',...
    'YGrid','on');
% 创建 legend
% legend4 = legend(subplot4,'show');
% set(legend4,'Interpreter','none');

% 创建 subplot
subplot5 = subplot(2,3,5,'Parent',figure1);
hold(subplot5,'on');

% 创建 stairs
stairs(ts1,getcolumn5,'DisplayName','snap','Parent',subplot5,'LineWidth',2,...
    'Color',[0 0 1]);

% 创建 xlabel
xlabel('time (s)');

% 创建 ylabel
ylabel('snap (m/s^4)');
axis tight;
% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot5,[0 0.3]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot5,[-70400 70400]);
% 设置其余坐标轴属性
set(subplot5,'FontSize',20,'XGrid','on',...
    'YGrid','on');
% 创建 legend
% legend5 = legend(subplot5,'show');
% set(legend5,'Interpreter','none');

