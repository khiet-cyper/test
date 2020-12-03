imageDir='D:\A_MY_SUBJECT\project\3B\brats2019';
imReader = @(x) niftiread(x);
volLoc = fullfile(imageDir,'imagesTr');
volds = imageDatastore(volLoc,'FileExtensions','.gz','ReadFcn',imReader);
Files=volds.Files;
lblLoc = fullfile(imageDir,'labelsTr');
label = imageDatastore(lblLoc,'FileExtensions','.gz','ReadFcn',imReader);
lbFiles=label.Files;
for i=1:155
    dir=char(Files(i));
    image=im2double(niftiread(dir));
    image=imadjustn(image);
    mea = regionprops3(image,'BoundingBox');
    boundingbox=mea.BoundingBox;
    boundingbox(4)=boundingbox(1)+boundingbox(4);
    boundingbox(5)=boundingbox(2)+boundingbox(5);
    boundingbox(6)=boundingbox(3)+boundingbox(6);
    if i==1
        bounding=boundingbox;
    end
    if i~=1
        if bounding(1)>boundingbox(1)
            bounding(1)=boundingbox(1);
        end
        if bounding(2)>boundingbox(2)
            bounding(2)=boundingbox(2);
        end
        if bounding(3)>boundingbox(3)
            bounding(3)=boundingbox(3);
        end
        if bounding(4)<boundingbox(4)
            bounding(4)=boundingbox(4);
        end
        if bounding(5)<boundingbox(5)
            bounding(5)=boundingbox(5);
        end
        if bounding(6)<boundingbox(6)
            bounding(6)=boundingbox(6);
        end
    end
end