%%Read in a file from RAS Aero II
%Has to be saved as txt
clc; clear all; close all;
rocket_no = 2;
addpath(['C:\Users\SeverinBeger\Documents\Uni\Master\Auslandssemester\Rocketry Club\My Code\Rockets\Rocket',num2str(rocket_no)]); %adds in the folder with necessary functions etc

file = fopen("FlightTest_Data.txt");
% file = fopen("FlightTest_Data.csv");
numlines = 0;

while(1)
    outp = fgetl(file);
    if(outp == -1)
        break;
    end
    numlines = numlines+1;
end
fclose(file);

file = fopen("FlightTest_Data.txt");
header = fgetl(file);

header_vars = CSVStringUnpack(header);
num = length(header_vars);

%first line read out
line1 = fgetl(file);
vars_l1 = CSVStringUnpack(line1);

dec = zeros(1,num); %array showing the variables with a decimal
dec(1,13:14) = 1;
dec(1,21:22) = 1;

data_mat = zeros(numlines-1,num);

j = 0;
for i = 1:num
    j = j+1; %position in string array
    numstr = vars_l1(1,j);
    if(dec(i))
        j = j+dec(i);
        numstr = strcat(numstr,".",vars_l1(1,j));
    end
    data_mat(1,i) = str2double(numstr);
end

%dec for second line
dec(1,:) = 1;
zero_comp = [2,5,7,9,10,11];
dec(1,zero_comp) = 0;



l_data = 0; %represents the amount of numbers found in the string
l_data_arr = zeros(numlines-1,1);
motor_on = 1;
counter = 1;
line = fgetl(file);
while(line ~= -1)
    counter = counter + 1; %get the right line
    if(counter == 3)
        dec(1,9:10) = 1;
    end
%     if(counter == 771)
%         dec(1,num-1) = 0;
%     elseif(counter == 772)
%         dec(1,num-1) = 1;
%     end
    
    data_line = CSVStringUnpack(line);
    if(counter == 449)
        dec(1,13) = 0; %random value C_P whole number
    end
    if(motor_on&&counter == 583) %motor is off 
       %((length(data_line)==43)&&motor_on&&counter == 583)
        dec(1,8) = 0; %thrust only 0 from here
        motor_on = 0;
    elseif((l_data - length(data_line))==1) %altitude randomly a whole number
        dec(1,num-1) = 0;
    elseif((l_data - length(data_line))==-1)
        dec(1,num-1) = 1;
    end
    
    l_data = length(data_line);
    l_data_arr(counter-1) = l_data;
    %extract data
    j = 0;
    for i = 1:num
        j = j+1; %position in string array
        numstr = data_line(1,j);
        if(dec(i))
            j = j+dec(i);
            numstr = strcat(numstr,".",data_line(1,j));
        end
        data_mat(counter,i) = str2double(numstr);
    end

    line = fgetl(file);
    if(counter == 449)
        dec(1,13) = 1; %turn it back on
    end
    %data_mat = [data_mat;data_line];
end

fclose(file);

