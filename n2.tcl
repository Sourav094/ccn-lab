set ns [new Simulator]
set trfile [open out2.tr w]
set namfile [open out2.nam w]

$ns trace-all $trfile
$ns namtrace-all $namfile

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 label "TCP Source"
$n1 label "UDP Source"
$n2 label "router"
$n3 label "Sink/Null"

$ns color 1 blue
$ns color 2 red

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1.5Mb 10ms DropTail
$ns queue-limit $n2 $n3 10

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right



set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
$udp set fid_ 0



set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1


set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

$cbr set packetSize_ 1500
$cbr set interval_ 0.1

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ftp set maxPkts_ 1500
$ftp set packetSize_ 1500

$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"
$ns at 5.0 "finish"

proc finish { } {
global ns trfile namfile
$ns flush-trace
close $trfile
close $namfile
exec nam out2.nam &
exec awk -f n2.awk out2.tr &
exit 0
}

$ns run






