dbDir = 'Database';
jpgFiles = dir([dbDir,'/*.png']);

len = length(jpgFiles);
database = zeros(128,128,3,len);

for k = 1:length(jpgFiles)
    filename = [dbDir,'/',jpgFiles(k).name];
    disp(filename);
    I = imread(filename);
    I = imresize(I,[128,128]);
    database(:,:,:,k) = I;
end
database = uint8(database);
save('database');

decompDatabase = zeros(128*128,3,len);
dim = 3;
for i=1:len
    for j=1:dim
        [decompDatabase(:,j,i),~] = wavedec2(database(:,:,j,i),7,'haar');
        [~,ind] = sort(abs(decompDatabase(:,j,i)),'descend');
        decompDatabase(ind(41:end),j,i) = 0;
    end
end
temp = decompDatabase(1,:,:);
decompDatabase(decompDatabase>0) = 1;
decompDatabase(decompDatabase<0) = -1;
decompDatabase(1,:,:) = temp;
save('decompDatabase');

qDir = 'InputImages';
jpgFiles = dir([qDir,'/*.png']);

len = length(jpgFiles);
Qdatabase = zeros(128,128,3,len);

for k = 1:length(jpgFiles)
    filename = [qDir,'/',jpgFiles(k).name];
    disp(filename);
    I = imread(filename);
    I = imresize(I,[128,128]);
    Qdatabase(:,:,:,k) = I;
end
Qdatabase = uint8(Qdatabase);
save('Qdatabase');

QdecompDatabase = zeros(128*128,3,len);
dim = 3;
for i=1:len
    for j=1:dim
        [QdecompDatabase(:,j,i),~] = wavedec2(Qdatabase(:,:,j,i),7,'haar');
        [~,ind] = sort(abs(QdecompDatabase(:,j,i)),'descend');
        QdecompDatabase(ind(61:end),j,i) = 0;
    end
end

temp = QdecompDatabase(1,:,:);
QdecompDatabase(QdecompDatabase>0) = 1;
QdecompDatabase(QdecompDatabase<0) = -1;
QdecompDatabase(1,:,:) = temp;
save('QdecompDatabase');