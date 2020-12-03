imageDir='D:\A_MY_SUBJECT\project\3B\brats2019';
imReader = @(x) niftiread(x);

flairvolLoc = fullfile(imageDir,'imagesTr_flair');
flairvolds = imageDatastore(flairvolLoc,'FileExtensions','.gz','ReadFcn',imReader);
flairFiles=flairvolds.Files;

t1volLoc = fullfile(imageDir,'imagesTr_t1');
t1volds = imageDatastore(t1volLoc,'FileExtensions','.gz','ReadFcn',imReader);
t1Files=t1volds.Files;

t1cevolLoc = fullfile(imageDir,'imagesTr_t1ce');
t1cevolds = imageDatastore(t1cevolLoc,'FileExtensions','.gz','ReadFcn',imReader);
t1ceFiles=t1cevolds.Files;

t2volLoc = fullfile(imageDir,'imagesTr_t2');
t2volds = imageDatastore(t2volLoc,'FileExtensions','.gz','ReadFcn',imReader);
t2Files=t2volds.Files;

lblLoc = fullfile(imageDir,'labelsTr');
label = imageDatastore(lblLoc,'FileExtensions','.gz','ReadFcn',imReader);
lbFiles=label.Files;

px=ones(1,240,155);
py=ones(240,1,155);
pz=ones(240,240,1);
for j=1:240
    pox(j,:,:)=j.*px;
    poy(:,j,:)=j.*py;
end
for j=1:155
    poz(:,:,j)=j.*pz;
end
a=0;
for i=1:155
    lbdir=char(lbFiles(i));
    lb=im2double(niftiread(lbdir));
    lb=imadjustn(lb);
    
    mea = regionprops3(lb,'BoundingBox');
    meas = mea.BoundingBox;
    meas(1)=floor(meas(1));
    meas(2)=floor(meas(2));
    meas(3)=floor(meas(3));
    meas(4)=ceil(meas(4));
    meas(5)=ceil(meas(5));
    meas(6)=ceil(meas(6));
    
    flairdir=char(flairFiles(i));
    flairimage=im2double(niftiread(flairdir));
    flairimage=flairimage(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    flairimage=imadjustn(flairimage);
    flairimage=flairimage(:);
    
    t1dir=char(t1Files(i));
    t1image=im2double(niftiread(t1dir));
    t1image=t1image(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    t1image=imadjustn(t1image);
    t1image=t1image(:);
    
    t1cedir=char(t1ceFiles(i));
    t1ceimage=im2double(niftiread(t1cedir));
    t1ceimage=t1ceimage(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    t1ceimage=imadjustn(t1ceimage);
    t1ceimage=t1ceimage(:);
    
    t2dir=char(t2Files(i));
    t2image=im2double(niftiread(t2dir));
    t2image=t2image(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    t2image=imadjustn(t2image);
    t2image=t2image(:);
    
    posx=pox(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    posx=posx(:);
    posy=poy(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    posy=posy(:);
    posz=poz(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    posz=posz(:);
    
    k=1;
    
    while (k<=(meas(4)+1)*(meas(5)+1)*(meas(6)+1))
        TrainFea(a+k,1)=1;
        TrainFea(a+k,2)=flairimage(k);
        TrainFea(a+k,3)=t1image(k);
        TrainFea(a+k,4)=t1ceimage(k);
        TrainFea(a+k,5)=t2image(k);
        TrainFea(a+k,6)=posx(k);
        TrainFea(a+k,7)=posy(k);
        TrainFea(a+k,8)=posz(k);
        k=k+1;
    end
    
    a=a+k;
end