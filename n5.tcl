set myns [new Simulator]

set myTraceFile [open out5.tr w]
$myns trace-all $myTraceFile

set myNamFile [open out5.nam w]
$myns namtrace-all $myNamFile

proc finish { } {
                 global myns myTraceFile myNamFile
                 $myns flush-trace
                 close $myTraceFile
                 close $myNamFile 
exec nam out5.nam &
                 exec awk -f n5.awk out5.tr &
                 exit 0
 }

set topo [new Topography]
$topo load_flatgrid 2000 2000]

$myns namtrace-all-wireless $myNamFile 2000 2000
$myns node-config -adhocRouting AODV \
                  -llType LL \
                  -macType Mac/802_11 \
                  -ifqType Queue/DropTail \
                  -ifqLen 50 \
                  -phyType Phy/WirelessPhy \
                  -channelType Channel/WirelessChannel \
                  -propType Propagation/TwoRayGround \
                  -antType Antenna/OmniAntenna \
                  -topoInstance $topo \
                  -agentTrace ON \
                  -routerTrace ON
 create-god 4
  
set n0 [$myns node] 
set n1 [$myns node] 
set n2 [$myns node] 
set n3 [$myns node]  
  
$n0 label "tcp0" 
$n1 label "sink1/tcp1" 
$n2 label "sink2" 
$n3 label "sink2/tcp2" 
  
$n0 set X_ 60 
$n0 set Y_ 60 
$n0 set Z_ 0   
  
$n1 set X_ 120 
$n1 set Y_ 60 
$n1 set Z_ 0  
  
$n2 set X_ 60 
$n2 set Y_ 100 
$n2 set Z_ 0 
  
$n3 set X_ 120 
$n3 set Y_ 120 
$n3 set Z_ 0 
     
$myns at 0.01 "$n0 setdest 50 50 0"
$myns at 0.01 "$n1 setdest 160 160 0"
$myns at 0.01 "$n2 setdest 100 100 0"
$myns at 0.01 "$n3 setdest 70 70 0"
  
  
set tcp1 [new Agent/TCP]
$myns attach-agent $n0 $tcp1
  
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
  
set sink1 [new Agent/TCPSink]
$myns attach-agent $n1 $sink1 
  
$myns connect $tcp1 $sink1
  
set tcp2 [new Agent/TCP]
$myns attach-agent $n2 $tcp2
  
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
   
set sink2 [new Agent/TCPSink]
$myns attach-agent $n3 $sink2
  
$myns connect $tcp2 $sink2
  
$myns at .5 "$ftp1 start"
$myns at 5 "$ftp2 start"
  
$myns at 29 "$ftp1 stop"
$myns at 29 "$ftp2 stop"
  
$myns at 30 "finish"
  
$myns run
  
  
  
  
                         
