set ns [new Simulator]

set trfile [open out3.tr w]
set namfile [open out3.nam w]

$ns trace-all $trfile
$ns namtrace-all $namfile

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

$ns make-lan "$n0 $n1 $n2 $n3 $n4" 1Mb 10ms LL Queue/DropTail Mac/802_3

$ns make-lan "$n5 $n6 $n7 $n8 $n9" 1Mb 10ms LL Queue/DropTail Mac/802_3

$ns duplex-link $n4 $n5 1Mb 30ms DropTail
$ns duplex-link-op $n4 $n5 orient right-down

$n0 label "TCP"
$n2 label "UDP"
$n7 label "SINK"
$n9 label "NULL"

$ns color 1 blue
$ns color 2 red

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
$tcp0 set class_ 2

set sink0 [new Agent/TCPSink]
$ns attach-agent $n7 $sink0

set udp0 [new Agent/UDP]
$ns attach-agent $n2 $udp0
$udp0 set class_ 1

set null0 [new Agent/Null]
$ns attach-agent $n9 $null0

$ns connect $tcp0 $sink0
$ns connect $udp0 $null0

set cbr0 [new Application/Traffic/CBR]

$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0


set ftp0 [new Application/FTP]

$ftp0 set packetSize_ 500
$ftp0 attach-agent $tcp0

$ns at 0.1 "$cbr0 start"
$ns at 1.0 "$ftp0 start"
$ns at 9.0 "$ftp0 stop"
$ns at 9.5 "$cbr0 stop"
$ns at 10.0 "Finish"

proc Finish {} {
	global ns trfile namfile
	
	$ns flush-trace
	close $trfile
	close $namfile

	exec nam out3.nam &
	exec awk -f n3.awk out3.tr &
	exit 0
}

set error [new ErrorModel]
$ns lossmodel $error $n4 $n5
$error set rate_ 0.10
$ns set datarate_ 5 Mb

$ns run

