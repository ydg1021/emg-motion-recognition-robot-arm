clear all;
mylego = legoev3('usb')
Left = motor(mylego,'A');
Lift_left = motor(mylego,'B');
Lift_right = motor(mylego,'C');
Right = motor(mylego,'D');

start(Left);
start(Lift_left);
start(Lift_right);
start(Right);


