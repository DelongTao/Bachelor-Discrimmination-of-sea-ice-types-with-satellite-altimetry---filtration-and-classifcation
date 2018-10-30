%% Bachelorprojekt 2018: Discrimmination af is typer i Arktis ved satellit altimetri af AltiKa - filtrering og optimering
% Geofysik og rumteknologi, DTU Space
%
% This program retreats, plots and analyzes data from the altimeter AltiKa
% on board the SARAL-satellite. There will be a mainscript for each analyze
% of different days, since the files in need to be read are plentiful and
% different from each other. 
%
% There will be approximately filereads of 28 files pr. day. 
%
% Functions:        plottingSatelliteDataOverEarth   
%                   sortingWaveformLatitudeLongtitude
%                   calculatingParametersMPLEWTEW               
%                   calculatingStatisticsMPLEWTEW
%                   checkIfIce
%                   checkSurfacetype
%                   sortingAGCdata
%                   removingMPNotIce

%% AltiKa data import

% Set boundaries for geographic area
% Multiyear
% N1 = 80;
% N2 = 81.6;
% E1 = 360 - 135; % The values of min/max latitude longitude
% E2 = 360 - 110;

% Firstyear
% N1 = 78;
% N2 = 81.6;
% E1 = 120; % The values of min/max latitude longitude
% E2 = 150;

% All around
N1 = 60;
N2 = 90;
E1 = 0; 
E2 = 360;

filename = '27feb2015';

cd('D:\ALTIKA\2015\FEBRUAR'); % Change directory 

% 27. february 2015 

file1 = 'SRL_GPS_2PTP021_0424_20150227_001434_20150227_010453.CNES.nc'; 
file2 = 'SRL_GPS_2PTP021_0425_20150227_010453_20150227_015510.CNES.nc'; 
file3 = 'SRL_GPS_2PTP021_0426_20150227_015510_20150227_024529.CNES.nc'; 
file4 = 'SRL_GPS_2PTP021_0427_20150227_024529_20150227_033546.CNES.nc'; 
file5 = 'SRL_GPS_2PTP021_0428_20150227_033546_20150227_042604.CNES.nc'; 
file6 = 'SRL_GPS_2PTP021_0429_20150227_042604_20150227_051622.CNES.nc'; 
file7 = 'SRL_GPS_2PTP021_0430_20150227_051622_20150227_060640.CNES.nc'; 
file8 = 'SRL_GPS_2PTP021_0431_20150227_060640_20150227_065658.CNES.nc'; 
file9 = 'SRL_GPS_2PTP021_0432_20150227_065658_20150227_074716.CNES.nc'; 
file10 = 'SRL_GPS_2PTP021_0433_20150227_074716_20150227_083734.CNES.nc'; 
file11 = 'SRL_GPS_2PTP021_0434_20150227_083734_20150227_092752.CNES.nc'; 
file12 = 'SRL_GPS_2PTP021_0435_20150227_092752_20150227_101810.CNES.nc'; 
file13 = 'SRL_GPS_2PTP021_0436_20150227_101810_20150227_110828.CNES.nc'; 
file14 = 'SRL_GPS_2PTP021_0437_20150227_110828_20150227_115846.CNES.nc'; 
file15 = 'SRL_GPS_2PTP021_0438_20150227_115846_20150227_124904.CNES.nc'; 
file16 = 'SRL_GPS_2PTP021_0439_20150227_124904_20150227_133922.CNES.nc'; 
file17 = 'SRL_GPS_2PTP021_0440_20150227_133922_20150227_142940.CNES.nc'; 
file18 = 'SRL_GPS_2PTP021_0441_20150227_142940_20150227_151958.CNES.nc'; 
file19 = 'SRL_GPS_2PTP021_0442_20150227_151958_20150227_161016.CNES.nc'; 
file20 = 'SRL_GPS_2PTP021_0443_20150227_161016_20150227_170034.CNES.nc'; 
file21 = 'SRL_GPS_2PTP021_0444_20150227_170034_20150227_175052.CNES.nc'; 
file22 = 'SRL_GPS_2PTP021_0445_20150227_175052_20150227_184110.CNES.nc'; 
file23 = 'SRL_GPS_2PTP021_0446_20150227_184110_20150227_193128.CNES.nc'; 
file24 = 'SRL_GPS_2PTP021_0447_20150227_193128_20150227_202146.CNES.nc'; 
file25 = 'SRL_GPS_2PTP021_0448_20150227_202146_20150227_211204.CNES.nc'; 
file26 = 'SRL_GPS_2PTP021_0449_20150227_211204_20150227_220222.CNES.nc'; 
file27 = 'SRL_GPS_2PTP021_0450_20150227_220222_20150227_225240.CNES.nc'; 
file28 = 'SRL_GPS_2PTP021_0451_20150227_225240_20150227_234258.CNES.nc'; 
file29 = 'SRL_GPS_2PTP021_0452_20150227_234258_20150228_003316.CNES.nc'; 


% Show om parameters from the first file from AltiKa
% ncdisp(file1);

%% Loading parameters
% Load lon/lat data from different files
lon1 = ncread(file1,'lon'); lat1 = ncread(file1,'lat'); % Lon/lat datafil 1
lon2 = ncread(file2,'lon'); lat2 = ncread(file2,'lat'); % Lon/lat datafil 2
lon3 = ncread(file3, 'lon'); lat3 = ncread(file3, 'lat'); % Lon/lat datafil 3
lon4 = ncread(file4, 'lon'); lat4 = ncread(file4, 'lat'); % Lon/lat datafil 4
lon5 = ncread(file5, 'lon'); lat5 = ncread(file5, 'lat'); % Lon/lat datafil 5
lon6 = ncread(file6, 'lon'); lat6 = ncread(file6, 'lat'); % Lon/lat datafil 6
lon7 = ncread(file7, 'lon'); lat7 = ncread(file7, 'lat'); % Lon/lat datafil 7
lon8 = ncread(file8, 'lon'); lat8 = ncread(file8, 'lat'); % Lon/lat datafil 8
lon9 = ncread(file9, 'lon'); lat9 = ncread(file9, 'lat'); % Lon/lat datafil 9
lon10 = ncread(file10, 'lon'); lat10 = ncread(file10, 'lat'); % Lon/lat datafil 10
lon11 = ncread(file11, 'lon'); lat11 = ncread(file11, 'lat'); % Lon/lat datafil 11
lon12 = ncread(file12, 'lon'); lat12 = ncread(file12, 'lat'); % Lon/lat datafil 12
lon13 = ncread(file13, 'lon'); lat13 = ncread(file13, 'lat'); % Lon/lat datafil 13
lon14 = ncread(file14, 'lon'); lat14 = ncread(file14, 'lat'); % Lon/lat datafil 14
lon15 = ncread(file15, 'lon'); lat15 = ncread(file15, 'lat'); % Lon/lat datafil 15
lon16 = ncread(file16, 'lon'); lat16 = ncread(file16, 'lat'); % Lon/lat datafil 16
lon17 = ncread(file17, 'lon'); lat17 = ncread(file17, 'lat'); % Lon/lat datafil 17
lon18 = ncread(file18, 'lon'); lat18 = ncread(file18, 'lat'); % Lon/lat datafil 18
lon19 = ncread(file19, 'lon'); lat19 = ncread(file19, 'lat'); % Lon/lat datafil 19
lon20 = ncread(file20, 'lon'); lat20 = ncread(file20, 'lat'); % Lon/lat datafil 20
lon21 = ncread(file21, 'lon'); lat21 = ncread(file21, 'lat'); % Lon/lat datafil 21
lon22 = ncread(file22, 'lon'); lat22 = ncread(file22, 'lat'); % Lon/lat datafil 22
lon23 = ncread(file23, 'lon'); lat23 = ncread(file23, 'lat'); % Lon/lat datafil 23
lon24 = ncread(file24, 'lon'); lat24 = ncread(file24, 'lat'); % Lon/lat datafil 24
lon25 = ncread(file25, 'lon'); lat25 = ncread(file25, 'lat'); % Lon/lat datafil 25
lon26 = ncread(file26, 'lon'); lat26 = ncread(file26, 'lat'); % Lon/lat datafil 26
lon27 = ncread(file27, 'lon'); lat27 = ncread(file27, 'lat'); % Lon/lat datafil 27
lon28 = ncread(file28, 'lon'); lat28 = ncread(file28, 'lat'); % Lon/lat datafil 28
lon29 = ncread(file29, 'lon'); lat29 = ncread(file29, 'lat'); % Lon/lat datafil 29

