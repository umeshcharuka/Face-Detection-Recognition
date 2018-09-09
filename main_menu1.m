function main_menu1()
s=[100 100];

while (1==1)
 
    choice=menu('Face Recognition System Create database ',...
                'Capture and detect face from Webcam ',...
                'Detect Face From Image ',...
                'Exit');
            
    if (choice ==1)
           
                I= getcam();
                prompt1={'Enter Person Name ','Enter file number for this person'};
                title1='Enter Person Name '; 
                answer1=inputdlg(prompt1,title1);
                person_name = answer1{1};
                num = answer1{2};
                facefilename=['Face_database/',person_name,'/',person_name,num,'.jpg'];
                filename1=['images/',person_name,'/',person_name,num,'.jpg'];
                
                 folder_name=['Face_database/',person_name];
                folder_name1=['images/',person_name];
                if ~exist(folder_name,'dir')
                    mkdir(folder_name);
                end
                
                 if ~exist(folder_name1,'dir')
                    mkdir(folder_name1);
                end
            if (~isempty(I))                       
            imwrite(I,filename1);
            figure,imshow(I);         
            faceDetector = vision.CascadeObjectDetector();
            facebox = step(faceDetector, I);
            Nface=size(facebox,1);
            if (Nface>0)
                longest = (facebox(1,3) * facebox(1,4));
                facebox_max = facebox(1,:);
                for n=1:Nface
                    %rectangle('Parent',handles.axes1,'position',facebox(n,:),'LineWidth',5,'LineStyle','-','EdgeColor','b'); 
                    if ((facebox(n,3) * facebox(n,4)) > longest)
                        longest = (facebox(n,3) * facebox(n,4))
                        facebox_max = facebox(n,:);
                    end
                end
                figure,imshow(I); hold on
                rectangle('position',facebox_max,'LineWidth',5,'LineStyle','-','EdgeColor','b');              
                    title('Face Detection')
                    hold off;        
                Face_im=imcrop(I,facebox_max);
%                 imresize(Face_im,s);
                imwrite(Face_im,facefilename);
                figure,imshow(Face_im);           
                
            else
                disp('No Face Detected!! Try again!!');
            end
            
            
            end
            
            
     
      
    end
        if(choice==2)
           [fname,pname] = uigetfile('*.*','Select the input face image file');
            filename = sprintf('%s%s',pname,fname); 
%              face_image(filename);
                I=imread(filename);
                    figure,imshow(I); 
                prompt1={'Enter Person Name ','Enter file number for this person'};
                title1='Enter Person Name '; 
                answer1=inputdlg(prompt1,title1);
                person_name = answer1{1};
                num = answer1{2};
                facefilename=['Face_database/',person_name,'/',person_name,num,'.jpg'];
                folder_name=['Face_database/',person_name];
                folder_name1=['images/',person_name];
                if ~exist(folder_name,'dir')
                    mkdir(folder_name);
                end
                
                 if ~exist(folder_name1,'dir')
                    mkdir(folder_name1);
                end
                filename1=['images/',person_name,'/',person_name,num,'.jpg'];
            if (~isempty(I))                       
            imwrite(I,filename1);
                
            faceDetector = vision.CascadeObjectDetector();
            facebox = step(faceDetector, I);
            Nface=size(facebox,1);
            if (Nface>0)
                longest = (facebox(1,3) * facebox(1,4));
                facebox_max = facebox(1,:);
                for n=1:Nface
                    %rectangle('Parent',handles.axes1,'position',facebox(n,:),'LineWidth',5,'LineStyle','-','EdgeColor','b'); 
                    if ((facebox(n,3) * facebox(n,4)) > longest)
                        longest = (facebox(n,3) * facebox(n,4))
                        facebox_max = facebox(n,:);
                    end
                end
                figure,imshow(I); hold on
                rectangle('position',facebox_max,'LineWidth',5,'LineStyle','-','EdgeColor','b');              
                    title('Face Detection')
                    hold off;        
                Face_im=imcrop(I,facebox_max);
                imwrite(Face_im,facefilename);
                figure,imshow(Face_im);           
                
            else
                disp('No Face Detected!! Try again!!');
            end
            
            
            end           
        end
    if (choice == 3)
        
        clear choice 
%          close all;      
        return;
    end  
        
    
    
end

end
