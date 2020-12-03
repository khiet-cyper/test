imageDir='D:\A_MY_SUBJECT\project\3B\brats2019';
imReader = @(x) niftiread(x);

lblLoc = fullfile(imageDir,'labelsTr');
label = imageDatastore(lblLoc,'FileExtensions','.gz','ReadFcn',imReader);
lbFiles=label.Files;
a=0;
for i=1:155

    lbdir=char(lbFiles(i));
    lb=niftiread(lbdir);
    lbmanu=im2double(lb);
    lbmanu=imadjustn(lbmanu);
    
    mea = regionprops3(lbmanu,'BoundingBox');
    meas = mea.BoundingBox;
    meas(1)=floor(meas(1));
    meas(2)=floor(meas(2));
    meas(3)=floor(meas(3));
    meas(4)=ceil(meas(4));
    meas(5)=ceil(meas(5));
    meas(6)=ceil(meas(6));
    
    lb=lb(meas(1):(meas(1)+meas(4)),meas(2):(meas(2)+meas(5)),meas(3):(meas(3)+meas(6)));
    lb=lb(:);
    
    k=1;
    
    while (k<=(meas(4)+1)*(meas(5)+1)*(meas(6)+1))
        y(a+k,1)=lb(k);
        k=k+1;
    end
    a=a+k;
end