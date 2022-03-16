# Architecture
***<ins>Etcd</ins>***
***<ins>Etcd</ins>*** : Etcd  is a database that stores information in a key value format. 

 

Kube-Scheduler: It identifies the right node to place the container on based on the container's resource requirements, the worker node's capacity or any other policies or constraints such as taints and tolerations, node affinity rules  that are on them. 

 

Node Controller: Takes care of the node. They are responsible for onboarding new nodes to the cluster, Handling situations when the node goes down. 

 

Replication Controller: It ensures that the desired number of containers are running at all times in a replication group.  

 

Kube API Server: The Kube API Server is a the primary management component of a Kubernetes cluster. It is responsible for orchestrating all operations within the cluster. It exposes the Kubernetes API which is used by the external users to perform management operations on the cluster as well as the various controllers to monitor the state of the cluster and make necessary changes as required. It is also used by the worker nodes to communicate with the servers.  

 

Container Runtime Engine: Docker or Rocket or Containerd. 

 

Kubelet: This is an agent that runs on each node in a cluster. It listens for the instruction from the Kube API Server and performs the actions(Deploy/Destroy/Modify) as required. The Kube API Server periodically fetches the status report from the Kubelet to monitor the status of the nodes and the containers on them. 

 

Kube-Proxy :  It ensures that the necessary rules are in place on the worker nodes to allow the containers running on them to communicate with each other.  

 

To summarize: 

 

Master Node has the below components: 

 

ETCD  

Kube API Server 

Kube-Scheduler 

Kube Controller Manager 

Container Runtime Engine. 

 

Worker Node has the below components: 

 

Container Runtime Engine 

Kubelet 

Kube-Proxy 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 