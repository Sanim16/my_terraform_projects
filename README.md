# terraform
my terraform scripts for deploying a Highly available and highly scalable 3-tier application architecture.


A single Nat Gateway is currently used however this will be changed to a NAt gateway per AZ to improve availability


On the presentation and application tier servers run the following code with other user data

The last route tables commented out and the other 2 nat gateways yet to be deployed.

I also need to build an app to run on the system.

The Database address, user name and password along with the private load balancer dns are passed to the userdata script dynamically through the templatefile function 