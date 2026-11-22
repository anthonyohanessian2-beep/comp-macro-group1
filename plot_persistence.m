function plot_persistence(rhos,X)
% Overlay of responses to a one-sd TFP innovation for several rho_a, in levels.
% Reads rbc_rho<rho>_o1.mat saved by main.mod; no Dynare rerun.
% Example: plot_persistence([0.5 0.9 0.95],40)
% Layout and styling follow the instructor's plot_lecture34.m. Changes: several
% runs overlaid, impulse responses (steady state + IRF) instead of one simulation.
if nargin<1, rhos=[0.5 0.9 0.95]; end
if nargin<2, X=40; end
lw=4.5;      % line width of the responses; raise it if the lines still look thin
lw_ss=3;     % line width of the dashed steady-state line
variables={'y','c','invest','n','k','w'};
titles={'Output','Consumption','Investment','Hours worked','Capital carried forward','Real wage'};
symbols={'Y_t','C_t','I_t','N_t','K_{t+1}','w_t'};
units={'Goods per period','Goods per period','Goods per period','Share of time','Capital, goods','Goods per hour'};
heading='Persistence of a TFP shock';
if ~exist('figures','dir'), mkdir('figures'); end
blue=[0 76 103]/255; red=[200 60 50]/255; orange=[255 160 35]/255;
colors={blue,red,orange}; ink=[35 52 61]/255; font='Palatino Linotype';
dates=0:X-1; limits=[0 X-1];
fig=figure('Visible','off','Color','w','Position',[80 80 1380 850]);
annotation(fig,'textbox',[0.035 0.915 0.93 0.075],'String',heading, ...
    'EdgeColor','none','FontName',font,'FontSize',23,'FontWeight','bold', ...
    'Color',blue,'HorizontalAlignment','left','Interpreter','none');
annotation(fig,'textbox',[0.035 0.865 0.94 0.05], ...
    'String','Response to a one-standard-deviation TFP innovation at t = 0   |   Grey dashed: steady state', ...
    'EdgeColor','none','FontName',font,'FontSize',14,'Color',ink,'Interpreter','none');
left=0.068; right=0.025; gap=0.075; ncols=3; nrows=2;
width=(1-left-right-(ncols-1)*gap)/ncols;
bottom=0.115; top=0.775; vertical_gap=0.15;
axis_height=(top-bottom-(nrows-1)*vertical_gap)/nrows;
for j=1:numel(variables)
    col=mod(j-1,ncols); row=floor((j-1)/ncols);
    axes('Parent',fig,'Position',[left+col*(width+gap), ...
        top-(row+1)*axis_height-row*vertical_gap,width,axis_height]);
    hold on;
    for i=1:numel(rhos)
        S=load(sprintf('rbc_rho%g_o1.mat',rhos(i)));
        idx=strcmp(cellstr(S.M_.endo_names),variables{j});
        ss=S.oo_.steady_state(idx);
        irf=S.oo_.irfs.([variables{j} '_eps_a']);
        assert(X<=numel(irf),'Only %d periods saved.',numel(irf));
        h(i)=plot(dates,ss+irf(1:X),'Color',colors{i},'LineWidth',lw);
    end
    plot(limits,ss*[1 1],'--','Color',[0.5 0.5 0.5],'LineWidth',lw_ss);
    xlim(limits);
    tick_step=max(1,ceil((X-1)/4)); ticks=unique([0:tick_step:X-1 X-1]);
    set(gca,'XTick',ticks,'FontName',font,'FontSize',15,'Box','off', ...
        'TickDir','out','XColor',ink,'YColor',ink,'LineWidth',1.5);
    title([titles{j} ' (' symbols{j} ')'],'Interpreter','tex', ...
        'FontName',font,'FontSize',18,'FontWeight','bold','Color',blue);
    xlabel('Period after the shock','FontName',font,'FontSize',15);
    ylabel(units{j},'FontName',font,'FontSize',15);
    grid on; set(gca,'GridAlpha',0.14);
    if j==1
        legend(h,arrayfun(@(r) sprintf('persistence %g',r),rhos,'UniformOutput',false), ...
            'FontSize',13,'Box','off');
    end
end
set(fig,'PaperPositionMode','auto');
print(fig,'figures/irf_persistence.png','-dpng','-r200');
fprintf('Saved figures/irf_persistence.png\n');
end