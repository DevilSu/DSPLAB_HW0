% input1---source image: I
% input2---flip direction: type (0:horizontal, 1:vertical, 2:both)
% output---flipped image: I_flip

function I_flip = my_flip(I, type);

% RGB channel
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% get height, width, channel of image
[height, width, channel] = size(I);
I_flip = zeros(height,width,3);
I_flip = uint8(I_flip);
%%  horizontal flipping
if type==0
    I_flip(:,:,1) = R(:,end:-1:1);
    I_flip(:,:,2) = G(:,end:-1:1);
    I_flip(:,:,3) = B(:,end:-1:1);
end

%% vertical flipping
if type==1
    I_flip(:,:,1) = R(end:-1:1,:);
    I_flip(:,:,2) = G(end:-1:1,:);
    I_flip(:,:,3) = B(end:-1:1,:);
end

%%  horizontal + vertical flipping
if type==2
     I_flip(:,:,1) = R(end:-1:1,end:-1:1);
    I_flip(:,:,2) = G(end:-1:1,end:-1:1);
    I_flip(:,:,3) = B(end:-1:1,end:-1:1);
end
