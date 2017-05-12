%This function takes the coordinates of the block centroid from the camera
%frame and returns the joint angles required for the end effector to
%reach and grab the block. The X,Y input coordinates are in terms of camera
%pixels while the Z is in units of length. The X,Y pixel values are
%converted to length units before solving for joint angles. ID = 1
%represents a pick up operation and ID = 2 represents the stacking
%operation

function Theta = InvKin(locationXYZ,ID)
% %Distances between base frame and camera frame in mm
Xdist = 270;
Ydist = -10;
Zdist = 660;
% %Distances of block centroid in camera frame, in mm
 if ID == 1  %Pick-up operation angles
     depth = double(locationXYZ(3));
     ppmm = (1.151e-10*depth^4)-(2.426e-7*depth^3)+(0.0001964*depth^2)-(0.07612*depth)+13.8; %Pixels per mm w.r.t depth from camera
     dx = (double(locationXYZ(1))-double(320))/double(ppmm); %Block X centroid w.r.t camera frame in mm
     dy = double((locationXYZ(2)-240)/ppmm); %Block Y centroid w.r.t camera frame in mm
     dz = double(locationXYZ(3)); %Block Z centroid w.r.t camera frame in mm
     
     Hendeff_cam = [0 0 1 dx; -0.7071 -0.7071 0 dy; 0.7071 -0.7071 0 dz; 0 0 0 1]; %Block  w.r.t camera
     Hcam_base = [0 -1 0 Xdist; -1 0 0 Ydist; 0 0 -1 Zdist;0 0 0 1]; %Cam  w.r.t base
     Hobj_0 = Hcam_base*Hendeff_cam; %end effector with respect to base
     
     %Applying compensation to X,Y,Z values to overcome calibration and
     %measurement errors
     Xcomp = [70,17,3,17,23]; %Measured X compensation values for chosen 5 block locations
     Ycomp = [40,8,-7,-22,-38]; %Measured Y compensation values for chosen 5 block locations
     Zcomp = [6,0,-6,0,0];%Measured Z compensation values for chosen 5 block locations
     for x = Xcomp(2):Xcomp(end)
         Hobj_0(1,4) = Hobj_0(1,4)+x;
     end
     for y = Ycomp(2):Ycomp(end)
         if Hobj_0(2,4)<0
            Hobj_0(2,4) = Hobj_0(2,4)+y;
         else 
            Hobj_0(2,4) = Hobj_0(2,4);
         end
     end
     for z = Zcomp(2):Zcomp(end)
         Hobj_0(3,4) = Hobj_0(3,4)+z;
     end
     elseif ID == 2  %Drop operation angles
      X = locationXYZ(1)+15; % +15 for compensation
      if locationXYZ(2)<0
        Y = locationXYZ(2)+15;%-15 for compensation
      else
        Y = locationXYZ(2)-15;%-15 for compensation
      end
      Z = locationXYZ(3)-6; %-6 for compensation
      Hobj_0 = [0.7071,0.7071,0,X;0,0,-1,Y;-0.7071,0.7071,0,Z;0,0,0,1]; 
 end
     
%Link lengths in mm (Link1 is assumed to be 0)
r1 = 0;
r2 = 90;
r3 = 120;
r4 = 80;

Robj_0 = Hobj_0(1:3,1:3);  %Rotation matrix
Oobj_0 = Hobj_0(1:3,4);  %Translation vector
O3_0 = Oobj_0 - r4*(Robj_0*[1;0;0]); %Wrist center w.r.t base frame (x_c,y_c,z_c)
Theta1 = atan2(O3_0(2),O3_0(1)); %Waist angle = atan2(y_c,x_c)
r = sqrt(O3_0(1)^2+O3_0(2)^2); %r = sqrt(x_c^2+y_c^2)
s = O3_0(3)-r1; %s = z_c
c3 = (r^2+s^2-r2^2-r3^2)/(2*r2*r3); %cos(Theta3)
D = c3;
Theta3 = atan2(-sqrt(1-D^2),D); %Elbow angle
s3 = sin(Theta3);
Theta2 = atan2(s,r)-atan2(r3*s3,r2+r3*c3); %Shoulder angle
Theta4 = asin((Oobj_0(3)-s)/r4); %Wrist angle

%Setting limits for joint angles
if rad2deg(Theta1)<-70 || rad2deg(Theta1)>70 ...
    ||rad2deg(Theta2)<5||rad2deg(Theta2)>130 ...
    ||rad2deg(Theta3)<-130||rad2deg(Theta3)>45 ...
    ||rad2deg(Theta4)<-57||rad2deg(Theta4)>57
    error('Object location is outside workspace!');
end
Theta =[Theta1,Theta2,Theta3,Theta4]; %Theta values are returned
end