% Retreat 40Hz lat and lon data
lat40Hz = ncread(file1, 'lat_40hz'); lon40Hz = ncread(file1, 'lon_40hz');
lat40Hz1 = ncread(file1, 'lat_40hz'); lon40Hz1 = ncread(file1, 'lon_40hz'); lat40Hz1 = reshape(lat40Hz1, [], 1); lon40Hz1 = reshape(lon40Hz1, [], 1);
lat40Hz2 = ncread(file2, 'lat_40hz'); lon40Hz2 = ncread(file2, 'lon_40hz'); lat40Hz2 = reshape(lat40Hz2, [], 1); lon40Hz2 = reshape(lon40Hz2, [], 1);
lat40Hz3 = ncread(file3, 'lat_40hz'); lon40Hz3 = ncread(file3, 'lon_40hz'); lat40Hz3 = reshape(lat40Hz3, [], 1); lon40Hz3 = reshape(lon40Hz3, [], 1);
lat40Hz4 = ncread(file4, 'lat_40hz'); lon40Hz4 = ncread(file4, 'lon_40hz'); lat40Hz4 = reshape(lat40Hz4, [], 1); lon40Hz4 = reshape(lon40Hz4, [], 1);
lat40Hz5 = ncread(file5, 'lat_40hz'); lon40Hz5 = ncread(file5, 'lon_40hz'); lat40Hz5 = reshape(lat40Hz5, [], 1); lon40Hz5 = reshape(lon40Hz5, [], 1);
lat40Hz6 = ncread(file6, 'lat_40hz'); lon40Hz6 = ncread(file6, 'lon_40hz'); lat40Hz6 = reshape(lat40Hz6, [], 1); lon40Hz6 = reshape(lon40Hz6, [], 1);
lat40Hz7 = ncread(file7, 'lat_40hz'); lon40Hz7 = ncread(file7, 'lon_40hz'); lat40Hz7 = reshape(lat40Hz7, [], 1); lon40Hz7 = reshape(lon40Hz7, [], 1);
lat40Hz8 = ncread(file8, 'lat_40hz'); lon40Hz8 = ncread(file8, 'lon_40hz'); lat40Hz8 = reshape(lat40Hz8, [], 1); lon40Hz8 = reshape(lon40Hz8, [], 1);
lat40Hz9 = ncread(file9, 'lat_40hz'); lon40Hz9 = ncread(file9, 'lon_40hz'); lat40Hz9 = reshape(lat40Hz9, [], 1); lon40Hz9 = reshape(lon40Hz9, [], 1);
lat40Hz10 = ncread(file10, 'lat_40hz'); lon40Hz10 = ncread(file10, 'lon_40hz'); lat40Hz10 = reshape(lat40Hz10, [], 1); lon40Hz10 = reshape(lon40Hz10, [], 1);
lat40Hz11 = ncread(file11, 'lat_40hz'); lon40Hz11 = ncread(file11, 'lon_40hz'); lat40Hz11 = reshape(lat40Hz11, [], 1); lon40Hz11 = reshape(lon40Hz11, [], 1);
lat40Hz12 = ncread(file12, 'lat_40hz'); lon40Hz12 = ncread(file12, 'lon_40hz'); lat40Hz12 = reshape(lat40Hz12, [], 1); lon40Hz12 = reshape(lon40Hz12, [], 1);
lat40Hz13 = ncread(file13, 'lat_40hz'); lon40Hz13 = ncread(file13, 'lon_40hz'); lat40Hz13 = reshape(lat40Hz13, [], 1); lon40Hz13 = reshape(lon40Hz13, [], 1);
lat40Hz14 = ncread(file14, 'lat_40hz'); lon40Hz14 = ncread(file14, 'lon_40hz'); lat40Hz14 = reshape(lat40Hz14, [], 1); lon40Hz14 = reshape(lon40Hz14, [], 1);
lat40Hz15 = ncread(file15, 'lat_40hz'); lon40Hz15 = ncread(file15, 'lon_40hz'); lat40Hz15 = reshape(lat40Hz15, [], 1); lon40Hz15 = reshape(lon40Hz15, [], 1);
lat40Hz16 = ncread(file16, 'lat_40hz'); lon40Hz16 = ncread(file16, 'lon_40hz'); lat40Hz16 = reshape(lat40Hz16, [], 1); lon40Hz16 = reshape(lon40Hz16, [], 1);
lat40Hz17 = ncread(file17, 'lat_40hz'); lon40Hz17 = ncread(file17, 'lon_40hz'); lat40Hz17 = reshape(lat40Hz17, [], 1); lon40Hz17 = reshape(lon40Hz17, [], 1);
lat40Hz18 = ncread(file18, 'lat_40hz'); lon40Hz18 = ncread(file18, 'lon_40hz'); lat40Hz18 = reshape(lat40Hz18, [], 1); lon40Hz18 = reshape(lon40Hz18, [], 1);
lat40Hz19 = ncread(file19, 'lat_40hz'); lon40Hz19 = ncread(file19, 'lon_40hz'); lat40Hz19 = reshape(lat40Hz19, [], 1); lon40Hz19 = reshape(lon40Hz19, [], 1);
lat40Hz20 = ncread(file20, 'lat_40hz'); lon40Hz20 = ncread(file20, 'lon_40hz'); lat40Hz20 = reshape(lat40Hz20, [], 1); lon40Hz20 = reshape(lon40Hz20, [], 1);
lat40Hz21 = ncread(file21, 'lat_40hz'); lon40Hz21 = ncread(file21, 'lon_40hz'); lat40Hz21 = reshape(lat40Hz21, [], 1); lon40Hz21 = reshape(lon40Hz21, [], 1);
lat40Hz22 = ncread(file22, 'lat_40hz'); lon40Hz22 = ncread(file22, 'lon_40hz'); lat40Hz22 = reshape(lat40Hz22, [], 1); lon40Hz22 = reshape(lon40Hz22, [], 1);
lat40Hz23 = ncread(file23, 'lat_40hz'); lon40Hz23 = ncread(file23, 'lon_40hz'); lat40Hz23 = reshape(lat40Hz23, [], 1); lon40Hz23 = reshape(lon40Hz23, [], 1);
lat40Hz24 = ncread(file24, 'lat_40hz'); lon40Hz24 = ncread(file24, 'lon_40hz'); lat40Hz24 = reshape(lat40Hz24, [], 1); lon40Hz24 = reshape(lon40Hz24, [], 1);
lat40Hz25 = ncread(file25, 'lat_40hz'); lon40Hz25 = ncread(file25, 'lon_40hz'); lat40Hz25 = reshape(lat40Hz25, [], 1); lon40Hz25 = reshape(lon40Hz25, [], 1);
lat40Hz26 = ncread(file26, 'lat_40hz'); lon40Hz26 = ncread(file26, 'lon_40hz'); lat40Hz26 = reshape(lat40Hz26, [], 1); lon40Hz26 = reshape(lon40Hz26, [], 1);
lat40Hz27 = ncread(file27, 'lat_40hz'); lon40Hz27 = ncread(file27, 'lon_40hz'); lat40Hz27 = reshape(lat40Hz27, [], 1); lon40Hz27 = reshape(lon40Hz27, [], 1);
lat40Hz28 = ncread(file28, 'lat_40hz'); lon40Hz28 = ncread(file28, 'lon_40hz'); lat40Hz28 = reshape(lat40Hz28, [], 1); lon40Hz28 = reshape(lon40Hz28, [], 1);
lat40Hz29 = ncread(file29, 'lat_40hz'); lon40Hz29 = ncread(file29, 'lon_40hz'); lat40Hz29 = reshape(lat40Hz29, [], 1); lon40Hz29 = reshape(lon40Hz29, [], 1);


