namaAlat = {'Apik' 'Bagus' 'Cakep' 'Dijamin'};
data = [ 18 23280 970
         29 22320 930
         21 24000 1000
         23 22800 950];
     
maksDayaTahanPengoperasian = 29;
maksJumlahPengemasan = 24000;
maksKecepatanPengemasan = 1000;

data(:,1) = data(:,1) / maksDayaTahanPengoperasian;
data(:,2) = data(:,2) / maksJumlahPengemasan;
data(:,3) = data(:,3) / maksKecepatanPengemasan;

relasiAntarKriteria = [ 1     4     4
                        0     1     2
                        0     0     1];
                    
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};
   
RasioKonsistensi = HitungKonsistensiAHP(relasiAntarKriteria);

if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir
    ahp = data * bobotAntarKriteria';
    
    disp('=== Hasil Perhitungan Dengan Metode Fuzzy AHP ===')
    disp('+--------------+--------------+--------------+')
    disp('|   Nama Alat  |  Skor Akhir  |   Kualitas   |')
    disp('+--------------+--------------+--------------+')
end

for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Kurang Baik';
        elseif ahp(i) < 0.7
            status = 'Cukup Baik';
        elseif ahp(i) < 0.8
            status = 'Baik';
        else
            status = 'Sangat Baik';
        end
        
        disp(['| ', char(namaAlat(i)), blanks(13 - cellfun('length',namaAlat(i))), '| ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), '   | ', ...
             char(status), blanks(13 - length(num2str(status))), '| '])
end

disp('+--------------+--------------+--------------+')