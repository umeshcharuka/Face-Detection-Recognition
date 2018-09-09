[fname,pname] = uigetfile('*.*','Select the input image file');
filename = sprintf('%s%s',pname,fname); 
inp_image=imread(filename);

faceDetector = vision.CascadeObjectDetector();
facebox = step(faceDetector,inp_image);
Nface=size(facebox,1);
figure,imshow(inp_image); hold on
if (Nface>0)
    longest = (facebox(1,1) - facebox(1,3)) + (facebox(1,2) - facebox(1,4));
    facebox_max = facebox(1,:);
    for n=1:Nface
        rectangle('position',facebox(n,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');
        if ((facebox(n,1) - facebox(n,3)) + (facebox(n,2) - facebox(n,4)) > longest)
            longest = (facebox(n,1) - facebox(n,3)) + (facebox(n,2) - facebox(n,4))
            facebox_max = facebox(n,:);
        end
    end
end

hold off;

I=imcrop(inp_image,facebox_max);

I = imresize(I,[100 100]);

temp =rgb2gray(I);