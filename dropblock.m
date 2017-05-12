function dropblock(a,Thetadrop)
Pdrop = zeros(1,4);
% Slope = zeros(1,4);
Thetamin = [-pi/4,0,-3*pi/4,-pi/3]; %Minimum thetas for waist, shoulder, elbow, wrist
Pmin = [4.9218,4.9413,0.1515,3.4604]; %Minimum pot values for waist, shoulder, elbow, wrist

Slope = [-1.06,-1.06,1.06,-1.06];
for i = 1:4
%     Slope(i) = (Pmax(i)-Pmin(i))/(Thetamax(i)-Thetamin(i));
    Pdrop(i)=Pmin(i)+Slope(i)*(Thetadrop(i)-Thetamin(i));
end

%Move waist to block drop position
if readVoltage(a,'A4')<Pdrop(1)-0.05
    writeDigitalPin(a,'D5',0);
    writeDigitalPin(a,'D6',1);
    while readVoltage(a,'A4')<Pdrop(1)-0.05
        if readVoltage(a,'A4')>=Pdrop(1)-0.05
           break
        end
    end
    writeDigitalPin(a,'D5',1);
    writeDigitalPin(a,'D6',1);    
elseif readVoltage(a,'A4')>Pdrop(1)+0.05
    writeDigitalPin(a,'D6',0);
    writeDigitalPin(a,'D5',1);
    while readVoltage(a,'A4')>Pdrop(1)+0.05
        if readVoltage(a,'A4')<=Pdrop(1)+0.05
           break
        end
    end
    writeDigitalPin(a,'D5',1);
    writeDigitalPin(a,'D6',1);
end

%Move shoulder to block pick-up position
if readVoltage(a,'A3')<Pdrop(2)-0.05
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',1);
    while readVoltage(a,'A3')<Pdrop(2)-0.05
        if readVoltage(a,'A3')>=Pdrop(2)-0.05
           break
        end
    end
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);    
elseif readVoltage(a,'A3')>Pdrop(2)+0.05
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D3',1);
    while readVoltage(a,'A3')>Pdrop(2)+0.05
        if readVoltage(a,'A3')<=Pdrop(2)+0.05
           break
        end
    end
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);
end
%Move elbow to block pick-up position
if readVoltage(a,'A2')<Pdrop(3)-0.05
    writeDigitalPin(a,'D8',0);
    writeDigitalPin(a,'D7',1);
    while readVoltage(a,'A2')<Pdrop(3)-0.05
        if readVoltage(a,'A2')>=Pdrop(3)-0.05
           break
        end
    end
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',1);    
elseif readVoltage(a,'A2')>Pdrop(3)+0.05
    writeDigitalPin(a,'D7',0);
    writeDigitalPin(a,'D8',1);
    while readVoltage(a,'A2')>Pdrop(3)+0.05
        if readVoltage(a,'A2')<=Pdrop(3)+0.05
           break
        end
    end
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',1);
end

%Move wrist to block pick-up position
if readVoltage(a,'A0')<Pdrop(4)-0.05
    writeDigitalPin(a,'D9',0);
    writeDigitalPin(a,'D10',1);
    while readVoltage(a,'A0')<Pdrop(4)-0.05
        if readVoltage(a,'A0')>=Pdrop(4)-0.05
           break
        end
    end
    writeDigitalPin(a,'D9',1);
    writeDigitalPin(a,'D10',1);    
elseif readVoltage(a,'A0')>Pdrop(4)+0.05
    writeDigitalPin(a,'D10',0);
    writeDigitalPin(a,'D9',1);
    while readVoltage(a,'A0')>Pdrop(4)+0.05
        if readVoltage(a,'A0')<=Pdrop(4)+0.05
           break
        end
    end
    writeDigitalPin(a,'D9',1);
    writeDigitalPin(a,'D10',1);
end

%Open claw
if readVoltage(a,'A1')<1.52
    writeDigitalPin(a,'D11',0);
    writeDigitalPin(a,'D12',1);
    while readVoltage(a,'A1')<1.52
        if readVoltage(a,'A1')>=1.52
           break
        end
    end
    writeDigitalPin(a,'D11',1);
    writeDigitalPin(a,'D12',1);
end
end

