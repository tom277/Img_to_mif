clear all;

[I, map, alpha] = imread('heart.png');
%I = imresize(I,[(480/4) (640/4)]);
%I = uint8(I);
%I = I / 2;
imshow(I);
red = I(:, :, 1);
green = I(:, :, 2);
blue = I(:, :, 3);
imshow(I)

[lenx, leny, ~] = size(I);
total = lenx * leny;
fileID = fopen('heart.MIF','w');
fprintf(fileID,'Depth = %u;\r\n', total);
fprintf(fileID,'Width = 13;\r\n');
fprintf(fileID,'Address_radix = dec;\r\n');
fprintf(fileID,'Data_radix = bin;\r\n');
% Character Generator ROM Data %
fprintf(fileID,'Content\r\n');
fprintf(fileID,'  Begin\r\n');

counter = 0;
[row, col] = size(red);
for i = 1:(row)
    %disp(i)
    for j = 1:(col)
        b = bitget(red(i, j),1:8);
        string = "";
        if(alpha(i,j) == 0)
            string = string + '0';
        else
           string = string + '1';
        end
        for x = 8:-1:5
            string = string + b(x);
        end
        b = bitget(green(i, j),1:8);
        for x = 8:-1:5
            string = string + b(x);
        end
        b = bitget(blue(i, j),1:8);
        for x = 8:-1:5
            string = string + b(x);
        end
        fprintf(fileID,'%05d  : %s ;\r\n', counter, string);
        if(j == col)
            fprintf(fileID,'\r\n');
        end
        counter = counter + 1;
    end
end

%test script

%b = bitget(78,1:8)
%b = decimalToBinaryVector(51)
%b = flip(b)
%string = "";
%[foo, len] = size(b);
%for x = 8:-1:5
%    if(x <= len)
%        string = string + b(x);
%    else
%        string = string + "0";
%    end
%end
%disp(string)
%fprintf(fileID,'End;\r\n');
