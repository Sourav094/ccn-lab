BEGIN{
cbrPkt=0;
tcpPkt=0;
}
{
	if(($1 == "r")&&($5 == "cbr")){
		cbrPkt = cbrPkt +1;
	}
	if(($1 == "r")&&($5 == "tcp")&&($4 == 3)){
		tcpSent = tcpSent + 1;
	}
	if(($1 == "r")&&($5 == "ack")&&($4 == 0)){
		tcpRecv = tcpRecv + 1;
	}
}
END {
	printf "\nNo. of CBR packets being sent %d",cbrPkt;
	printf "\nNo. of TCP packets being sent %d",tcpSent;
	printf "\nNo. of ACK packets being received %d",tcpRecv;
}
