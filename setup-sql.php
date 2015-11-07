<?php
// Start the session^M
require 'vendor/autoload.php';
$rds = new Aws\Rds\RdsClient([
    'version' => 'latest',
    'region'  => 'us-west-2'
]);


// Create a table 
$result = $rds->describeDBInstances([
    'DBInstanceIdentifier' => 'isu-db',
]);
print_r($result);
$endpoint = $result['DBInstances'][0]['Endpoint']['Address'];
print "============\n". $endpoint . "================\n";
print_r($endpoint);
//$endpoint = substr($endpoint,0,-5);
//print "================\n".$endpoint."===================\n";
$link = mysqli_connect($endpoint,"controller","ilovebunnies","customerrecords") or die("Error " . mysqli_error($link)); 
echo "Here is the result: " . $link;
$sql = "CREATE TABLE IF NOT EXISTS userData 
(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
uname  VARCHAR(32),
email VARCHAR(20),
phone VARCHAR(20),
s3rawurl VARCHAR(256),
s3finishedurl VARCHAR(256),
jpgfilename VARCHAR(255),
state TINYINT(3)
)";
#create_table = $link->query($sql);

if($sql){
echo "Table created and there are no errors";
else{
echo "ERROR!";
}
$link -> close();
?>
