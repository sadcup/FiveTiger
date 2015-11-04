clear; clc; close all;

img = imread('original.png');

ary = [58, 87, 80, 120, 120, 180, 29, 58, 40, 80, 76, 152];
for n = 1 : 12
    tmp = imresize(img, [ary(n) ary(n)]);
    imwrite(tmp, ['five_tiger-' num2str(n) '.png']);
end;