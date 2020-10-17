f = imread('E:\研究生\研一\上半学年\图像处理\图片\ori_image.PNG');
f1 = histeq(f,256);
figure,imhist(f1);
title('第一次直方图均衡')
g = histeq(f1,256);
figure,imhist(g);
title('第二次直方图均衡')


