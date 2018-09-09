clc;
clear all;
close all;
trainingFeatures=[];
people={'umesh','thiwanka','lakisuru'};
TrainDatabasePath = strcat('Face_database');
trainingLabels=[]; 
labels=[];
[m,A,Eigenfaces,trainfilenames,File_Numbers] = CreateDatabase(TrainDatabasePath,people);
disp('Database Loaded successfully.....');
ProjectedImages = [];
Train_Number11 = size(Eigenfaces,2);
for k = 1 : Train_Number11
    temp = Eigenfaces'*A(:,k); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
end
trainingFeatures=ProjectedImages';


for j=1:size(trainingFeatures,1)
   trainingLabels(j,1)=0;
end
    k=0; 
for i=1:length(people)
   


   
   trainingLabels(k+1:k+File_Numbers(1,i),1)=i;
%   labels(1:size(features,1))=i;
   k=k+File_Numbers(1,i);
   
%    trainingLabels=[trainingLabels;labels];
end

% SVMModel = svmtrain(trainingFeatures,trainingLabels);

[fname,pname] = uigetfile('*.*','Select the input image file');
            filename = sprintf('%s%s',pname,fname); 
%              face_image(filename);
                inp_image=imread(filename);
                                
               faceDetector = vision.CascadeObjectDetector();
            facebox = step(faceDetector,inp_image);
            Nface=size(facebox,1);
            if (Nface>0)
                figure,imshow(inp_image); hold on
                rectangle('position',facebox(1,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');              
                    title('Face Detection')
                    hold off;        
                Face_im=imcrop(inp_image,facebox(1,:));

                figure,imshow(Face_im); 
                
                
                I=Face_im;
                
                I = imresize(I,[100 100]);
  
temp =rgb2gray(I);
[irow icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
Difference = double(InImage)-m; % Centered test image

ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
test_vector=ProjectedTestImage';
 pred = multisvm( trainingFeatures,trainingLabels,test_vector )

 identified_person=people{pred}
  message1 = sprintf('\tFace Recognition System');
        message2=sprintf('\n Welcome: %s',identified_person);
        
        
 message=sprintf('%s%s',message1,message2);
h=msgbox(message);

       else
                disp('No Face Detected!! Try again!!');
 end
            