% Retreat 40 Hz waveform data
data1 = ncread(file1, 'waveforms_40hz'); data2 = ncread(file2, 'waveforms_40hz'); 
data3 = ncread(file3, 'waveforms_40hz'); data4 = ncread(file4, 'waveforms_40hz'); data5 = ncread(file5, 'waveforms_40hz'); 
data6 = ncread(file6, 'waveforms_40hz'); data7 = ncread(file7, 'waveforms_40hz'); data8 = ncread(file8, 'waveforms_40hz');
data9 = ncread(file9, 'waveforms_40hz'); data10 = ncread(file10, 'waveforms_40hz'); data11 = ncread(file11, 'waveforms_40hz');
data12 = ncread(file12, 'waveforms_40hz'); data13 = ncread(file13, 'waveforms_40hz'); data14 = ncread(file14, 'waveforms_40hz');
data15 = ncread(file15, 'waveforms_40hz'); data16 = ncread(file16, 'waveforms_40hz'); data17 = ncread(file17, 'waveforms_40hz');
data18 = ncread(file18, 'waveforms_40hz'); data19 = ncread(file19, 'waveforms_40hz'); data20 = ncread(file20, 'waveforms_40hz');
data21 = ncread(file21, 'waveforms_40hz'); data22 = ncread(file22, 'waveforms_40hz'); data23 = ncread(file23, 'waveforms_40hz');
data24 = ncread(file24, 'waveforms_40hz'); data25 = ncread(file25, 'waveforms_40hz'); data26 = ncread(file26, 'waveforms_40hz');
data27 = ncread(file27, 'waveforms_40hz'); data28 = ncread(file28, 'waveforms_40hz'); data29 = ncread(file29, 'waveforms_40hz');

% Retreat ice_flag data 
icedata1 = ncread(file1, 'ice_flag'); icedata2 = ncread(file2, 'ice_flag'); 
icedata3 = ncread(file3, 'ice_flag'); icedata4 = ncread(file4, 'ice_flag'); icedata5 = ncread(file5, 'ice_flag'); 
icedata6 = ncread(file6, 'ice_flag'); icedata7 = ncread(file7, 'ice_flag'); icedata8 = ncread(file8, 'ice_flag');
icedata9 = ncread(file9, 'ice_flag'); icedata10 = ncread(file10, 'ice_flag'); icedata11 = ncread(file11, 'ice_flag');
icedata12 = ncread(file12, 'ice_flag'); icedata13 = ncread(file13, 'ice_flag'); icedata14 = ncread(file14, 'ice_flag');
icedata15 = ncread(file15, 'ice_flag'); icedata16 = ncread(file16, 'ice_flag'); icedata17 = ncread(file17, 'ice_flag');
icedata18 = ncread(file18, 'ice_flag'); icedata19 = ncread(file19, 'ice_flag'); icedata20 = ncread(file20, 'ice_flag');
icedata21 = ncread(file21, 'ice_flag'); icedata22 = ncread(file22, 'ice_flag'); icedata23 = ncread(file23, 'ice_flag');
icedata24 = ncread(file24, 'ice_flag'); icedata25 = ncread(file25, 'ice_flag'); icedata26 = ncread(file26, 'ice_flag');
icedata27 = ncread(file27, 'ice_flag'); icedata28 = ncread(file28, 'ice_flag'); icedata29 = ncread(file29, 'ice_flag');

% Retreat surfacetype data 
surface1 = ncread(file1, 'surface_type'); surface2 = ncread(file2, 'surface_type'); 
surface3 = ncread(file3, 'surface_type'); surface4 = ncread(file4, 'surface_type'); surface5 = ncread(file5, 'surface_type'); 
surface6 = ncread(file6, 'surface_type'); surface7 = ncread(file7, 'surface_type'); surface8 = ncread(file8, 'surface_type');
surface9 = ncread(file9, 'surface_type'); surface10 = ncread(file10, 'surface_type'); surface11 = ncread(file11, 'surface_type');
surface12 = ncread(file12, 'surface_type'); surface13 = ncread(file13, 'surface_type'); surface14 = ncread(file14, 'surface_type');
surface15 = ncread(file15, 'surface_type'); surface16 = ncread(file16, 'surface_type'); surface17 = ncread(file17, 'surface_type');
surface18 = ncread(file18, 'surface_type'); surface19 = ncread(file19, 'surface_type'); surface20 = ncread(file20, 'surface_type');
surface21 = ncread(file21, 'surface_type'); surface22 = ncread(file22, 'surface_type'); surface23 = ncread(file23, 'surface_type');
surface24 = ncread(file24, 'surface_type'); surface25 = ncread(file25, 'surface_type'); surface26 = ncread(file26, 'surface_type');
surface27 = ncread(file27, 'surface_type'); surface28 = ncread(file28, 'surface_type'); surface29 = ncread(file29, 'surface_type');

