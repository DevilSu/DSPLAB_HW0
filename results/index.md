# Derek Su, 蘇揚皙, EE17 NTHU <span style="color:red">(102061246)</span>

# Project 1 / Image Filtering and Hybrid Images

## Overview

The project is related to 

> Image processing
>	- rgb to greyscale(pre lab)
>	- flipping
>	- rotation

## Implementation

1. my_flip.m

	* 3 different flips
	
		- horizontal
		
			```
			I_flip(:,:,1) = R(:,end:-1:1);
   			I_flip(:,:,2) = G(:,end:-1:1);
			I_flip(:,:,3) = B(:,end:-1:1);
			```
			
		- vertical
		
			```
			I_flip(:,:,1) = R(end:-1:1,:);
   			I_flip(:,:,2) = G(end:-1:1,:);
			I_flip(:,:,3) = B(end:-1:1,:);
			```
			
		- horizontal + vertical
		
			```
			I_flip(:,:,1) = R(end:-1:1,end:-1:1);
			I_flip(:,:,2) = G(end:-1:1,end:-1:1);
			I_flip(:,:,3) = B(end:-1:1,end:-1:1);
			```
2. my_rotation.m

	* step 1: record image vertex, and use rotation matrix to get new vertex.
	
		```
		matrix = [cos(radius) -sin(radius) ; sin(radius) cos(radius)];
		matrix_inv = inv(matrix);
		vertex = [1 width 1 width; 1 1 height height];
		vertex_new = matrix*vertex;
		```
	
	* step 2: find min x, min y, max x, max y.
	
		```
		max_x=max(vertex_new(1,:));
		min_x=min(vertex_new(1,:));
		max_y=max(vertex_new(2,:));
		min_y=min(vertex_new(2,:));
		```
	
	* step 3: consider how much to shift the image to the positive axis.
	
		```
		x_shift = -min_x;
		y_shift = -min_y;
		```
	
	* step 4: calculate new width and height.
	
		```
		width_new  = ceil(max_x)-floor(min_x);
		height_new = ceil(max_y)-floor(min_y);
		```

	* step 5: initial r,g,b array for the new image(uint8 datatype).
	
		```
		R_rot = uint8(zeros(height_new, width_new));
		G_rot = uint8(zeros(height_new, width_new));
		B_rot = uint8(zeros(height_new, width_new));
		```
		
	* step 6: shift the new pixel (x_new, y_new) back, and rotate -radius.
	
		```
		wtmp = matrix_inv*[x_new-x_shift ; y_new-y_shift];
		x_old = tmp(1);
		y_old = tmp(2);
		```
		
	* step 7: using "ceil()" & "floor()" to get interpolation coordinates.
	
		```
		x1 = floor(x_old);
		x2 = ceil( x_old);
		y1 = floor(y_old);
		y2 = ceil( y_old);
		```
		
	* step 8: if (x_old, y_old) is inside of the source image, calculate r,g,b by interpolation. Else if (x_old, y_old) is outside of the source image, set r,g,b = 0(black).
	
		```
		if (x1 >= 1) && (x1 <= width) && (x2 >= 1) && (x2 <= width) && (y1 >= 1) && (y1 <= height)&& (y2 >= 1) && (y2 <= height)
			step9;
			seep10;
			setp11;
		else
			r=0;
			g=0;
			b=0;
		end
		```
	
	* step 9: calculate weight wa, wb. Notice that if x1=x2 or y1=y2, function "wa=()/(x1-x2)" will be fail. At this situation, you need to assign a value to wa directly.
	
		```
		if x1 == x2
        	wa = 1/2;
        else
            wa = (x_old-x1)/(x2-x1);
        end
            
        if y1 == y2
            wb = 1/2;
        else
            wb = (y_old-y1)/(y2-y1);
        end
		```
		
	* step 10: calculate weight w1, w2 w3, w4 for 4 neighbor pixels.
	
		```
		w1 = (1-wa)*(1-wb);
		w2 =     wa*(1-wb);
		w3 =     wa*wb;
		w4 = (1-wa)*wb;
		```
	* step 11: calculate r,g,b with 4 neighbor point and their weight.
	
		```
		r = R(y1,x1)*w1+R(y1,x2)*w2+R(y2,x2)*w3+R(y2,x1)*w4;
		g = G(y1,x1)*w1+G(y1,x2)*w2+G(y2,x2)*w3+G(y2,x1)*w4;
		b = B(y1,x1)*w1+B(y1,x2)*w2+B(y2,x2)*w3+B(y2,x1)*w4;
		```

## Installation

* Other required packages.  
-None.  
* How to compile from source?  
-Put all source files under the same folder, excute my_lab5.m

### Results

|Original|GrayScale|Flip|Rotation(pi/3,clockwise)|
|---|---|---|---|
|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/image.jpg?raw=true)|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/results/my_grey.jpg?raw=true)|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/results/my_flip.jpg?raw=true)|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/results/my_rotation.jpg?raw=true)|
|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/image2.jpg?raw=true)|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/results/my_grey2.jpg?raw=true)|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/results/my_flip2.jpg?raw=true)|![](https://github.com/DevilSu/DSP_Lab_HW0/blob/master/results/my_rotation2.jpg?raw=true)|
