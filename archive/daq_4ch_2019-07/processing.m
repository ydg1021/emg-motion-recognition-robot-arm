
profist5 = nan(48,20);
prostretch5 = nan(48,20);
prohandin5 = nan(48,20);
prohandout5 = nan(48,20);

for l = 1 : 20
    profist5(1:12,l) = rawtestfist(:,1,l);
    profist5(13:24,l) = rawtestfist(:,2,l);
    profist5(25:36,l) = rawtestfist(:,3,l);
    profist5(37:48,l) = rawtestfist(:,4,l);
    
    prostretch5(1:12,l) = rawteststretch(:,1,l);
    prostretch5(13:24,l) = rawteststretch(:,2,l);
    prostretch5(25:36,l) = rawteststretch(:,3,l);
    prostretch5(37:48,l) = rawteststretch(:,4,l);
    
    prohandin5(1:12,l) = rawtesthandin(:,1,l);
    prohandin5(13:24,l) = rawtesthandin(:,2,l);
    prohandin5(25:36,l) = rawtesthandin(:,3,l);
    prohandin5(37:48,l) = rawtesthandin(:,4,l);
    
     prohandout5(1:12,l) = rawtesthandout(:,1,l);
    prohandout5(13:24,l) = rawtesthandout(:,2,l);
    prohandout5(25:36,l) = rawtesthandout(:,3,l);
    prohandout5(37:48,l) = rawtesthandout(:,4,l);
end
% 
% subplot(5,1,1)
% plot(profist5)
% subplot(5,1,2)
% plot(prostretch5)
% subplot(5,1,3)
% plot(prohandin5)
% subplot(5,1,4)
% plot(prohandout5)
% subplot(5,1,5)
% plot(profist5)
% hold on
% plot(prostretch5)
% plot(prohandin5)
% plot(prohandout5)