% AGC value 
AGC1 = ncread(file1, 'agc_40hz'); AGC40Hz1 = reshape(AGC1, [], 1);
AGC2 = ncread(file2, 'agc_40hz'); AGC40Hz2 = reshape(AGC2, [], 1);
AGC3 = ncread(file3, 'agc_40hz'); AGC40Hz3 = reshape(AGC3, [], 1);
AGC4 = ncread(file4, 'agc_40hz'); AGC40Hz4 = reshape(AGC4, [], 1);
AGC5 = ncread(file5, 'agc_40hz'); AGC40Hz5 = reshape(AGC5, [], 1);
AGC6 = ncread(file6, 'agc_40hz'); AGC40Hz6 = reshape(AGC6, [], 1);
AGC7 = ncread(file7, 'agc_40hz'); AGC40Hz7 = reshape(AGC7, [], 1);
AGC8 = ncread(file8, 'agc_40hz'); AGC40Hz8 = reshape(AGC8, [], 1);
AGC9 = ncread(file9, 'agc_40hz'); AGC40Hz9 = reshape(AGC9, [], 1);
AGC10 = ncread(file10, 'agc_40hz'); AGC40Hz10 = reshape(AGC10, [], 1);
AGC11 = ncread(file11, 'agc_40hz'); AGC40Hz11 = reshape(AGC11, [], 1);
AGC12 = ncread(file12, 'agc_40hz'); AGC40Hz12 = reshape(AGC12, [], 1);
AGC13 = ncread(file13, 'agc_40hz'); AGC40Hz13 = reshape(AGC13, [], 1);
AGC14 = ncread(file14, 'agc_40hz'); AGC40Hz14 = reshape(AGC14, [], 1);
AGC15 = ncread(file15, 'agc_40hz'); AGC40Hz15 = reshape(AGC15, [], 1);
AGC16 = ncread(file16, 'agc_40hz'); AGC40Hz16 = reshape(AGC16, [], 1);
AGC17 = ncread(file17, 'agc_40hz'); AGC40Hz17 = reshape(AGC17, [], 1);
AGC18 = ncread(file18, 'agc_40hz'); AGC40Hz18 = reshape(AGC18, [], 1);
AGC19 = ncread(file19, 'agc_40hz'); AGC40Hz19 = reshape(AGC19, [], 1);
AGC20 = ncread(file20, 'agc_40hz'); AGC40Hz20 = reshape(AGC20, [], 1);
AGC21 = ncread(file21, 'agc_40hz'); AGC40Hz21 = reshape(AGC21, [], 1);
AGC22 = ncread(file22, 'agc_40hz'); AGC40Hz22 = reshape(AGC22, [], 1);
AGC23 = ncread(file23, 'agc_40hz'); AGC40Hz23 = reshape(AGC23, [], 1);
AGC24 = ncread(file24, 'agc_40hz'); AGC40Hz24 = reshape(AGC24, [], 1);
AGC25 = ncread(file25, 'agc_40hz'); AGC40Hz25 = reshape(AGC25, [], 1);
AGC26 = ncread(file26, 'agc_40hz'); AGC40Hz26 = reshape(AGC26, [], 1);
AGC27 = ncread(file27, 'agc_40hz'); AGC40Hz27 = reshape(AGC27, [], 1);
AGC28 = ncread(file28, 'agc_40hz'); AGC40Hz28 = reshape(AGC28, [], 1);
AGC29 = ncread(file29, 'agc_40hz'); AGC40Hz29 = reshape(AGC29, [], 1);

%% Analyze

% Transforming the 2858x1 to a 1x2858 vectors
lat1 = lat1'; lon1 = lon1'; lat2 = lat2';lon2 = lon2';lat3 = lat3';lon3 = lon3';lat4 = lat4';
lon4 = lon4'; lon5 = lon5'; lat5 = lat5'; lon6 = lon6'; lat6 = lat6'; lon7 = lon7'; lat7 = lat7';
lat8 = lat8'; lon8 = lon8'; lat9 = lat9'; lon9 = lon9'; lat10 = lat10'; lon10 = lon10'; lat11 = lat11';
lon11 = lon11'; lat12 = lat12'; lon12 = lon12'; lat13 = lat13'; lon13 = lon13'; lat14 = lat14'; lon14 = lon14';
lat15 = lat15'; lon15 = lon15'; lat16 = lat16'; lon16 = lon16'; lat17 = lat17'; lon17 = lon17'; lat18 = lat18'; 
lon18 = lon18'; lat19 = lat19'; lon19 = lon19'; lat20 = lat20'; lon20 = lon20'; lat21 = lat21'; lon21 = lon21';
lat22 = lat22'; lon22 = lon22'; lat23 = lat23'; lon23 = lon23'; lat24 = lat24'; lon24 = lon24'; lat25 = lat25'; 
lon25 = lon25'; lat26 = lat26'; lon26 = lon26'; lat27 = lat27'; lon27 = lon27'; lat28 = lat28'; lon28 = lon28';
lat29 = lat29'; lon29 = lon29';

 % Functions - first analysis
 plottingSatelliteDataOverEarth(lat1, lon1, lat2, lon2, lat3, lon3, lat4, lon4, lat5, lon5, lat6, lon6, lat7, lon7, lat8, lon8, lat9, lon9, lat10, lon10, lat11, lon11, lat12, lon12, lat13, lon13, lat14, lon14, lat15, lon15, lat16, lon16, lat17, lon17, lat18, lon18, lat19, lon19, lat20, lon20, lat21, lon21, lat22, lon22, lat23, lon23, lat24, lon24, lat25, lon25, lat26, lon26, lat27, lon27, lat28, lon28, lat29, lon29)
 [latlonwav] = sortingWaveformLatitudeLongtitude(N1, N2, E1, E2, lat40Hz1, lon40Hz1, data1, lat40Hz2, lon40Hz2, data2, lat40Hz3, lon40Hz3, data3, lat40Hz4, lon40Hz4, data4, lat40Hz5, lon40Hz5, data5, lat40Hz6, lon40Hz6, data6, lat40Hz7, lon40Hz7, data7, lat40Hz8, lon40Hz8, data8, lat40Hz9, lon40Hz9, data9, lat40Hz10, lon40Hz10, data10, lat40Hz11, lon40Hz11, data11, lat40Hz12, lon40Hz12, data12, lat40Hz13, lon40Hz13, data13, lat40Hz14, lon40Hz14, data14, lat40Hz15, lon40Hz15, data15, lat40Hz16, lon40Hz16, data16, lat40Hz17, lon40Hz17, data17, lat40Hz18, lon40Hz18, data18, lat40Hz19, lon40Hz19, data19,lat40Hz20, lon40Hz20, data20, lat40Hz21, lon40Hz21, data21, lat40Hz22, lon40Hz22, data22, lat40Hz23, lon40Hz23, data23, lat40Hz24, lon40Hz24, data24, lat40Hz25, lon40Hz25, data25, lat40Hz26, lon40Hz26, data26, lat40Hz27, lon40Hz27, data27, lat40Hz28, lon40Hz28, data28, lat40Hz29, lon40Hz29, data29);
 [AGCvalue] = sortingAGCdata(N1, N2, E1, E2, lat40Hz1, lon40Hz1, AGC40Hz1,lat40Hz2, lon40Hz2, AGC40Hz2, lat40Hz3, lon40Hz3, AGC40Hz3, lat40Hz4, lon40Hz4, AGC40Hz4, lat40Hz5, lon40Hz5, AGC40Hz5, lat40Hz6, lon40Hz6, AGC40Hz6, lat40Hz7, lon40Hz7, AGC40Hz7,lat40Hz8, lon40Hz8, AGC40Hz8, lat40Hz9, lon40Hz9, AGC40Hz9, lat40Hz10, lon40Hz10, AGC40Hz10, lat40Hz11, lon40Hz11, AGC40Hz11, lat40Hz12, lon40Hz12, AGC40Hz12, lat40Hz13, lon40Hz13, AGC40Hz13, lat40Hz14, lon40Hz14, AGC40Hz14, lat40Hz15, lon40Hz15, AGC40Hz15, lat40Hz16, lon40Hz16, AGC40Hz16, lat40Hz17, lon40Hz17, AGC40Hz17, lat40Hz18, lon40Hz18, AGC40Hz18, lat40Hz19, lon40Hz19, AGC40Hz19, lat40Hz20, lon40Hz20, AGC40Hz20, lat40Hz21, lon40Hz21, AGC40Hz21, lat40Hz22, lon40Hz22, AGC40Hz22, lat40Hz23, lon40Hz23, AGC40Hz23, lat40Hz24, lon40Hz24, AGC40Hz24, lat40Hz25, lon40Hz25, AGC40Hz25, lat40Hz26, lon40Hz26, AGC40Hz26, lat40Hz27, lon40Hz27, AGC40Hz27, lat40Hz28, lon40Hz28, AGC40Hz28, lat40Hz29, lon40Hz29, AGC40Hz29); 
 [doneMATRIX, wav, correctMP, newMatrix, matrix] = calculatingParametersMPLEWTEW(latlonwav, AGCvalue);
 calculatingStatisticsMPLEWTEW(doneMATRIX, wav, correctMP);
 [iceDoneMatrix] = checkIfIce(N1, N2, E1, E2, lat1, lon1, lat2, lon2, lat3, lon3, lat4, lon4, lat5, lon5, lat6, lon6, lat7, lon7, lat8, lon8, lat9, lon9, lat10, lon10, lat11, lon11, lat12, lon12, lat13, lon13, lat14, lon14, lat15, lon15, lat16, lon16, lat17, lon17, lat18, lon18, lat19, lon19, lat20, lon20, lat21, lon21, lat22, lon22, lat23, lon23, lat24, lon24, lat25, lon25, lat26, lon26, lat27, lon27, lat28, lon28, lat29, lon29, icedata1, icedata2, icedata3, icedata4, icedata5, icedata6, icedata7, icedata8, icedata9, icedata10, icedata11, icedata12, icedata13, icedata14, icedata15, icedata16, icedata17, icedata18, icedata19, icedata20, icedata21, icedata22, icedata23, icedata24, icedata25, icedata26, icedata27, icedata28, icedata29);
 [minN, maxN, minE, maxE, allData] = checkSurfacetype(iceDoneMatrix, N1, N2, E1, E2, lat1, lon1, lat2, lon2, lat3, lon3, lat4, lon4, lat5, lon5, lat6, lon6, lat7, lon7, lat8, lon8, lat9, lon9, lat10, lon10, lat11, lon11, lat12, lon12, lat13, lon13, lat14, lon14, lat15, lon15, lat16, lon16, lat17, lon17, lat18, lon18, lat19, lon19, lat20, lon20, lat21, lon21, lat22, lon22, lat23, lon23, lat24, lon24, lat25, lon25, lat26, lon26, lat27, lon27, lat28, lon28, lat29, lon29, surface1, surface2, surface3, surface4, surface5, surface6, surface7, surface8, surface9, surface10, surface11, surface12, surface13, surface14, surface15, surface16, surface17, surface18, surface19, surface20, surface21, surface22, surface23, surface24, surface25, surface26, surface27, surface28, surface29);
 
 fprintf('New values for latitude/longitude: minN = %d, maxN = %d, minE = %d, maxE = %d\n', minN, maxN, minE, maxE);
 
