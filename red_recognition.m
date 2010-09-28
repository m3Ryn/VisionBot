function red_recognition
clear all, close all, clc;
coord_x_row = [];
coord_y_row = [];

vid = videoinput('winvideo',1','RGB24_640x480');
start(vid);
image = getdata(vid,1);

%image = imread('image.bmp');
[indexed_image,map] = rgb2ind(image,5); %convert into index image mode
[m,n] = size(map); % extracting rows ans colums from the map

% loop to check if the image contains RED color. 
% ------------------------------------------------
for i = 1:m                     
    if (map(i,:)==[1 0 0]);    
        j = 1;
        break;
    end
j = 0;
end
% ------------------------------------------------

% loop to generate a new map matrix with all zeros
%-------------------------------------------------
if j == 1
    for row = 1:m
        for column = 1:n
            map_new(row,column) = 0;
        end
    end
end
% ------------------------------------------------
map_new(i,:) = [1 0 0]; % making the red index to be filled with red

roi = roicolor(indexed_image,i-1); %converted into binary image through 'region of interest'

% Coordinates calculation
% -------------------------------------------------
boundary = bwboundaries(roi); % tracing external boundary
coordinates = cell2mat(boundary); %converting into matrix form
Y = coordinates(:,1);
X = coordinates(:,2);

centre_x = round((max(X)+ min(X))/2);
centre_y = round((max(Y)+ min(Y))/2);
% --------------------------------------------------
subplot(211),imshow(image); % showing the original image
rectangle('Position',[min(X),min(Y),(max(X)-min(X)),(max(Y)-min(Y))],'LineWidth',2,'EdgeColor','y');
stop(vid),delete(vid),clear vid;
%subplot(212),imshow(indexed_image,map_new); % showing the recognized image
%subplot(313),imshow(roi); % showing region of interest logically

 
