function catmagcomp(catalog,yrmagcsv,s)
% This function plots and compares the magnitude completeness. 
% Input: a structure containing normalized catalog data
%         cat.name   name of catalog
%         cat.file   name of file contining the catalog
%         cat.data   real array of origin-time, lat, lon, depth, mag 
%         cat.id     character cell array of event IDs
%         cat.evtype character cell array of event types 
% Output: None

disp(['While the median magnitude can give an approximate look at magnitude ']);
disp(['distributions (cumulative and incremental) provide further indicators of ']);
disp(['catalog completeness.']);
disp([' ']);

M = length(yrmagcsv);
begyear = yrmagcsv(1,1);
endyear = yrmagcsv(M,1);

timemag = [];

for x = 1:((endyear-begyear)+1)
    
    row = horzcat(s(x).jj(:,1),s(x).jj(:,5));
    timemag = [timemag;row];
    
end

compmag = timemag(:,2);

sortcompmag = sortrows(compmag(:,1),1);
L = length(compmag(:,1));

minmag = floor(min(compmag(:,1)));
maxmag = ceil(max(compmag(:,1)));
[nn,xx] = hist(compmag(:,1),[minmag:0.1:maxmag]);

% Calculate cumulative magnitude distribution
cdf =[];
idf =[];
jj = 0;
mags = [minmag:0.1:maxmag];

for cmag = mags 
    
  jj = jj+1;
  cdf(jj) = sum(round(compmag(:,1)*10)>=round(cmag*10));
  idf(jj) = sum(round(compmag(:,1)*10)==round(cmag));
  
end

figure
hh = semilogy(mags,cdf,'k+','linewidth',1.5);
hold on
hh = semilogy(xx,nn,'ro','linewidth',1.5);
[yy,ii] = max(nn);
estcomp = mags(ii);
disp(['Estimated Completeness (max incremental): ',num2str(estcomp)]);
disp([' ']);
axis([minmag maxmag 10^0 10^6])
legend('Cumulative','Incremental')
xlabel('Magnitude','fontsize',18)
ylabel('Number of Events','fontsize',18)
title('Magnitude Distributions','fontsize',18)
set(gca,'linewidth',1.5)
set(gca,'fontsize',15)
set(gca,'box','on')

