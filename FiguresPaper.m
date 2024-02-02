clear
close all

load("results\FiguresResponse.mat")

LineW = 1;

DeltaPB = 15/1000;
DeltaSP = 80/1000;
f0 = 2.856;
Qu = 1060;

%% Magnitude

fig1 = figure;
ax1 = axes(fig1);
ax1.Units = "centimeters";
ax1.Position(3:4) = [7.5, 5];
ax1.XLim = [f0 - DeltaSP, f0 + DeltaSP];
ax1.YLim = [-70, 0];
hold on

plot(ax1,freqGHz,S21dbLoss, 'r', 'LineWidth',LineW, 'LineStyle','--')
plot(ax1,freqGHz,S11dbLoss, 'r', 'LineWidth',LineW, 'LineStyle','-')

plot(ax1,freqMeas,S21mod, 'k', 'LineWidth',LineW, 'LineStyle','--')
plot(ax1,freqMeas,S11mod, 'k', 'LineWidth',LineW, 'LineStyle','-')

hold off
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -2*Rs 5])
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -70 5])
ax1.XTick = [f0 - DeltaSP, f0 - DeltaPB, f0 + DeltaPB, f0 + DeltaSP];
% ax1.XTickLabel = num2str([f0-DfUn, f1, f2, f0+DfUn]');
xlabel(ax1,'Frequency (GHz)')
ylabel(ax1,'Magnitude (dB)')

legend(["|S21| syn. loss", "|S11| syn. loss", "|S21| meas.", "|S11| meas."], Location="south")

grid(ax1, 'on')
box(ax1, 'on')
% set(ax1, 'FontSize', 24)

interp1(freqMeas,S21mod,f0)
interp1(freqMeas,S11mod,f0)
interp1(freqMeas,S11mod,f0 - DeltaPB)
interp1(freqMeas,S11mod,f0 + DeltaPB)

idxx = and(freqMeas > f0 - DeltaPB, freqMeas < f0 + DeltaPB);
max(S11mod(idxx))

interp1(freqMeas,S21mod,f0 - DeltaSP)
interp1(freqMeas,S21mod,f0 + DeltaSP)

%% Group delay

fig2 = figure;
ax2 = axes(fig2);
ax2.Units = "centimeters";
ax2.Position(3:4) = [7.5, 5];
ax2.XLim = [f0 - DeltaSP, f0 + DeltaSP];
ax2.YLim = [0, 50];
hold on

plot(ax2,freqGHz,GdTheoryLossy, 'k', 'LineWidth',LineW, 'LineStyle','--')
plot(ax2,freqMeas,GdMeas, 'k', 'LineWidth',LineW, 'LineStyle','-')

hold off
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -2*Rs 5])
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -70 5])
ax2.XTick = [f0 - DeltaSP, f0 - DeltaPB, f0 + DeltaPB, f0 + DeltaSP];
% ax1.XTickLabel = num2str([f0-DfUn, f1, f2, f0+DfUn]');
xlabel(ax2,'Frequency (GHz)')
ylabel(ax2,'Group delay (ns)')

legend(["|S21| syn. loss", "|S21| meas."], Location="south")

grid(ax2, 'on')
box(ax2, 'on')

interp1(freqGHz,GdTheoryLossy,f0)
interp1(freqMeas,GdMeas,f0)

%% Magnitude wideband response

sparamWB = sparameters("C:\Users\giannetti\OneDrive - unifi.it\Università\INFN\Lavori\CavityFilter\Misure\Data20231129\wideband_2_22_GHz_2.s2p");

freqWB = sparamWB.Frequencies*1e-9;
S11WB = mag2db(abs(squeeze(sparamWB.Parameters(1,1,:))));
S21WB = mag2db(abs(squeeze(sparamWB.Parameters(2,1,:))));

fig3 = figure;
ax3 = axes(fig3);
ax3.Units = "centimeters";
ax3.Position(3:4) = [7.5, 5];
ax3.XLim = [2, 12];
ax3.YLim = [-100, 0];
hold on

% plot(ax3,freqWB,S11WB, 'k', 'LineWidth',LineW, 'LineStyle','--')
plot(ax3,freqWB,S21WB, 'k', 'LineWidth',LineW, 'LineStyle','-')

hold off
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -2*Rs 5])
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -70 5])
% ax3.XTick = [f0 - Delta, f0 - DeltaPB, f0 + DeltaPB, f0 + Delta];
% ax1.XTickLabel = num2str([f0-DfUn, f1, f2, f0+DfUn]');
xlabel(ax3,'Frequency (GHz)')
ylabel(ax3,'Magnitude (dB)')

legend(["|S21| meas."], Location="south")
% legend(["|S11| meas.", "|S21| meas."], Location="south")

grid(ax3, 'on')
box(ax3, 'on')

%% Group delay ports

sparamGD = sparameters("C:\Users\giannetti\OneDrive - unifi.it\Università\INFN\Lavori\CavityFilter\Misure\Data20231129\res15.s2p");
gd11 = groupdelay(sparamGD,1,1)*1e9;
gd22 = groupdelay(sparamGD,2,2)*1e9;
freqMeasGD = sparamGD.Frequencies*1e-9;

fig4 = figure;
ax4 = axes(fig4);
ax4.Units = "centimeters";
ax4.Position(3:4) = [7.5, 5];
ax4.XLim = [f0 - DeltaSP, f0 + DeltaSP];
ax4.YLim = [0, 20];
hold on

plot(ax4,freqMeasGD(1:320:3201),gd11(1:320:3201), 'ok', 'LineWidth',LineW, 'LineStyle','none')
plot(ax4,freqMeasGD(161:320:3201),gd22(161:320:3201), 'xr', 'LineWidth',LineW, 'LineStyle','none')

plot(ax4,freqMeasGD,gd11, 'k', 'LineWidth',LineW, 'LineStyle','--')
plot(ax4,freqMeasGD,gd22, 'r', 'LineWidth',LineW, 'LineStyle',':')

hold off
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -2*Rs 5])
% axis([min(w)/(2e9*pi) max(w)/(2e9*pi) -70 5])
ax4.XTick = [f0 - DeltaSP, f0 - DeltaPB, f0 + DeltaPB, f0 + DeltaSP];
% ax1.XTickLabel = num2str([f0-DfUn, f1, f2, f0+DfUn]');
xlabel(ax4,'Frequency (GHz)')
ylabel(ax4,'Group delay (ns)')

legend(["Port 1", "Port 2"], Location="south")

grid(ax4, 'on')
box(ax4, 'on')

GdRealP1 = interp1(freqMeasGD,gd11,f0)
GdRealP2 = interp1(freqMeasGD,gd22,f0)

coeff = GdRealP1;
r = roots([coeff/Qu^2, 2/(pi*f0), -coeff]);
r(2)

%% Saving

% exportgraphics(fig1,"figures\Sparam_magnitude.pdf")
% exportgraphics(fig2,"figures\Sparam_groupdelay.pdf")
% exportgraphics(fig3,"figures\Sparam_magnitudeWB.pdf")
% exportgraphics(fig4,"figures\Sparam_GDports.pdf")