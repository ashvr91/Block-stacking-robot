%This function performs a pick and stack operation for 3 blocks in the
%robot workspace. The robot moves to a 'home' position after each pick-up
%and stack operation.

function RobotControl()
a = arduino('com3','Mega2560');
blockheight = 15;
for i =0:2
    movetohome(a);%Moves to home position
    centroidXYZ = getClosestBlock();%Returns X,Y,Z coordinates of block in camera frame
    Thetapickup = InvKin(centroidXYZ,1);%Returns joint angles for pick-up location
    pickupblock(a,Thetapickup);%Picks up block based on joint angles
    movetohome(a);
    droppointXYZ = [120-0.5*i,180-0.5*i,i*blockheight+5];%Predefined stack location coordinates
    Thetadrop = InvKin(droppointXYZ,2);%Returns joint angles for stack location
    dropblock(a,Thetadrop);%Drops block at stack location
end
end




