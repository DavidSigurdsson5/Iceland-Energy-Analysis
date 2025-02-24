%%
clear all; close all; clc;
% Orkuskýrsla: Davíð Haukur Sigurðsson
% Heimild https://orkustofnun.is/eldsneyti/tolfraedi/eldsneytisnotkun
% :Hérna er náð í OS-2019-T005-01.xlsx skjalið
% 2020 tölur med notkun og mynd með bara rafmagn; rafmagn i GWh og tyngd i
% tonn
% Graf fyrir nuverandi framleidlsu rafmagns; med rafmagn sem tarf ad bæta
% við i hverji svidsmynd
eldsneytisnotkun = readtable('OS-2019-T005-01.xlsx');
data = eldsneytisnotkun(37,:); % notum ar 2018
m1 = data.(2); % bifreidar
m2 = data.(3); % sjosamgongur
m3 = data.(9); % Fiskiskip
mflug = data.(6)*10^3; % Flugsamgongur flugvélaeldsneyti breytt fra tonn i kg med 10^3
mskip = m2 + m3*10^3; % skip dísel breytt fra tonn i kg med 10^3
mflut = m1*0.09*10^3; % 9% af oliu nota flutningsbilar breytt fra tonn i kg med 10^3
mheim = m1*0.58*10^3; % 58% af bensíni nota heimilisbilar breytt fra tonn i kg med 10^3
% https://hagstofa.is/utgafur/frettasafn/samgongur/fjoldi-okutaekja-og-eldsneytisnotkun/
% heimild synir hlutafll bensin vs disel https://www.samgongustofa.is/umferd/tolfraedi/onnur-tolfraedi/
% Nytni 

Nb = 0.28; %Nytni bensinsvela
Nd = 0.28; %Nytni diselvela
Nk = 0.4; %Nytni flugmótora

dh = 84557/167978; % disel/bensin synir hlutfall disel vs bensin i heimilisbifreidum
bf = (12 + 642 + 6543)/(6696 + 5103 + 21140);% bensin/disel hlutfall bensin vs disel i flutningsbilum 
hvb = 43.1; % MJ/kg
hvd = 42.7; % MJ/kg
hvk = 43.1; % MJ/kg
% Notkun bensin og disel milli heimilisbila og flutningsbila
noth = [mheim*dh mheim*(1-dh)];
notf = [mflut*bf mflut*(1-bf)];

Qflug = mflug*hvk;
Qskip = mskip*hvd;
Qflut = mflut*((bf*hvb) + (1-bf)*hvd);
Qheim = mheim*((dh*hvb) + (1-dh)*hvd);
% Vinna
Wflug = Qflug*Nk;
Wskip = Qskip*Nd;
Wflut = Qflut*Nb; %Notum bara bensinnytistuðulilnn vegna þess að nytni bensinvéla og disel véla er það sama
Wheim = Qheim*Nb;

n = [noth 0 ; notf 0 ;0 0 mflug ;0 mskip 0];

xx = categorical({'Fólksbifreiðar' 'Flutningabifreiðar' 'Flugvélar' 'skip'});
xx = reordercats(xx,{'Fólksbifreiðar' 'Flutningabifreiðar' 'Flugvélar' 'skip'});


y1 = ([Wheim,Wflut,Wflug,Wskip]./0.63)/(3.6.*10^6);
y2 = ([Wheim/0.63 0 0;0 0 Wflut/0.198;0 0 Wflug/0.198;0 Wskip/0.198 0])/(3.6.*10^6);
y3 = ([Wheim/0.63 0;Wflut/0.63 0;0 Wflug/0.198;Wskip/0.63 0])/(3.6.*10^6);


no = n*10^-3;% breyti kg i tonn aftur fyrir graf

