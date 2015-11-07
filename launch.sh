#! /bin/bash

aws ec2 run-instances --image-id $1 --count $2 --instance-type $3 --key-name $4 --security-group-ids $5 --subnet-id $6 --iam-instance-profile Name=phpdeveloperRole --associate-public-ip-address --user-data file:itmpo-544-444-env/install-webserver.sh --debug

aws elb create-load-balancer --load-balancer-name itmo544isu-lb --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-935e14f6 --security-groups sg-201e9f44

sleep 30

InstanceIDArray=(`aws ec2 describe-instances --output table | grep InstanceId | sed "s/|//g" | sed "s/ //g" | sed "s/InstanceId//g"`)

aws elb register-instances-with-load-balancer --load-balancer-name itmo544isu-lb --instances ${InstanceIDArray[@]}

aws elb configure-health-check --load-balancer-name itmo544isu-lb --health-check Target=HTTP:80/index.html,Interval=30,UnhealthyThreshold=2,HealthyThreshold=2,Timeout=3

DnsNameArray=(`aws ec2 describe-instances --output table | grep -m 1 PublicDnsName | sed "s/|//g" | sed "s/ //g" | sed "s/PublicDnsName//g"`)


sleep 300

ELBURL=(`aws elb create-load-balancer --load-balancer-name itmo544isu-lb --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-935e14f6 --security-groups sg-201e9f44 --output=text`);
firefox ELBURL

aws autoscaling create-launch-configuration --launch-configuration-name itmo544-444-lc --image-id ami-5189a661 --key-name itmo544-444-USneha-Mac  --security-groups sg-201e9f44 --instance-type t2.micro --user-data file:itmpo-544-444-env/install-webserver.sh --iam-instance-profile phpdeveloperRole

aws autoscaling create-auto-scaling-group --auto-scaling-group-name itmo544-444-asg --launch-configuration-name itmo544-444-lc --load-balancer-names itmo544isu-lb  --health-check-type ELB --min-size 3 --max-size 6 --desired-capacity 3 --default-cooldown 600 --health-check-grace-period 120 --vpc-zone-identifier subnet-935e14f6


# creating db subnet group

aws rds create-db-subnet-group --db-subnet-group-name mp1 --db-subnet-group-description "group for mp1" --subnet-ids subnet-935e14f6 subnet-3a6b034d


#aws rds wait db-instance-available --db-instance-identifier isu-db


mapfile -t dbInstanceARR < <(aws rds describe-db-instances --output json | grep "\"DBInstanceIdentifier" | sed "s/[\"\:\, ]//g" | sed "s/DBInstanceIdentifier//g" )
if [ ${#dbInstanceARR[@]} -gt 0 ]
   then
   echo "Deleting existing RDS database-instances"
   LENGTH=${#dbInstanceARR[@]}

      for (( i=0; i<${LENGTH}; i++));
      do
      if [ ${dbInstanceARR[i]} == "isu-db" ]
     then
      echo "db exists"
     else
      aws rds create-db-instance --db-instance-identifier isu-db --db-instance-class db.t1.micro --engine MySQL --master-username controller --master-user-password ilovebunnies --allocated-storage 10
      fi
     done
fi


aws rds wait db-instance-available --db-instance-identifier isu-db

php setup.php

echo "ALL DONE with DB"
#aws rds wait db-instance-available --db-instace-identifier isu-db

#./testdbcreate.sh







                                                              
