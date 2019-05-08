# What is Kubernetes?
Kubernetes is an open source orchestration system for Docker containers. It manages containerized applications across multiple hosts and provides basic mechanisms for deployment, maintenance, and scaling of applications.

Sometimes called kube and k8s (that's 'k' + 8 letters + 's')

# Kubernetes - Cluster Architecture
Single node kubernetes cluster

![33fe8f6a-3b1a-4d9d-af19-37c1f790734f-1](kubernetes/33fe8f6a-3b1a-4d9d-af19-37c1f790734f-1.jpg)

# Kubernetes core concepts

1. Master
2. Minion/Node
3. Pod
4. Replication Controller
5. Service
6. Lable
7. Namespace
8. Kubelet
9. Kube-proxy
10. etcd
11. Controller manager
12. Scheduler
13. API-server

***1.Cluster:*** A cluster is a collection of hosts storage and networking resources that Kubernetes uses to run the various workloads that comprise your system.

***2.Master:*** It is the central control point that provides a unified view of the cluster. There is a single master node that control multiple minions.

***3.Minion/Node:*** It is a worker node that run tasks as delegated by the master. Minions can run one or more pods. It provides an application-specific “virtual host” in a containerized environment.

***4.Pod:*** The smallest deployable units that can be created, scheduled, and managed. Its a logical collection of containers that belong to an application.

***5.Replication Controller:*** It is a resource at Master that ensures that requested number of pods are running on minions at all times.

***6.Service:*** It is an object on master that provides load balancing across a replicated group of pods.

***7.Label:*** It is an arbitrary key/value pair in a distributed watchable storage that the Replication Controller uses for service discovery.

***8.Namespace:*** A Namespace is a mechanism to partition resources created by users into a logically named group.

***9.Kubelet:*** Each minion runs services to run containers and be managed from the master.

***10.Kube-proxy:*** Kube-proxy provides basic load balancing and directs traffic destined for specific services to the proper pod on the backend.

***11.ETCD:*** It stores the configuration information which can be used by each of the nodes in the cluster. It is a high availability key value store that can be distributed among multiple nodes. It is accessible only by Kubernetes API server as it may have some sensitive information. It is a distributed key value Store which is accessible to all.

***12.API-server:*** Kubernetes is an API server which provides all the operation on cluster using the API. API server implements an interface, which means different tools and libraries can readily communicate with it. Kubeconfig is a package along with the server side tools that can be used for communication. It exposes Kubernetes API.

***13.Controller-manager:*** This component is responsible for most of the collectors that regulates the state of cluster and performs a task. In general, it can be considered as a daemon which runs in nonterminating loop and is responsible for collecting and sending information to API server.

***14.Scheduler:*** It is a service in master responsible for distributing the workload. It is responsible for tracking utilization of working load on cluster nodes and then placing the workload on which resources are available and accept the workload.

## Features of Kubernetes
1. Automatic Binpacking
2. Service Discovery & Load balancing
3. Storage Orchestration
4. Self-Healing
5. Secret & Configuration Management
6. Batch Execution 
7. Horizontal Scaling
8. Automatic Rollbacks & Rollouts


***1.Automatic Binpacking:*** Kubernetes automatically packages your application and schedules the containers based on their requirements and available resources while not sacrificing availability. To ensure complete utilization and save unused resources, Kubernetes balances between critical and best-effort workloads.

***2.Service Discovery & Load balancing:*** There is no need to worry about networking and communication because Kubernetes will automatically assign IP addresses to containers and a single DNS name for a set of containers, that can load-balance traffic inside the cluster. 

***3. Storage Orchestration:*** You can mount the storage system of your choice. You can either opt for local storage, or choose a public cloud provider such as GCP or AWS, or perhaps use a shared network storage system such as NFS, iSCSI, etc.

***4. Self-Healing:*** Kubernetes can automatically restart containers that fail during execution and kills those containers that don’t respond to user-defined health checks. But if nodes itself die, then it replaces and reschedules those failed containers on other available nodes.

***5. Secret & Configuration Management:*** Kubernetes can help you deploy and update secrets and application configuration without rebuilding your image and without exposing secrets in your stack configuration.

***6. Batch Execution:*** In addition to managing services, Kubernetes can also manage your batch and CI workloads, thus replacing containers that fail, if desired.

***7. Horizontal Scaling:*** Kubernetes needs only 1 command to scale up the containers, or to scale them down when using the CLI. Else, scaling can also be done via the Dashboard (kubernetes UI).

***8. Automatic Rollbacks & Rollouts:*** Kubernetes progressively rolls out changes and updates to your application or its configuration, by ensuring that not all instances are worked at the same instance. Even if something goes wrong, Kubernetes will rollback the change for you.

# Installation of Kubernetes on Ubuntu
## Prerequisites
### Install Docker

```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo apt-get update
$ sudo apt-get install -y docker-ce
$ sudo systemctl enable docker && sudo service docker restart
```
## Install Kubernetes

```
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
$ cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
$ sudo apt-get update
$ sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
```
Enable net.bridge.bridge-nf-call-iptables on all three nodes.

```
$ echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
$ sudo sysctl -p
```
Disable swap

```
$ sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
$ sudo swapoff -a
```
Setup a single node Kubernetes cluster

```
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Install the flannel networking plugin in the cluster by running this command on the Kube Master server.

```
$ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/a70459be0084506e4ec919aa1c114638878db11b/Documentation/kube-flannel.yml
```
We can check that the pod is up by running

```
$ sudo kubectl get pods --all-namespaces
```
which will display all the Pods.

```
NAMESPACE     NAME                              READY     STATUS    RESTARTS   AGE
kube-system   etcd-vps520050                    1/1       Running   0          1d
kube-system   kube-apiserver-vps520050          1/1       Running   0          1d
kube-system   kube-controller-manager-vps520050 1/1       Running   0          1d
kube-system   kube-dns-6f4fd4bdf-zpwjh          3/3       Running   0          1d
kube-system   kube-flannel-ds-9szb9             1/1       Running   0          1d
kube-system   kube-proxy-mgvg4                  1/1       Running   0          1d
kube-system   kube-scheduler-vps520050          1/1       Running   0          1d
```
Initialize single node cluster

```
$ sudo kubectl taint nodes --all node-role.kubernetes.io/master-
```
Verify that the cluster is up and running. On the Kube Master server,
check the list of nodes

```
$ sudo kubectl get nodes
```
# Deploy NGINX on the Kubernetes Cluster
A deployment is a logical reference to a pod or pods and their configurations.
1. From your master node __kubectl create__ an nginx deployment:
   ```
   $ sudo kubectl create deployment nginx --image=nginx
   ```
2. This creates a deployment called __nginx__. __kubectl get deployments__ lists all available deployments:
   ```
   $ sudo kubectl get deployments
   ```
3. Use __kubectl describe deployment nginx__ to view more information:
   ```
   $ sudo kubectl describe deployment nginx
   ```
4. Make the NGINX container accessible via the internet:
   ```
   $ sudo kubectl create service nodeport nginx --tcp=80:80
   ```
   This creates a public facing service on the host for the NGINX deployment. Because this is a nodeport deployment, kubernetes will assign this service a port on the host machine in the 32000+ range.
   
   Try to __get__ the current services:
   ```
   $ sudo kubectl get svc
   NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
   kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP        5h
   nginx        NodePort    10.98.24.29   <none>        80:32555/TCP   52s
   ```
5. Verify that the NGINX deployment is successful by using __curl__ on the slave node:
    ```
    $ sudo curl localhost:32555
    ```
    The output will show the unrendered “Welcome to nginx!” page HTML.
6. To remove the deployment, use __kubectl delete deployment__:
    ```
    $ sudo kubectl delete deployment nginx
    deployment "nginx" deleted
    $ sudo kubectl get deployments
    No resources found.
    ```


