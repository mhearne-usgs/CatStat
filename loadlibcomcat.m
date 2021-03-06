function [cat] = loadlibcomcat(pathname,catalogname)
% This function loads output from Mike Hearne's libcomcat program
% Input: currently has no input and catalog name and path are hard coded
% Output: a structure containing normalized catalog data
%         cat.name   name of catalog
%         cat.file   name of file contining the catalog
%         cat.data   real array of origin-time, lat, lon, depth, mag 
%         cat.id     character cell array of event IDs
%         cat.evtype character cell array of event types  


cat.file = pathname;
cat.name = catalogname;
fid = fopen(cat.file, 'rt');
S = textscan(fid,'%s %s %f %f %f %f %s','HeaderLines',1,'Delimiter',',');
fclose(fid);

time = datenum(S{2},'yyyy-mm-dd HH:MM:SS');
[cat.data,ii] = sortrows(horzcat(time,S{3:6}),1);
cat.id = S{1}(ii);
cat.evtype = S{7}(ii);

%     index = find(cat.data(:,5) < 3.0); % Finds index of events below 3.0
% 
%     for ii = 1:length(index)
%         row = index(ii,1);
%         cat.data(row,5) = NaN; % removes all earthquakes below 3.0
%     end
% 
%     cat.data(isnan(cat.data(:,5)),:) = [];
%     
%     count = 0;
%     for ii = 1:length(index)
%         row = index(ii,1);
%         cat.evtype(row-count,:) = []; % deletes all rows of earthquakes below 3.0
%         count = count + 1;
%     end
    
    