% Second go 
 [latlonwav] = sortingWaveformLatitudeLongtitude(minN, maxN, minE, maxE, lat40Hz1, lon40Hz1, data1, lat40Hz2, lon40Hz2, data2, lat40Hz3, lon40Hz3, data3, lat40Hz4, lon40Hz4, data4, lat40Hz5, lon40Hz5, data5, lat40Hz6, lon40Hz6, data6, lat40Hz7, lon40Hz7, data7, lat40Hz8, lon40Hz8, data8, lat40Hz9, lon40Hz9, data9, lat40Hz10, lon40Hz10, data10, lat40Hz11, lon40Hz11, data11, lat40Hz12, lon40Hz12, data12, lat40Hz13, lon40Hz13, data13, lat40Hz14, lon40Hz14, data14, lat40Hz15, lon40Hz15, data15, lat40Hz16, lon40Hz16, data16, lat40Hz17, lon40Hz17, data17, lat40Hz18, lon40Hz18, data18, lat40Hz19, lon40Hz19, data19,lat40Hz20, lon40Hz20, data20, lat40Hz21, lon40Hz21, data21, lat40Hz22, lon40Hz22, data22, lat40Hz23, lon40Hz23, data23, lat40Hz24, lon40Hz24, data24, lat40Hz25, lon40Hz25, data25, lat40Hz26, lon40Hz26, data26, lat40Hz27, lon40Hz27, data27, lat40Hz28, lon40Hz28, data28, lat40Hz29, lon40Hz29, data29);
 [AGCvalue] = sortingAGCdata(minN, maxN, minE, maxE, lat40Hz1, lon40Hz1, AGC40Hz1,lat40Hz2, lon40Hz2, AGC40Hz2, lat40Hz3, lon40Hz3, AGC40Hz3, lat40Hz4, lon40Hz4, AGC40Hz4, lat40Hz5, lon40Hz5, AGC40Hz5, lat40Hz6, lon40Hz6, AGC40Hz6, lat40Hz7, lon40Hz7, AGC40Hz7,lat40Hz8, lon40Hz8, AGC40Hz8, lat40Hz9, lon40Hz9, AGC40Hz9, lat40Hz10, lon40Hz10, AGC40Hz10, lat40Hz11, lon40Hz11, AGC40Hz11, lat40Hz12, lon40Hz12, AGC40Hz12, lat40Hz13, lon40Hz13, AGC40Hz13, lat40Hz14, lon40Hz14, AGC40Hz14, lat40Hz15, lon40Hz15, AGC40Hz15, lat40Hz16, lon40Hz16, AGC40Hz16, lat40Hz17, lon40Hz17, AGC40Hz17, lat40Hz18, lon40Hz18, AGC40Hz18, lat40Hz19, lon40Hz19, AGC40Hz19, lat40Hz20, lon40Hz20, AGC40Hz20, lat40Hz21, lon40Hz21, AGC40Hz21, lat40Hz22, lon40Hz22, AGC40Hz22, lat40Hz23, lon40Hz23, AGC40Hz23, lat40Hz24, lon40Hz24, AGC40Hz24, lat40Hz25, lon40Hz25, AGC40Hz25, lat40Hz26, lon40Hz26, AGC40Hz26, lat40Hz27, lon40Hz27, AGC40Hz27, lat40Hz28, lon40Hz28, AGC40Hz28, lat40Hz29, lon40Hz29, AGC40Hz29); 
 [doneMATRIX, wav, correctMP, newmatrix, matrix] = calculatingParametersMPLEWTEW(latlonwav, AGCvalue);
 calculatingStatisticsMPLEWTEW(doneMATRIX, wav, correctMP);

% Functions - second analysis

