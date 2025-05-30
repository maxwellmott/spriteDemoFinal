num = instance_number(unlockAlert) - 1;

x = camera.x - (guiWidth / 2) + 12;
y = camera.y - (guiHeight / 2) + (40 + (40 * num));

alpha = 1.0;

fadingOut = false;

alarm[0] = 90;

type = player.unlockAlertList[| num];