%% Sviðsmynd 1
subplot(2,1,1)
H = bar(xx,no,'stacked');% bar graf sem synir notkun bensins
set(H,{'DisplayName'}, {'Bensín','Dísel','Kerósín'}')
legend()
title('Olíusala eftir geirum 2018')
ylabel('Olíusala í tonnum') 
form = '%.1f';
%Teiknar inn á tölur yfir stöplum
for i = 1:length(no)
    txt = [num2str(sum(no(i,:)),form),' tonn'];
    text(i,sum(no(i,:)),txt,'vert','bottom','horiz','center');
end

subplot(2,1,2)
j = bar(xx,y1);
set(j,{'DisplayName'}, {'Rafmagn'}')
legend()
ylabel('Raforka í GWh')
title('Raforkuþörf til að anna eftirspurn í sviðsmynd 1 (2018)')
ylim([0 4000])
%Teiknar inn á tölur yfir stöplum
for i = 1:length(y1)
    txt = [num2str(y1(i),form),' GWh'];
    text(i,y1(i),txt,'vert','bottom','horiz','center');
end
saveas(gcf,'orkugraf1.png')

%% Sviðsmynd 2
subplot(2,1,1)
H = bar(xx,no,'stacked');% bar graf sem synir notkun bensins
set(H,{'DisplayName'}, {'Bensín','Dísel','Kerósín'}')
legend()
title('Olíusala eftir geirum 2018')
ylabel('Olíusala í tonnum')
%Teiknar inn á tölur yfir stöplum
for i = 1:length(no)
    txt = [num2str(sum(no(i,:)),form),' tonn'];
    text(i,sum(no(i,:)),txt,'vert','bottom','horiz','center');
end
subplot(2,1,2)
v = bar(xx,y2,'stacked');
set(v,{'DisplayName'}, {'Rafmagn','Ammoníak','Vetni'}')
legend()
ylabel('Raforka í GWh')
title('Raforkuþörf til að anna eftirspurn í sviðsmynd 1 (2018)')
%Teiknar inn á tölur yfir stöplum
for i = 1:length(y2)
    txt = [num2str(sum(y2(i,:)),form),' GWh'];
    text(i,sum(y2(i,:)),txt,'vert','bottom','horiz','center');
end
saveas(gcf,'orkugraf2.png')

%% Sviðsmynd 3
subplot(2,1,1)
H = bar(xx,no,'stacked');% bar graf sem synir notkun bensins
set(H,{'DisplayName'}, {'Bensín','Dísel','Kerósín'}')
legend()
title('Olíusala eftir geirum 2018')
ylabel('Olíusala í tonnum')
for i = 1:length(no)
    txt = [num2str(sum(no(i,:)),form),' tonn'];
    text(i,sum(no(i,:)),txt,'vert','bottom','horiz','center');
end
subplot(2,1,2)
g = bar(xx,y3,'stacked');
set(g,{'DisplayName'}, {'Rafmagn','Vetni'}')
legend()
ylabel('Raforka í GWh')
title('Raforkuþörf til að anna eftirspurn í sviðsmynd 3 (2018)')
for i = 1:length(y3)
    txt = [num2str(sum(y3(i,:)),form),' GWh'];
    text(i,sum(y3(i,:)),txt,'vert','bottom','horiz','center');
end
saveas(gcf,'orkugraf3.png')


%% 2020 tölur
fo = [2239472.95 1889527.349 0];% folk bensin svo disel svo kerosene
fl = [84690.35548 723123.7506 0];% flutnings bensin svo disel svo kerosene
sk = [0 2979511.111 0];
air = [0 0 1551600];
%https://www.samgongustofa.is/umferd/tolfraedi/onnur-tolfraedi/
rskip = (4729382.716)*10^3;% gildi voru reiknud i tonn þannig við bætum *10^3
rflug = (977508)*10^3;
rflut = (652460.4695+495355.0076+7900.970247+126528.1654)*10^3;
rheim = (3553341.796+2796917.066+1273.157078+56328.14687+104.0148014+146004.5484)*10^3;

raf_20 = [rheim;rflut;rflug;rskip]/(3.6*10^6);
not_20 = [fo;fl;air;sk];
subplot(2,1,1)
c = bar(xx,not_20,'stacked');
title('Olíusala eftir geirum 2020')
set(c,{'DisplayName'}, {'Bensín','Dísel','Kerósín'}')
legend()
ylabel('Orkusala í tonnum')
for i = 1:length(not_20)
    txt = [num2str(sum(not_20(i,:)),form),' tonn'];
    text(i,sum(not_20(i,:)),txt,'vert','bottom','horiz','center');
end
subplot(2,1,2)
s = bar(xx,raf_20);
set(s,{'DisplayName'}, {'Rafmagn'}')
legend()
ylabel('Raforka í GWh')
title('Raforkuþörf til að anna eftirspurn í sviðsmynd 1 (2020)')
for i = 1:length(raf_20)
    txt = [num2str(sum(raf_20(i)),form),' GWh'];
    text(i,raf_20(i),txt,'vert','bottom','horiz','center');
end
saveas(gcf,'orkugraf20.png')
%% 
% afl orkuveru https://orkustofnun.is/gogn/os-onnur-rit/Orkutolur-2019-islenska.pdf
% tokum afl 2018 án eldsneytisaflinu
MW = 2855;
GWh = (MW*60*60*24*365)/(3.6*10^6);




%% % heim>flut>flug>skip
% Búum til töflu sem fer svo í skjalið
yy2 = [y2(1) y2(2,3) y2(3,3) y2(4,2)];
yy3 = [y3(1,1) y3(2,1) y3(3,2) y3(4,1)];
r_fram = 19830; %GWh heildar raforkuvinnsla íslands 2018
r_fram20 = 19127; %GWh heildar raforkuvinnsly íslands 2020 
sv1 = [y1 sum(y1) sum(y1)/r_fram*100];
sv2 = [yy2 sum(yy2) sum(yy2)/r_fram*100];
sv3 = [yy3 sum(yy3) sum(yy3)/r_fram*100];

taf = [sv1;sv2;sv3];