[latlonwav] = sortingWaveformLatitudeLongtitude(N1, N2, E1, E2, lat40Hz1, lon40Hz1, data1, lat40Hz2, lon40Hz2, data2, lat40Hz3, lon40Hz3, data3, lat40Hz4, lon40Hz4, data4, lat40Hz5, lon40Hz5, data5, lat40Hz6, lon40Hz6, data6, lat40Hz7, lon40Hz7, data7, lat40Hz8, lon40Hz8, data8, lat40Hz9, lon40Hz9, data9, lat40Hz10, lon40Hz10, data10, lat40Hz11, lon40Hz11, data11, lat40Hz12, lon40Hz12, data12, lat40Hz13, lon40Hz13, data13, lat40Hz14, lon40Hz14, data14, lat40Hz15, lon40Hz15, data15, lat40Hz16, lon40Hz16, data16, lat40Hz17, lon40Hz17, data17, lat40Hz18, lon40Hz18, data18, lat40Hz19, lon40Hz19, data19,lat40Hz20, lon40Hz20, data20, lat40Hz21, lon40Hz21, data21, lat40Hz22, lon40Hz22, data22, lat40Hz23, lon40Hz23, data23, lat40Hz24, lon40Hz24, data24, lat40Hz25, lon40Hz25, data25, lat40Hz26, lon40Hz26, data26, lat40Hz27, lon40Hz27, data27, lat40Hz28, lon40Hz28, data28, lat40Hz29, lon40Hz29, data29);
[AGCvalue] = sortingAGCdata(N1, N2, E1, E2, lat40Hz1, lon40Hz1, AGC40Hz1,lat40Hz2, lon40Hz2, AGC40Hz2, lat40Hz3, lon40Hz3, AGC40Hz3, lat40Hz4, lon40Hz4, AGC40Hz4, lat40Hz5, lon40Hz5, AGC40Hz5, lat40Hz6, lon40Hz6, AGC40Hz6, lat40Hz7, lon40Hz7, AGC40Hz7,lat40Hz8, lon40Hz8, AGC40Hz8, lat40Hz9, lon40Hz9, AGC40Hz9, lat40Hz10, lon40Hz10, AGC40Hz10, lat40Hz11, lon40Hz11, AGC40Hz11, lat40Hz12, lon40Hz12, AGC40Hz12, lat40Hz13, lon40Hz13, AGC40Hz13, lat40Hz14, lon40Hz14, AGC40Hz14, lat40Hz15, lon40Hz15, AGC40Hz15, lat40Hz16, lon40Hz16, AGC40Hz16, lat40Hz17, lon40Hz17, AGC40Hz17, lat40Hz18, lon40Hz18, AGC40Hz18, lat40Hz19, lon40Hz19, AGC40Hz19, lat40Hz20, lon40Hz20, AGC40Hz20, lat40Hz21, lon40Hz21, AGC40Hz21, lat40Hz22, lon40Hz22, AGC40Hz22, lat40Hz23, lon40Hz23, AGC40Hz23, lat40Hz24, lon40Hz24, AGC40Hz24, lat40Hz25, lon40Hz25, AGC40Hz25, lat40Hz26, lon40Hz26, AGC40Hz26, lat40Hz27, lon40Hz27, AGC40Hz27, lat40Hz28, lon40Hz28, AGC40Hz28, lat40Hz29, lon40Hz29, AGC40Hz29); 
 [doneMATRIX, wav, correctMP, newMatrix, matrix] = calculatingParametersMPLEWTEW(latlonwav, AGCvalue);
 calculatingStatisticsMPLEWTEW(doneMATRIX, wav, correctMP);
 [iceDoneMatrix] = checkIfIce(N1, N2, E1, E2, lat1, lon1, lat2, lon2, lat3, lon3, lat4, lon4, lat5, lon5, lat6, lon6, lat7, lon7, lat8, lon8, lat9, lon9, lat10, lon10, lat11, lon11, lat12, lon12, lat13, lon13, lat14, lon14, lat15, lon15, lat16, lon16, lat17, lon17, lat18, lon18, lat19, lon19, lat20, lon20, lat21, lon21, lat22, lon22, lat23, lon23, lat24, lon24, lat25, lon25, lat26, lon26, lat27, lon27, lat28, lon28, lat29, lon29, icedata1, icedata2, icedata3, icedata4, icedata5, icedata6, icedata7, icedata8, icedata9, icedata10, icedata11, icedata12, icedata13, icedata14, icedata15, icedata16, icedata17, icedata18, icedata19, icedata20, icedata21, icedata22, icedata23, icedata24, icedata25, icedata26, icedata27, icedata28, icedata29);
 [minN, maxN, minE, maxE, allData] = checkSurfacetype(iceDoneMatrix, N1, N2, E1, E2, lat1, lon1, lat2, lon2, lat3, lon3, lat4, lon4, lat5, lon5, lat6, lon6, lat7, lon7, lat8, lon8, lat9, lon9, lat10, lon10, lat11, lon11, lat12, lon12, lat13, lon13, lat14, lon14, lat15, lon15, lat16, lon16, lat17, lon17, lat18, lon18, lat19, lon19, lat20, lon20, lat21, lon21, lat22, lon22, lat23, lon23, lat24, lon24, lat25, lon25, lat26, lon26, lat27, lon27, lat28, lon28, lat29, lon29, surface1, surface2, surface3, surface4, surface5, surface6, surface7, surface8, surface9, surface10, surface11, surface12, surface13, surface14, surface15, surface16, surface17, surface18, surface19, surface20, surface21, surface22, surface23, surface24, surface25, surface26, surface27, surface28, surface29);
 fprintf('New values for latitude/longitude: minN = %d, maxN = %d, minE = %d, maxE = %d\n', minN, maxN, minE, maxE);
 
 % Second go 
 [latlonwav] = sortingWaveformLatitudeLongtitude(minN, maxN, minE, maxE, lat40Hz1, lon40Hz1, data1, lat40Hz2, lon40Hz2, data2, lat40Hz3, lon40Hz3, data3, lat40Hz4, lon40Hz4, data4, lat40Hz5, lon40Hz5, data5, lat40Hz6, lon40Hz6, data6, lat40Hz7, lon40Hz7, data7, lat40Hz8, lon40Hz8, data8, lat40Hz9, lon40Hz9, data9, lat40Hz10, lon40Hz10, data10, lat40Hz11, lon40Hz11, data11, lat40Hz12, lon40Hz12, data12, lat40Hz13, lon40Hz13, data13, lat40Hz14, lon40Hz14, data14, lat40Hz15, lon40Hz15, data15, lat40Hz16, lon40Hz16, data16, lat40Hz17, lon40Hz17, data17, lat40Hz18, lon40Hz18, data18, lat40Hz19, lon40Hz19, data19,lat40Hz20, lon40Hz20, data20, lat40Hz21, lon40Hz21, data21, lat40Hz22, lon40Hz22, data22, lat40Hz23, lon40Hz23, data23, lat40Hz24, lon40Hz24, data24, lat40Hz25, lon40Hz25, data25, lat40Hz26, lon40Hz26, data26, lat40Hz27, lon40Hz27, data27, lat40Hz28, lon40Hz28, data28, lat40Hz29, lon40Hz29, data29);
 [AGCvalue] = sortingAGCdata(minN, maxN, minE, maxE, lat40Hz1, lon40Hz1, AGC40Hz1,lat40Hz2, lon40Hz2, AGC40Hz2, lat40Hz3, lon40Hz3, AGC40Hz3, lat40Hz4, lon40Hz4, AGC40Hz4, lat40Hz5, lon40Hz5, AGC40Hz5, lat40Hz6, lon40Hz6, AGC40Hz6, lat40Hz7, lon40Hz7, AGC40Hz7,lat40Hz8, lon40Hz8, AGC40Hz8, lat40Hz9, lon40Hz9, AGC40Hz9, lat40Hz10, lon40Hz10, AGC40Hz10, lat40Hz11, lon40Hz11, AGC40Hz11, lat40Hz12, lon40Hz12, AGC40Hz12, lat40Hz13, lon40Hz13, AGC40Hz13, lat40Hz14, lon40Hz14, AGC40Hz14, lat40Hz15, lon40Hz15, AGC40Hz15, lat40Hz16, lon40Hz16, AGC40Hz16, lat40Hz17, lon40Hz17, AGC40Hz17, lat40Hz18, lon40Hz18, AGC40Hz18, lat40Hz19, lon40Hz19, AGC40Hz19, lat40Hz20, lon40Hz20, AGC40Hz20, lat40Hz21, lon40Hz21, AGC40Hz21, lat40Hz22, lon40Hz22, AGC40Hz22, lat40Hz23, lon40Hz23, AGC40Hz23, lat40Hz24, lon40Hz24, AGC40Hz24, lat40Hz25, lon40Hz25, AGC40Hz25, lat40Hz26, lon40Hz26, AGC40Hz26, lat40Hz27, lon40Hz27, AGC40Hz27, lat40Hz28, lon40Hz28, AGC40Hz28, lat40Hz29, lon40Hz29, AGC40Hz29); 
 [doneMATRIX, wav, correctMP, newmatrix, matrix] = calculatingParametersMPLEWTEW(latlonwav, AGCvalue);
 calculatingStatisticsMPLEWTEW(doneMATRIX, wav, correctMP);
 [modeMP, min, max, doneMATRIX2] = calculatingStatistics(doneMATRIX);
 [one, two, three] = sortedDiscrimimnation(doneMATRIX2, filename);

