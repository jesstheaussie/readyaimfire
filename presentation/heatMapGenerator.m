
% add heatmap vis to map

[I,map] = imread('3_routes.png','png');
imshow(I,map);

% hm = zeros(size(I(:,:,1)), 'int8');

x = repmat((1:size(I,1))',[1,size(I,2)]);
y = repmat(1:size(I,2),[size(I,1),1]);

z = 5*y .^ 2 + ... % make the right size dangerous
    3*x .^ 2 - ...   % make the bottom dangerous
    (1024/2)^2 ;    % shift to the left


spur = normpdf(y,1024/3,15) .* (x - 400)*.6;
spur(spur<0) = 0;
spur = spur / max(spur(:)) * 255;

spur2 = normpdf(y,1024*.6,15) .* (x - 200)*.6;
spur2(spur2<0) = 0;
spur2 = spur2 / max(spur2(:)) * 255;



z(z<0) = 0;
z = z / max(z(:)) * 255;

z = z + spur + spur2;
z = z / max(z(:)) * 255;

% imagesc(z)
ybounds = [204, 815];
xbounds=[262,661];


% add into the map image
I(xbounds(1):xbounds(2), ybounds(1):ybounds(2),2) = I(xbounds(1):xbounds(2), ybounds(1):ybounds(2),2) - uint8(z(xbounds(1):xbounds(2),ybounds(1):ybounds(2)));
I(xbounds(1):xbounds(2), ybounds(1):ybounds(2),3) = I(xbounds(1):xbounds(2), ybounds(1):ybounds(2),3) - uint8(z(xbounds(1):xbounds(2),ybounds(1):ybounds(2)));
% I(xbounds(1):xbounds(2),ybounds(1):ybounds(2),1) = I(xbounds(1):xbounds(2),ybounds(1):ybounds(2),1) / max(max(I(xbounds(1):xbounds(2),ybounds(1):ybounds(2),1))) * 255;
I(I<0) = 0;
imshow(I,map)
imwrite(I, 'fireRiskMap.png', 'png')

