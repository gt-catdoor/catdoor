
current_stat = ''

if (current_stat == 'lockdown' || 'onlyletout'):
	nosend
else:
	if (intruder_detected):
		nosend
	else:
		sendopen()



		