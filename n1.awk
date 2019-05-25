BEGIN{
cbrPkt=0;
tcpPkt=0;
}
{
	if(($1 == "r")&&($5 == "cbr")){
		cbrPkt = cbrPkt +1;
	}
	if(($1 == "d")&&($5 == "tcp")){
		tcpPkt = tcpPkt + 1;
	}
}
END {
	printf "\nNo. of CBR packets being dropped %d",cbrPkt;
	printf "\nNo. of TCP packets being dropped %d",tcpPkt;
}