% Visualazation preparing

[latlonwav] = sortingWaveformLatitudeLongtitude(N1, N2, E1, E2, lat40Hz1, lon40Hz1, data1, lat40Hz2, lon40Hz2, data2, lat40Hz3, lon40Hz3, data3, lat40Hz4, lon40Hz4, data4, lat40Hz5, lon40Hz5, data5, lat40Hz6, lon40Hz6, data6, lat40Hz7, lon40Hz7, data7, lat40Hz8, lon40Hz8, data8, lat40Hz9, lon40Hz9, data9, lat40Hz10, lon40Hz10, data10, lat40Hz11, lon40Hz11, data11, lat40Hz12, lon40Hz12, data12, lat40Hz13, lon40Hz13, data13, lat40Hz14, lon40Hz14, data14, lat40Hz15, lon40Hz15, data15, lat40Hz16, lon40Hz16, data16, lat40Hz17, lon40Hz17, data17, lat40Hz18, lon40Hz18, data18, lat40Hz19, lon40Hz19, data19,lat40Hz20, lon40Hz20, data20, lat40Hz21, lon40Hz21, data21, lat40Hz22, lon40Hz22, data22, lat40Hz23, lon40Hz23, data23, lat40Hz24, lon40Hz24, data24, lat40Hz25, lon40Hz25, data25, lat40Hz26, lon40Hz26, data26, lat40Hz27, lon40Hz27, data27, lat40Hz28, lon40Hz28, data28, lat40Hz29, lon40Hz29, data29);
[AGCvalue] = sortingAGCdata(N1, N2, E1, E2, lat40Hz1, lon40Hz1, AGC40Hz1,lat40Hz2, lon40Hz2, AGC40Hz2, lat40Hz3, lon40Hz3, AGC40Hz3, lat40Hz4, lon40Hz4, AGC40Hz4, lat40Hz5, lon40Hz5, AGC40Hz5, lat40Hz6, lon40Hz6, AGC40Hz6, lat40Hz7, lon40Hz7, AGC40Hz7,lat40Hz8, lon40Hz8, AGC40Hz8, lat40Hz9, lon40Hz9, AGC40Hz9, lat40Hz10, lon40Hz10, AGC40Hz10, lat40Hz11, lon40Hz11, AGC40Hz11, lat40Hz12, lon40Hz12, AGC40Hz12, lat40Hz13, lon40Hz13, AGC40Hz13, lat40Hz14, lon40Hz14, AGC40Hz14, lat40Hz15, lon40Hz15, AGC40Hz15, lat40Hz16, lon40Hz16, AGC40Hz16, lat40Hz17, lon40Hz17, AGC40Hz17, lat40Hz18, lon40Hz18, AGC40Hz18, lat40Hz19, lon40Hz19, AGC40Hz19, lat40Hz20, lon40Hz20, AGC40Hz20, lat40Hz21, lon40Hz21, AGC40Hz21, lat40Hz22, lon40Hz22, AGC40Hz22, lat40Hz23, lon40Hz23, AGC40Hz23, lat40Hz24, lon40Hz24, AGC40Hz24, lat40Hz25, lon40Hz25, AGC40Hz25, lat40Hz26, lon40Hz26, AGC40Hz26, lat40Hz27, lon40Hz27, AGC40Hz27, lat40Hz28, lon40Hz28, AGC40Hz28, lat40Hz29, lon40Hz29, AGC40Hz29); 
[doneMATRIX, wav, correctMP, newMatrix, matrix] = calculatingParametersMPLEWTEW(latlonwav, AGCvalue);
[modeMP, min, max, doneMATRIX2] = calculatingStatistics(doneMATRIX);
[one, two, three] = sortedDiscrimimnation(doneMATRIX2, filename);

disp('The program is finished and will terminate.');
\end{lstlisting}
\newpage

\chapter{MATLAB mainscript for visualization}
\begin{lstlisting}
% Mainscript for visualization

addpath('C:\Program Files\MATLAB\R2016a\toolbox\matlab\m_map',...
'C:\Users\renee\OneDrive\Bachelorprojekt\Visual');


file1 = importdata('01feb2015');
file2 = importdata('02feb2015');
file3 = importdata('03feb2015');
file4 = importdata('04feb2015');
file5 = importdata('05feb2015');
file6 = importdata('06feb2015');
file7 = importdata('07feb2015');
file8 = importdata('08feb2015');
file9 = importdata('09feb2015');
file10 = importdata('10feb2015');
file11 = importdata('11feb2015');
file12 = importdata('12feb2015');
file13 = importdata('13feb2015');
file14 = importdata('14feb2015');
file15 = importdata('15feb2015');
file16 = importdata('16feb2015');
file17 = importdata('17feb2015');
file18 = importdata('18feb2015');
file19 = importdata('19feb2015');
file20 = importdata('20feb2015');
file21 = importdata('21feb2015');
file22 = importdata('22feb2015');
file23 = importdata('23feb2015');
file24 = importdata('24feb2015');
file25 = importdata('25feb2015');
file26 = importdata('26feb2015');
file27 = importdata('27feb2015');
file28 = importdata('28feb2015');



