%clc;
%clear all;
veri=xlsread('C:\Users\Burcu\Downloads\Indian Liver Patient Dataset (ILPD).csv');
yeniveri=veri;
while(1==1)
    fprintf('\n');
    fprintf('\n*************************************'); 
    fprintf('\n1- Eksik Veriyi Ortalama �le Tamamlama');    
    fprintf('\n2- Ortalama Bulma'); 
    fprintf('\n3- Medyan Bulma'); 
    fprintf('\n4- Mod Bulma');
    fprintf('\n5- Frekans Bulma'); 
    fprintf('\n6- IQR Hesapla'); 
    fprintf('\n7- Ayk�r� De�erleri Bulma'); 
    fprintf('\n8- Be� Say� �zeti'); 
    fprintf('\n9- Kutu Grafi�i'); 
    fprintf('\n10- Varyans ve Standart Sapma Bulma'); 
    fprintf('\n11- ��k��'); 
    
    secim=input('\nSe�im yap�n: ');
    cikis=0;
    switch secim
        case 1
            disp('Eksik Veriyi Ortalama �le Tamamlama');
            [I,J]=find(isnan(veri));
            eksikindeks=[I,J];
            [verisay,sutunsay]=size(veri);
            eksikverisay=size(eksikindeks,1);
            
            for i=1:eksikverisay
                sat=eksikindeks(i,1);
                sut=eksikindeks(i,2);
                tumsatirlar=yeniveri(:,sut);
                nanolmayanlar=tumsatirlar(~isnan(tumsatirlar));
                ort=mean(nanolmayanlar);
                yeniveri(sat,sut)=ort;
            end
            disp('Eksik veriler tamamland�.');  
            
        case 2
            disp('--Ortalama Bulma--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            toplam=0;
            ort=0;
            for i=1:sutun
                toplam=0;
                for j=1:satir
                toplam= toplam+yeniveri(j,i);
                end
                ort=toplam/verisay;
                fprintf('%d. s�tunun ortalamas�: %f\n',i,ort);
                ort=0;
            end
            
        case 3
            disp('--Medyan Bulma--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                siraliveri=sort(yeniveri(:,i));
                ortancaindex=(satir+1)/2;
                if mod(satir,2)==0
                    index1=satir/2;
                    index2=(satir/2)+1;
                    medyan=(siraliveri(index1,1)+siraliveri(index2,1))/2;
                else
                    medyan=siraliveri(ortancaindex,1);
                end
                fprintf('%d. s�tunun medyan�= %f\n',i,medyan);
                
            end
            
        case 4
            disp('--Mod Bulma--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            
            
            for i=1:sutun
                siraliveri=sort(yeniveri(:,i));
                tekilveri=unique(siraliveri);
                tekilveriadet = size(tekilveri,1);
                tekilveri = [tekilveri zeros(tekilveriadet,1)];
                
                for j=1:tekilveriadet
                    deger = tekilveri(j,1);
                    sonucDizi = siraliveri == deger; 
                    tekilveri(j,2)=sum(sonucDizi); 
                end
                maxFrekans=max(tekilveri(:,2));
                ModIndexler=find(tekilveri(:,2) == maxFrekans);
                fprintf('%d. s�tunun modlar�:\n',i);
                for j=1:size(ModIndexler,1)
                    fprintf( '\t%d.Mod: %.2f frekans�: %d\n',j,tekilveri(ModIndexler(j,1),1),maxFrekans);
                end
            end
            
        case 5
            disp('--Frekans Bulma--');
            sutungir=input('Frekans�n� hesaplamak istediginiz s�tunu giriniz:');
            sutun=sort(yeniveri(:,sutungir));
            tekilveri = unique(sutun);
            tekilveriadet = size(tekilveri,1);
            tekilveri = [tekilveri zeros(tekilveriadet,1)];
            for i=1:tekilveriadet
                deger = tekilveri(i,1);
                sonucDizi = sutun == deger; 
                tekilveri(i,2)=sum(sonucDizi); 
            end
            disp(tekilveri);
            bar(tekilveri(:,1),tekilveri(:,2));
            
        case 6
            disp('--IQR Hesapla--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                verisayisi=size(yeniveri,1);
                siraliveri=sort(yeniveri(:,i));

                indexQ1=(25/100)*(verisayisi+1); 
                if ~isa(indexQ1,'float')
                   index1=floor(indexQ1);
                   index2=ceil(indexQ1);

                   Q1=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q1= siraliveri(indexQ1,1);

                end

                indexQ3=(75/100)*(verisayisi+1); 
                if ~isa(indexQ3,'float')
                   index1=floor(indexQ3);
                   index2= ceil(indexQ3);

                   Q3=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q3= siraliveri(indexQ3,1);

                end
                IQR= Q3-Q1;
                fprintf('%d. s�tunun IQR de�eri= %.2f\n',i,IQR);
            end
            
        case 7
            disp('--Ayk�r� De�erleri Bulma--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                verisayisi=size(yeniveri,1);
                siraliveri=sort(yeniveri(:,i));

                indexQ1=(25/100)*(verisayisi+1); 
                if ~isa(indexQ1,'float')
                   index1=floor(indexQ1);
                   index2=ceil(indexQ1);

                   Q1=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q1= siraliveri(indexQ1,1);

                end

                indexQ3=(75/100)*(verisayisi+1); 
                if ~isa(indexQ3,'float')
                   index1=floor(indexQ3);
                   index2= ceil(indexQ3);

                   Q3=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q3= siraliveri(indexQ3,1);

                end
                IQR= Q3-Q1;
                ust = Q3+IQR*1.5;
                alt = Q1-IQR*1.5;
                fprintf('\n%d s�tununun ayk�r� de�erleri: \n',i);
                aykiriveriler=[];
                for j=1:verisayisi
                    if siraliveri(j,1)<alt || siraliveri(j,1)>ust
                        if ismember(siraliveri(j,1),aykiriveriler)
                            continue;
                        else
                            aykiriveriler=[aykiriveriler;siraliveri(j,1)];
                            fprintf('%.2f - ',siraliveri(j,1));
                        end
                    end
                    
                end
                          
            end
            
        case 8
            disp('--Be� Say� �zeti--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                verisayisi=size(yeniveri,1);
                siraliveri=sort(yeniveri(:,i));

                indexQ1=(25/100)*(verisayisi+1); 
                if ~isa(indexQ1,'float')
                   index1=floor(indexQ1);
                   index2=ceil(indexQ1);

                   Q1=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q1= siraliveri(indexQ1,1);

                end

                indexQ3=(75/100)*(verisayisi+1); 
                if ~isa(indexQ3,'float')
                   index1=floor(indexQ3);
                   index2= ceil(indexQ3);

                   Q3=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q3= siraliveri(indexQ3,1);

                end
                IQR= Q3-Q1;
                medyan=median(yeniveri(:,i));
                maxDeger = max(yeniveri(:,i));
                minDeger = min(yeniveri(:,i));
                fprintf('\n%d. s�tunun 5 say� �zeti:\n',i);
                fprintf('\tMin deger: %.2f\n',minDeger)
                fprintf('\tQ1: %.2f\n',Q1)
                fprintf('\tMedyan: %.2f\n',medyan)
                fprintf('\tQ3: %.2f\n',Q3)
                fprintf('\tMax deger: %.2f\n',maxDeger)
            end
            
        case 9
            disp('--Kutu Grafi�i--');
            boxplot(yeniveri);
            
        case 10
            disp('--Varyans ve Standart Sapma Bulma--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                toplam=0;
                ort=mean(yeniveri(:,i));
                for j=1:satir
                    fark=yeniveri(j,i)-ort;
                    toplam=toplam+fark*fark;
                end
                varyans=toplam/verisay;
                standart=sqrt(varyans);
                std1=std(yeniveri(:,11));
                fprintf('%d.s�tunun:\n',i);
                fprintf('\tVaryans�= %.2f Standart sapmas�= %.2f\n',varyans,standart);
                
            end
            
        case 11
            cikis=1;
            disp('��k�� yapt�n�z');
            
        otherwise
            disp('***********************************************************');
            disp('Hatal� giri� yapt�n�z l�tfen 1-11 aras�nda say� giriniz');
            
    end
    if(cikis==1);
        break;
    end
end    
            
            
            
            
            

