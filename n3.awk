BEGIN{
	totalPackets=0;
	totalBytes=0;
	time=0;
	tcpPktSize=0;
	cbrPktSize=0
	Throughput=0.0;
	simTime=0;
	startTime=0
	stopTime=0;
	cbrPktCnt=0;
	tcpPktCnt=0;
}
{
	event = $1
	time=$2
	appType = $5
	srcNode = $3
	dstNode=$4
	curPktSize=$6

	if((event=="+") && (srcNode=="4") && (dstNode=="5") && (appType=="tcp")) {
		tcpPktCnt++;
		tcpPktSize = curPktSize;
	}

	if((event=="+") && (srcNode=="4") && (dstNode=="5") && (appType=="cbr")) {
		cbrPktCnt++;
		cbrPktSize = curPktSize;
	}

	if(time < startTime) {
		startTime = time
	}

	if(time > stopTime) {
		stopTime = time
	}
}
END {
	totalBytes = (tcpPktCnt * tcpPktSize + cbrPktCnt * cbrPktSize);
	simTime = stopTime - startTime;
	Throughput = (totalBytes * 8.0)/(simTime*1000);
	totalPackets = tcpPKtCnt + cbrPktCnt;

	printf("\n TCP packet size = %d Bytes \n",tcpPktSize);
	printf("CBR packet size = %d Bytes \n",cbrPktSize);
	printf("TCP packet count = %d \n",tcpPktCnt);
	printf("CBR packet count = %d  \n",cbrPktCnt);
	printf("Total packets sent (node 4 to 5) = %d Packets \n",totalPackets);
	printf("Total Bytes sent (node 4 to 5) = %.3f Kb \n",totalBytes / 1000.0);
	printf("The simulation time is = %.3f sec\n",simTime);
	printf("The throughput = %d Kbps \n",Throughput);
	printf("\n\n");
}
