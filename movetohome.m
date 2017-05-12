%This function moves the robot to its predefined 'home' location by
%sending signals through the arduino.

function movetohome(a)
Phome = [4.06,3,1.8,2.38]; %Pot readings for waist, shoulder, elbow, wrist home positions

%Move wrist to home position
if readVoltage(a,'A0')<Phome(4)-0.05
    writeDigitalPin(a,'D9',0);
    writeDigitalPin(a,'D10',1);
    while readVoltage(a,'A0')<Phome(4)-0.05
        if readVoltage(a,'A0')>=Phome(4)-0.05
           break
        end
    end
    writeDigitalPin(a,'D9',1);
    writeDigitalPin(a,'D10',1);    
elseif readVoltage(a,'A0')>Phome(4)+0.05
    writeDigitalPin(a,'D10',0);
    writeDigitalPin(a,'D9',1);
    while readVoltage(a,'A0')>Phome(4)+0.05
        if readVoltage(a,'A0')<=Phome(4)+0.05
           break
        end
    end
    writeDigitalPin(a,'D9',1);
    writeDigitalPin(a,'D10',1);
end

%Move shoulder to home position
if readVoltage(a,'A3')<Phome(2)-0.05
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',1);
    while readVoltage(a,'A3')<Phome(2)-0.05
        if readVoltage(a,'A3')>=Phome(2)-0.05
           break
        end
    end
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);    
elseif readVoltage(a,'A3')>Phome(2)+0.05
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D3',1);
    while readVoltage(a,'A3')>Phome(2)+0.05
        if readVoltage(a,'A3')<=Phome(2)+0.05
           break
        end
    end
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);
end


%Move elbow to home position
if readVoltage(a,'A2')<Phome(3)-0.05
    writeDigitalPin(a,'D8',0);
    writeDigitalPin(a,'D7',1);
    while readVoltage(a,'A2')<Phome(3)-0.05
        if readVoltage(a,'A2')>=Phome(3)-0.05
           break
        end
    end
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',1);    
elseif readVoltage(a,'A2')>Phome(3)+0.05
    writeDigitalPin(a,'D7',0);
    writeDigitalPin(a,'D8',1);
    while readVoltage(a,'A2')>Phome(3)+0.05
        if readVoltage(a,'A2')<=Phome(3)+0.05
           break
        end
    end
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',1);
end
%Move waist to home position
if readVoltage(a,'A4')<Phome(1)-0.05
    writeDigitalPin(a,'D5',0);
    writeDigitalPin(a,'D6',1);
    while readVoltage(a,'A4')<Phome(1)-0.05
        if readVoltage(a,'A4')>=Phome(1)-0.05
           break
        end
    end
    writeDigitalPin(a,'D5',1);
    writeDigitalPin(a,'D6',1);    
elseif readVoltage(a,'A4')>Phome(1)+0.05
    writeDigitalPin(a,'D6',0);
    writeDigitalPin(a,'D5',1);
    while readVoltage(a,'A4')>Phome(1)+0.05
        if readVoltage(a,'A4')<=Phome(1)+0.05
           break
        end
    end
    writeDigitalPin(a,'D6',1);
    writeDigitalPin(a,'D5',1);
end


end