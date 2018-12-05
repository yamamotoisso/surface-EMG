function picshow( picnumber )

switch picnumber
    case 1
        picname = 'picture\WF.png';
    case 2
        picname = 'picture\WE.png';
    case 3
        picname = 'picture\FC.png';
    case 4
        picname = 'picture\PS.png';
    case 0
        picname = 'picture\RT.png';
end
pic = imread(picname);
figure(2);
imshow(pic,'InitialMagnification','fit');
title('Recognition Gesture Result');

switch picnumber
    case 1
        xlabel('WF');
    case 2
        xlabel('WE');
    case 3
        xlabel('FC');
    case 4
        xlabel('PS');
    case 0
        xlabel('RT');
end
set(gca,'FontSize',20,'FontWeight','bold');
pause(1);
close(figure(2));
end

