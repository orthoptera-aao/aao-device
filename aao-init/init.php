<?php

$quick_start = TRUE;

print "[aao-device] Starting initialistaion with file $argv[1]\n";

$file = file_get_contents($argv[1]);
$json = json_decode($file, true);

print "\n\nThis device is part of the ".$json["project"]["name"]." project.\n";
print "Enquiries should be directed to ".$json["project"]["contact"].".\n";
print "\n";
print "This device (".$json["device"]["name"].") is managed by ".$json["device"]["contact"].".\n";
print "It should be at this location: ".$json["location"]["name"].".\n\n";

if ($quick_start !== TRUE) {
  print "Device will go into run mode in 5 seconds, press Ctrl+C to quit to terminal.\n";
  sleep(5);
}

print_r($json);
