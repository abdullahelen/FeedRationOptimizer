function result = funcRequirements(Cattle)
    result = struct();
    result.DMI = 0;    % Dry Material Intake
    result.CP = 0;     % Crude Protein
    result.DCP = 0;    % Digestible Crude Protein
    result.Ca = 0;     % Calcium
    result.P = 0;      % Phosphor
    result.Na = 0;     % Sodium
    
    result.NEm = 0;    % Net Energy for Maintance
    result.MEm = 0;    % Metabolical Energy for Maintance
    result.NEL = 0;    % Net Energy for Lactation
    result.ME = 0;     % Metabolical Energy

    %% 1. Kuru Madde Alımı (DMI: Dry Material Intake)
    % Belirli bir yağ oranına göre düzeltilmiş süt miktarı.
    % Burada Y_M kg cinsinden süt miktarını, F_M ise kg cinsinden süt yağı
    % miktarını ifade etmektedir. Buradaki F_M değeri için Holstein cinsi
    % ineklerde süt miktarının %3.5-%4 arasında kullanılmaktadır. Elbette bu
    % değer diğer ırklara mensup inekler için de farklı olacaktır.
    FCM = 0.4 * Cattle.Ym + 15 * (Cattle.Ym * (Cattle.Fm/100));

    % NRC-2001, süt veren ineklerin kuru madde alımı (DMI).
    result.DMI = (0.372 * FCM + 0.0968 * (Cattle.BW^0.75)) * ...
        (1 - exp(-0.192 * (Cattle.WOL + 3.67)));

    % Kuru madde alımının hesaplanması, özellikle kaba yemden gelen besinsel
    % NDF dikkate alınarak değerlendirme yapıldığında, daha sağlıklı sonuçlar
    % vermektedir. Ancak, %25-42 NDF oranında kuru madde içeren yüksek enerjili
    % yemlerle beslenen sağmal ineklerin kuru madde alımını hesaplamada, kuru
    % madde alımında %1'den daha az değişim görülmektedir.




    %% 2. Protein Gereksinimi (Protein Intakes)
    % Kaynak: https://dergipark.org.tr/tr/download/article-file/508186
    % İneğin gr cinsinden ham protein ihtiyacınının hesaplanması.
    result.CP = 3.7 * (Cattle.BW^0.75) + 85 * Cattle.Ym;

    % Sindirilebilir ham protein (Digestible Crude Protein)
    result.DCP = 0.5 * Cattle.BW + 100 + Cattle.Fm * 60;


    
    
    
    %% 3. Mineral Gereksinimi (Mineral Intakes)
    % Mineraller, hayvanın sağlığı ve verimi için gerekli olan elementlerdir.
    % Süt ineklerinin rasyonlarında bulunması gereken mineraller; Kalsiyum
    % (Ca), Fosfor (P), Magnezyum (Mg), Sodyum (Na), Klor (Cl), Kükürt (S) ve
    % Potasyum (K) dur. Sodyum ve Klor rasyonlara tuz olarak katılır. Burada
    % önemli bir diğer konu da Ca/P oranıdır. Laktasyonun başlaması ile Ca ve P
    % gereksinimi büyük oranda artmaktadır. Çünkü sütte önemli miktarda Ca ve P
    % mineralleri bulunmaktadır. Süt ineklerinin rasyonlarında kalsiyum ve
    % fosforun belli oranlarda bulunması şarttır. Bu oranın (Ca/P), 1/1 ~ 2/1
    % arasında olması gerekmektedir.

    % Süt ineklerinde Ca gereksinimi.
    % Burada Ca ineğin gr cinsinden kalsiyum gereksinimini, Cattle.BW hayvanın vücut
    % ağırlığını (body weight) ve FCM yağ oranına göre düzeltilmiş süt
    % miktarını (fat-corrected milk) ifade etmektedir. Ayrıca buradaki 0.38
    % değeri, inek yemlerindeki kalsiyumun emilim etkinliğini göstermektedir.
    
    % http://www.zootekni.org.tr/upload/file/ruminantbesleme.pdf
    % PDF'ye göre sayfa 68 (kitaba göre sayfa 59)
    result.Ca = (0.0405 * Cattle.BW) + (3.21 * Cattle.Ym);
    % 0.0154 * (Cattle.BW / 0.38) + (1.22 * FCM / 0.38) * Cattle.Ym;
    % (Cattle.BW^0.75)

    % Burada Ca ineğin gr cinsinden kalsiyum gereksinimini, Cattle.BW hayvanın vücut
    % ağırlığını (body weight) ve FCM yağ oranına göre düzeltilmiş süt
    % miktarını (fat-corrected milk) ifade etmektedir. Ayrıca buradaki 0.38
    % değeri, inek yemlerindeki kalsiyumun emilim etkinliğini göstermektedir.
    % Süt ineklerinde P gereksinimi aşağıdaki eşitlik ile hesaplanabilir.

    % http://www.zootekni.org.tr/upload/file/ruminantbesleme.pdf
    % PDF'ye göre sayfa 69 (kitaba göre sayfa 60)
    result.P = (0.0286 * Cattle.BW) + (0.78 + 0.3 * Cattle.Fm) * Cattle.Ym;
    % result.P = 0.143 * (Cattle.BW^0.75) + (0.99 * FCM / 2) * Cattle.Ym;

    % Burada result.P ineğin gr cinsinden fosfor gereksinimini, Cattle.BW
    % hayvanın vücut ağırlığını (body weight) ve FCM yağ oranına göre
    % düzeltilmiş süt miktarını (fat-corrected milk) ifade etmektedir.
    % 
    % Önemli miktarda Na ve Cl sütle salgılanmaktadır. Bu nedenle
    % rasyondaki bu minerallerin yeterince sağlanmaları büyük önem taşır.
    % Laktasyondaki inekler için önerilen Na miktarı %0.18 ve Cl miktarı
    % ise %0.25’tir. Bu miktarlar kuru dönemdeki ineklerin gereksiniminden
    % %80 daha fazladır.



    

    %% 4. Enerji Gereksinimi (Energy Intakes)
    
    % Bütün çiftlik hayvanları vücut fonksiyonlarının korunması,
    % vücut sıcaklığının kontrolü ve verim için enerjiye gereksinim
    % duyarlar. Çiftlik hayvanlarının yem ihtiyaçları; yaşama payı
    % ve verim payı olmak üzere ikiye ayrılır. Bunun sebebi;
    % hayvanlar yedikleri yemin bir kısmını yaşamak için bir
    % kısmını da verim vermek için kullanırlar. Süt ineklerinin
    % günlük yaşama payı için gereksinim duydukları enerji miktarı
    % NRC-1989’a göre:
    
    result.NEm = 0.08 * (Cattle.BW^0.75); % Mcal/day
    result.MEm = 0.133 * (Cattle.BW^0.75); % Mcal/day

    % Normal yaşama payı net enerji (Net Energy used for Maintenance) gereksinimi
    % Süt ineklerindeki verim payı enerji gereksinimi, sütün enerji içeriğine
    % göre hesaplanmaktadır. Buna ilaveten, sütteki enerji içeriği de yağ
    % miktarına bağlı olarak değişmektedir. NRC-1989, %4 yağlı 1 kg süt için
    % 0.74 Mcal NE_L gerektiğini bildirmiştir. Süt yağ içeriğine bağlı olarak
    % farklı enerji sistemlerine göre 1 kg süt için gerekli olan enerji
    % miktarları.
    %result.NEL = 0.3512 + 0.0962 * Cattle.Fm;
    result.NEL = 0.36 + 0.0969 * Cattle.Fm; % NRC-2001 Eq. (2-17)
    result.ME = 0.577 + 0.165 * Cattle.Fm;
end
