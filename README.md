### Deploy ELK Cluster with Ansible

build status: [![Build Status](https://travis-ci.org/danitfk/Cluster-ELK-Ansible.svg?branch=master)](https://travis-ci.org/danitfk/Cluster-ELK-Ansible)

# Requirements
Before running the `Cluster-ELK-Ansible` tool you have to do these steps:
## 1. At least 3 node
A best practice to determine this number is to use the following formula to decide this number: N/2 + 1. N is the number of master eligible nodes in the cluster. You then round down the result to the nearest integer.
Nodes requirements:
* Distro: CentOS 7 
* Accessible with SSH (Port can be customized)
* SSH Key must be imported (Client Public key must be imported on nodes)
* Proper Internet connection (Due to using the package manager to install dependencies and software, the Internet would be fine on nodes)
* Python package installed `yum install python -y`
* **RECOMMENDED** Install Development Tools `yum groupinstall "Development Tools" -y` 
## 2. Ansible
You have to install Ansible on the client, which system you want to run the playbook.
On every machine which has python, you can install ansible easily with `python pip`.
**Linux (Debian/Ubuntu/CentOS/Redhat/Fedora/etc..):**
```
pip install ansible
```
Otherwise, you can check Ansible documentation for further information: [How to install ansible]( https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## 3. Create inventory file
To deploy the ELK Cluster with `Cluster-ELK-Ansible` you have to create an Ansible inventory with the proper format. 
There some variables in inventory file and It's important to declare them correctly.
**Variables in inventory file**
* **ansible_host** eg: `ansible_host=172.20.16.11` Instance IP Address (Ansible will connect to the ansible_host SSH) 
* **ansible_port** eg: `ansible_port=22` Instance SSH Port,
* **es_cluster_name** eg: `es_cluster_name=MyClusterName` The name of your cluster
* **es_node_name**  eg: `es_node_name=ELK-01` Node name of Elastic Cluster
* **es_cluster_node** eg: `es_cluster_node=master` There two types of elastic node type. **master** and **data**. Usually you have to have 1 master node and other nodes should be data nodes.You can find more details in bellow.
* **elasticsearch** eg: `elasticsearch=true` When you set the elasticsearch variable to `true` this service will be installed on that instance and you have declare above variables which start with **es_**. If you set elasticsearch variable to `false` it will not install the service on that instance no need to declare mentioned variables which start with **es_**.
* **logstash** eg: `logstash=true` If you set the logstash variable `true` it will be installed on the instance neither if you set the variable to `false` it will not.
* **kibana** eg: `kibana=true` If you set the kibana variable `true` it will be installed on the instance neither if you set the variable to `false` it will not.

**Master nodes** -> in charge of cluster-wide management and configuration actions such as adding and removing nodes

**Data nodes** -> stores data and executes data-related operations such as search and aggregation

For Master nodes, you don't need large amounts of memory of RAM, because it only manages the configuration in cluster-wide but in Data node which responsible for keeping the data you need larger memory of RAM.

**A Fine inventory file looks like this:**
```
[ELK_CLUSTER]
ELK-01 ansible_host=172.20.6.11 ansible_user=root elasticsearch=true logstash=false kibana=false es_node_name=ELK-01 es_cluster_node=data es_cluster_name=MY_LITTLE_CLUSTER
ELK-02 ansible_host=172.20.6.12 ansible_user=root elasticsearch=true logstash=false kibana=false es_node_name=ELK-02 es_cluster_node=data es_cluster_name=MY_LITTLE_CLUSTER
ELK-03 ansible_host=172.20.6.13 ansible_user=root elasticsearch=true logstash=false kibana=false es_node_name=ELK-03 es_cluster_node=data es_cluster_name=MY_LITTLE_CLUSTER
ELK-04 ansible_host=172.20.6.14 ansible_user=root elasticsearch=true logstash=true kibana=false es_node_name=ELK-04 es_cluster_node=master es_cluster_name=MY_LITTLE_CLUSTER
ELK-05 ansible_host=172.20.6.15 ansible_user=root elasticsearch=false logstash=false kibana=true nginx=true haproxy=true 


```
Without the proper inventory file deployer script will not execute or may cause crashes.
