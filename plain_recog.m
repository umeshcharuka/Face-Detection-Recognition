
identified_person='';
trainingFeatures=[];
people={'Umesh','Kasun','Prasad','Unknown'};

TrainDatabasePath = strcat('Face_database');
trainingLabels=[]; 
labels=[];
[m,A,Eigenfaces,trainfilenames,File_Numbers] = CreateDatabase(TrainDatabasePath,people);
disp('Database Loaded successfully.....');

ProjectedImages = [];
Train_Number11 = size(Eigenfaces,2);
for k = 1 : Train_Number11
    temp = Eigenfaces'*A(:,k); 
    ProjectedImages = [ProjectedImages temp]; 
end
trainingFeatures=ProjectedImages';


for j=1:size(trainingFeatures,1)
   trainingLabels(j,1)=0;
end

k=0;
for i=1:length(people)
   trainingLabels(k+1:k+File_Numbers(1,i),1)=i;
   k=k+File_Numbers(1,i);

end

[fname,pname] = uigetfile('*.*','Select the input image file');
            filename = sprintf('%s%s',pname,fname); 
            inp_image=imread(filename);
            imshow(inp_image);           
            faceDetector = vision.CascadeObjectDetector();
            facebox = step(faceDetector,inp_image);
            Nface=size(facebox,1);
    if (Nface>0)
        for n=1:Nface
                
    %                 figure,imshow(inp_image); hold on
    %                 rectangle('position',facebox(1,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');              
    %                     title('Face Detection')
    %                     hold off;        
            Face_im=imcrop(inp_image,facebox(n,:));

    %                 figure,imshow(Face_im); 

              figure,imshow(inp_image); hold on
             rectangle('position',facebox(n,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');              
                         title('Face Detection')
                          hold off;  
            imshow(Face_im);

            I=Face_im;

            I = imresize(I,[100 100]);

            temp =rgb2gray(I);
            [irow icol] = size(temp);
            InImage = reshape(temp',irow*icol,1);
            Difference = double(InImage)-m; % Centered test image

            ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
            test_vector=ProjectedTestImage';
             pred = multisvm( trainingFeatures,trainingLabels,test_vector )

             identified_person{n}=people{pred}
              if (strcmp(identified_person{n},'unknown'))
                 filename11=[TrainDatabasePath,'/','unknown/','unknown.jpg'];
                 imwrite(Face_im_org,filename11);

             end
             
             
            %         message1 = sprintf('\tFace Recognition System');
            %         message2=sprintf('\n Welcome: %s',identified_person);
                    if(n<Nface)
                         print('Press any key to recognise next person');
                     pause();
                    end
            %  message=sprintf('%s%s',message1,message2);
            % h=msgbox(message);
        end
    else
                disp('No Face Detected!! Try again!!');
               set(handles.edit2, 'String', 'No Face Detected!! Try again!!');
 
    end