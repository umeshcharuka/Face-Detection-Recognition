function Face_im=detect_face_from_cam()

I= getcam();


faceDetector = vision.CascadeObjectDetector();
            facebox = step(faceDetector, I);
            Nface=size(facebox,1);
            if (Nface>0)
                figure,imshow(I); hold on
                rectangle('position',facebox(1,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');              
                    title('Face Detection')
                    hold off;        
                Face_im=imcrop(I,facebox(1,:));
%                 imresize(Face_im,s);
               
                figure,imshow(Face_im);           
                
            else
                disp('No Face Detected!! Try again!!');
            end



end