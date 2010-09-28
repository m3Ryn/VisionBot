clc,clear all,close all;

%Calling the Video
%---------------------------------------------------------

vid = videoinput('winvideo',1','RGB24_640x480');
triggerconfig(vid,'manual');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',Inf);
start(vid);

while(1)
    
    trigger(vid);
    image = getdata(vid,1);
    
    %Passing through a Mean filter to filter out noise
    %------------------------------------------------------ 

    H = fspecial('average',[5 5]);
    rgb = imfilter(image,H);

    rgb = double(rgb)/255;
    r = rgb(:,:,1);
    g = rgb(:,:,2);
    b = rgb(:,:,3);

    %Filter RED Color
    %------------------------------------------------------

    Rc = r./sqrt(r.^2+g.^2+b.^2)>0.87;

    rgb2(:,:,1) = Rc.*r;
    rgb2(:,:,2) = Rc.*g;
    rgb2(:,:,3) = Rc.*b;


    rgb2_filtered = imfilter(rgb2,H);


    indexed_image = rgb2ind(rgb2_filtered,5);
    %converted into binary image through 'region of interest'
    roi = roicolor(indexed_image,2);
    
    % Coordinates calculation
    % -------------------------------------------------
    boundary = bwboundaries(roi); % tracing external boundary
    coordinates = cell2mat(boundary); %converting into matrix form
    Y = coordinates(:,1);
    X = coordinates(:,2);


    % show result
    %clf;subplot(2,2,1);
    imshow(rgb);
    rectangle('Position',[min(X),min(Y),(max(X)-min(X)),(max(Y)-min(Y))],'LineWidth',2,'EdgeColor','y');    

    %subplot(2,2,2);
    %imshow(rgb2);
    %axis image;
end
stop(vid),delete(vid),clear vid;