all = [file1; file2; file3; file4; file5; file6; file7; file8; file9; file10;...
    file11; file12; file13; file14; file15; file16; file17; file18; file19;...
    file20; file21; file22; file23; file24; file25; file26; file27; file28];


%% m_map

 all(:,2)=rem((all(:,2)+180),360)-180;


m_proj('albers equal-area','long',[-180 180],'lat',[70 90],'rectbox','off');

figure('units','normalized','outerposition',[0 0 1 1]) % Fuldskærms-figur

colormap jet % Farveskala
% "jet" er Min personlige favorit, idet at: lav bølgelængde i optisk
% spektrum = "kolde" farver = lave værdier, %og høj bølgelængde = "varme"
% farver = høje værdier.

m_scatter(all(:,2),all(:,1),10,all(:,4),'filled'); % plot med m_scatter
% "m_scatter" fungerer meget lig "scatter", når det kommer til input
% argumenter, og dette gør sig faktisk også gældende for langt de fleste
% nye m_ functioner!

hold on; % Plot kommende ting oveni, indtil ny figur startes, eller "hold off" bliver kaldt

m_coast('patch',[.7 .7 .7], 'edgecolor', 'k'); % kystlinje og filled land
m_grid('xtick',10,'ytick',8,'linewi',1,'tickstyle','dm','tickdir','in',...
'XAxisLocation','bottom','yaxisloc','left'); % Definer gridparametre
ax=gca; % Standard akse-handle (til brug i manipulation af akser etc.)



%% Interpoler datasættet

% Definer grid:
Xq = -180:0.1:180; % Definer grid udstrækning og spacing i længdegrad
Yq=  70:0.1:81.6; % Definer grid udstrækning og spacing i breddegrad
Xq=Xq'; % Transponer til søjlevektor
Yq=Yq'; % Transponer til søjlevektor

% Generer Interpolerings-funktion med scatteredInterpolant:
F=scatteredInterpolant(all(:,2),all(:,1),all(:,4),'natural');

[xm,ym]=meshgrid(Xq,Yq); % generer et grid med "meshgrid"

interpolering=F(xm,ym); % interpolationen på selve griddet

figure('units','normalized','outerposition',[0 0 1 1]) % Fuldskærms-figur
colormap jet % Farveskala
m_pcolor(xm,ym,interpolering);shading flat; % Plot interpoleringen med m_pcolor
hold on;
m_coast('patch',[.7 .7 .7], 'edgecolor', 'k'); % kystlinje og filled land
m_grid('xtick',10,'ytick',8,'linewi',1,'tickstyle','dm','tickdir','in',...
'XAxisLocation','bottom','yaxisloc','left'); % Tilføj grid
set(gca, 'FontSize', 15); % Tekststørrelse (tal, gridsymboler)
ax=gca;

% Definer colorbar og tilhørende parametre
pos=get(gca,'pos');
h = colorbar('location','Eastoutside');
caxis([0 1])
set(gcf, 'renderer', 'zbuffer');
set(get(h,'ylabel'), 'FontSize', 13);

\end{lstlisting}
\newpage

\chapter{MATLAB funktioner}
\section{plottingSatelliteDataOverEarth.m}
\begin{lstlisting}
function plottingSatelliteDataOverEarth(lat1, lon1, lat2, lon2, lat3, lon3, lat4, lon4, lat5, lon5, lat6, lon6, lat7, lon7, lat8, lon8, lat9, lon9, lat10, lon10, lat11, lon11, lat12, lon12, lat13, lon13, lat14, lon14, lat15, lon15, lat16, lon16, lat17, lon17, lat18, lon18, lat19, lon19, lat20, lon20, lat21, lon21, lat22, lon22, lat23, lon23, lat24, lon24, lat25, lon25, lat26, lon26, lat27, lon27, lat28, lon28, lat29, lon29)
% plottingSatelliteDataOverEarth 
%
%
% input:            lat1 - lat29: latitude values of the SARAL satellite
%                   lon1 - lon29: longitude values of the SARAL satellite
%
% output:           graph 1 - satellite's orbit around Earth
%                   graph 2 - satellite's orbit shown over the Arctic


%% Plotting the satellites position over Earth

disp('The function plottingSatelliteDataOverEarth has begun. ');

% Plotting satellites position over Earth
load geoid
figure
axesm eckert4;
framem; gridm;
axis off
hold on
geoshow('landareas.shp', 'FaceColor', 'black');
linem(lat1, lon1, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file1
linem(lat2, lon2, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file2
linem(lat3, lon3, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file3
linem(lat4, lon4, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file4
linem(lat5, lon5, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file5
linem(lat6, lon6, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file6
linem(lat7, lon7, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file7
linem(lat8, lon8, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file8
linem(lat9, lon9, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file9
linem(lat10, lon10, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file10
linem(lat11, lon11, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file11
linem(lat12, lon12, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file12
linem(lat13, lon13, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file13
linem(lat14, lon14, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file14
linem(lat15, lon15, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file15
linem(lat16, lon16, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file16
linem(lat17, lon17, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file17
linem(lat18, lon18, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file18
linem(lat19, lon19, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file19
linem(lat20, lon20, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file20
linem(lat21, lon21, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file21
linem(lat22, lon22, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file22
linem(lat23, lon23, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file23
linem(lat24, lon24, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file24
linem(lat25, lon25, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file25
linem(lat26, lon26, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file26
linem(lat27, lon27, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file27
linem(lat28, lon28, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file28
linem(lat29, lon29, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file29
hold off

% Plotting satellite position over the Arctic
load coastlines
figure('Color', 'w')
axesm('eqaazim','MapLatLimit',[60 90])
axis off
framem on
gridm on
mlabel on
plabel on;
setm(gca,'MLabelParallel',0)
hold on 
geoshow(coastlat,coastlon, 'FaceColor', 'black', 'DisplayType', 'polygon')
linem(lat1, lon1, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file1
linem(lat2, lon2, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file2
linem(lat3, lon3, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file3
linem(lat4, lon4, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file4
linem(lat5, lon5, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file5
linem(lat6, lon6, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file6
linem(lat7, lon7, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file7
linem(lat8, lon8, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file8
linem(lat9, lon9, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file9
linem(lat10, lon10, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file10
linem(lat11, lon11, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file11
linem(lat12, lon12, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file12
linem(lat13, lon13, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file13
linem(lat14, lon14, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file14
linem(lat15, lon15, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file15
linem(lat16, lon16, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file16
linem(lat17, lon17, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file17
linem(lat18, lon18, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file18
linem(lat19, lon19, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file19
linem(lat20, lon20, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file20
linem(lat21, lon21, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file21
linem(lat22, lon22, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file22
linem(lat23, lon23, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file23
linem(lat24, lon24, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file24
linem(lat25, lon25, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file25
linem(lat26, lon26, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file26
linem(lat27, lon27, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file27
linem(lat28, lon28, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file28
linem(lat29, lon29, 'LineStyle','none', 'LineWidth',2, 'Color','r', ...
    'Marker','.', 'MarkerSize',10) % Points from file29
hold off

disp('The function plottingSatelliteDataOverEarth has been sucessfully executed.');
