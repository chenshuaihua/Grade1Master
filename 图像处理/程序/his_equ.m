f = imread('E:\�о���\��һ\�ϰ�ѧ��\ͼ����\ͼƬ\ori_image.PNG');
f1 = histeq(f,256);
figure,imhist(f1);
title('��һ��ֱ��ͼ����')
g = histeq(f1,256);
figure,imhist(g);
title('�ڶ���ֱ��ͼ����')


