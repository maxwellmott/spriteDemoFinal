ds_list_delete(player.unlockAlertList, num);

if (instance_count > 1) {
	with (unlockAlert) {
		num -= 1;	
	}
}