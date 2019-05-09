# What is Continuous Integration?
Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible
- At a regular frequency (ideally at every commit), the system is:

-- **Integrated:** All changes up until that point are combined into the project

-- **Built:** The code is compiled into an executable or package

-- **Tested:** Automated test suites are run

-- **Archived:** Versioned and stored so it can be distributed as is, if desired

-- **Deployed:** Loaded onto a system where the developers can interact with it

## Benefits
- Immediate bug detection 
- No integration step in the lifecycle
- A deployable system at any given point 
- Record of evolution of the project 

## Tools

- **Code Repositories:** SVN, Mercurial and Git
- **Continuous Build Systems:** Jenkins, Bamboo and Cruise Control
- **Test Frameworks:** JUnit,Cucumber and CppUnit
- **Artifact Repositories:** Nexus, Artifactory and Archiva

# What is Continuous Delivery?
Continuous Delivery (CD) is a practice of automating the entire software release process. The idea is to do CI, plus automatically prepare and track a release to production. The desired outcome is that anyone with sufficient privileges to deploy a new release can do so at any time in one or a few clicks. By eliminating nearly all manual tasks, developers become more productive.

The continuous delivery process typically includes at least one manual step of approving and initiating a deploy to production. 

# What is Continuous Deployment?
Continuous Deployment is a step up from Continuous Delivery in which every change in the source code is deployed to production automatically, without explicit approval from a developer. A developer’s job typically ends at reviewing a pull request from a teammate and merging it to the master branch. A CI/CD service takes over from there by running all tests and deploying the code to production, while keeping the team informed about outcome of every important event.

Continuous deployment requires a highly developed culture of monitoring, being on call, and having the capacity to recover quickly.


# What is Jenkins?
Jenkins is a Continuous Integration (CI) server or tool which is written in java. It provides Continuous Integration services for software development, which can be started via command line or web application server.

## Why Jenkins?
- Jenkins is a highly configurable system by itself
- Installation is easier.
- It is easy to create new Jenkins plugin if one is not available.
- It is a tool which is written in Java. Hence it can be portable to almost all major platforms.
- It’s easy to write plugins
- The additional community developed plugins provide even more flexibility 
- By combining Jenkins with Ant, Gradle, or other Build Automation tools, the possibilities are limitless

## What can Jenkins do?
- Generate test reports 
- Integrate with many different Version Control Systems 
- Push to various artifact repositories 
- Deploys directly to production or test environments
- Notify stakeholders of build status...and more

## How Jenkins works - Setup
- When setting up a project in Jenkins, out of the box you have the following general options:
-- Associating with a version control server 
-- Triggering builds
--- Polling, Periodic, Building based on other projects 
-- Execution of shell scripts, bash scripts, Ant targets, and Maven targets 
-- Artifact archival 
-- Publish JUnit test results and Javadocs
-- Email notifications
- As stated earlier, plugins expand the functionality even further 

## How Jenkins works - Building
- Once a project is successfully created in Jenkins, all future builds are automatic
- Building 
-- Jenkins executes the build in an executer
--- By default, Jenkins gives one executer per core on the build server
-- Jenkins also has the concept of slave build servers
--- Useful for building on different architectures 
--- Distribution of load

## How Jenkins works - Reporting
- Jenkins comes with basic reporting features 
-- Keeping track of build status 
--- Last success and failure 
--- “Weather” – Build trend 
- These can be greatly enhanced with the use of pre-build plugins
-- Unit test coverage 
-- Test result trending
-- Findbugs, Checkstyle and PMD 

# Install Jenkins
To install Jenkins on your Ubuntu system, follow these steps:
## Install Java
To add the PPA which contains Java, run the commands below
```
$ sudo add-apt-repository ppa:webupd8team/java
```
Update the apt packages

```
$ sudo apt-get update
```
Install Java

```
$ sudo apt-get install -y openjdk-8-jdk
```

## Install Jenkins
To add jenkins PPA in system

```
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```
Update the apt packages

```
$ sudo apt-get update
```
Install Jenkins

```
$ sudo apt-get install -y jenkins
```
The default Jenkins run on port **8080**. If your server already has other services share the same port as Tomcat. You can edit __/etc/default/jenkins__ configuration file and update **HTTP_PORT** value to **8081** or something else..

```
HTTP_PORT=8080
```
and restarted Jenkins service after making changes

```
$ sudo service jenkins restart
```
## Setting up Jenkins
Open your browser and browse to the server hostname or IP address followed by port **# 8080**

http://localhost:8080

When you that, you’ll get a prompt to enter the initial admin password… run the commands below to view it on the system…

```
$ cat /var/lib/jenkins/secrets/initialAdminPassword
```
Copy and paste it into the field and continue with the setup… Install all plugins… and wait for the process to complete… after that you’ll create an admin account and complete the installation.

# What is Jenkins Pipeline?
Pipeline is a combination of plugins that support the integration and implementation of continuous delivery pipelines using Jenkins. A pipeline has an extensible automation server for creating simple or complex delivery pipelines "as code," via pipeline DSL (Domain-specific Language).

A continuous delivery pipeline is an automated expression of your process for getting software from version control right through to your users and customers.

Jenkins Pipeline provides an extensible set of tools for modeling simple-to-complex delivery pipelines "as code". The definition of a Jenkins Pipeline is typically written into a text file (called a Jenkinsfile) which in turn is checked into a project’s source control repository.

## What is Jenkinsfile?
Jenkins pipelines can be defined using a text file called JenkinsFile. You can implement pipeline as code using JenkinsFile, and this can be defined by using a domain specific language (DSL). With JenkinsFile, you can write the steps needed for running a Jenkins pipeline.

Benefits
- You can create pipelines automatically for all branches and execute pull requests with just one JenkinsFile.
- You can review your code on the pipeline
- You can audit your Jenkins pipeline
- This is the singular source for your pipeline and can be modified by multiple users.

JenkinsFile can be defined by either Web UI or with a JenkinsFile.

There are two types of syntax used for defining your JenkinsFile.

1.Declarative

2.Scripted

**Declarative:**
Declarative pipeline syntax offers an easy way to create pipelines. It contains a predefined hierarchy to create Jenkins pipelines. It gives you the ability to control all aspects of a pipeline execution in a simple, straight-forward manner.

**Scripted:**
Scripted Jenkins pipeline runs on the Jenkins master with the help of a lightweight executor. It uses very few resources to translate the pipeline into atomic commands. Both declarative and scripted syntax are different from each other and are defined totally differently.

Example Jenkinsfile:

```
// Declarative //
pipeline {
  agent any ①
  stages {
  stage('Build') { ②
  steps { ③
  sh 'make' ④
  }
  }
  stage('Test'){
  steps {
  sh 'make check'
  junit 'reports/**/*.xml' ⑤
  }
  }
  stage('Deploy') {
  steps {
  sh 'make publish'
  }
  }
  }
}
// Script //
node {
  stage('Build') {
  sh 'make'
  }
  stage('Test') {
  sh 'make check'
  junit 'reports/**/*.xml'
  }
  stage('Deploy') {
  sh 'make publish'
  }
}
```
**1.agent** indicates that Jenkins should allocate an executor and workspace for this part of the
Pipeline.

**2.stage** describes a stage of this Pipeline.

**3.steps** describes the steps to be run in this **stage**

**4.sh** executes the given shell command

**5.junit** is a Pipeline step provided by the plugin:junit[JUnit plugin] for aggregating test reports.

## Why use Jenkin's Pipeline?
Jenkins is an open continuous integration server which has the ability to support the automation of software development processes. You can create multiple automation jobs with the help of use cases, and run them as a Jenkins pipeline.

Here are the reasons why you use should use Jenkins pipeline:

- Jenkins pipeline is implemented as a code which allows multiple users to edit and execute the pipeline process.
- Pipelines are robust. So if your server undergoes an unforeseen restart, the pipeline will be automatically resumed.
- You can pause the pipeline process and make it wait to resume until there is an input from the user.
- Jenkins Pipelines support big projects. You can run multiple jobs, and even use pipelines in a loop.

## Pipeline terms
**Pipeline:** The pipeline is a set of instructions given in the form of code for continuous delivery and consists of instructions needed for the entire build process. With pipeline, you can build, test, and deliver the application.

**Step:** A single task; fundamentally steps tell Jenkins what to do. For example, to execute the shell
command **make** use the **sh** step: **sh 'make'**. When a plugin extends the Pipeline DSL, that typically
means the plugin has implemented a new step.

**Node:** The machine on which Jenkins runs is called a node. A node block is mainly used in scripted pipeline syntax.

**Stage:** A stage block contains a series of steps in a pipeline. That is, the build, test, and deploy processes all come together in a stage. Generally, a stage block is used to visualize the Jenkins pipeline process.

## Install Build Pipeline Plugin in Jenkins
1. The settings for the plugin can be found under **Manage Jenkins > Manage Plugins.**

   If you have already installed the plugin, it is shown under the installed tab.

2. If you do not have the plugin previously installed, it shows up under the **Available** tab.

   Once you have successfully installed the build pipeline plugin in your Jenkins, follow these steps to create your Jenkins pipeline:

## How to Create Jenkins Pipeline
Once you are logged in to your Jenkins dashboard:

- Click on the **"+"** button on the left-hand side of your Jenkins dashboard to create a pipeline.
- You will be asked to give a name to the pipeline view.
-- Select **Build a pipeline view** under **options**
-- Click **ok**
-  In the next page, you will be asked for some more details to configure your Jenkins pipeline. Just accept the default settings, and make sure you choose the first job under the settings.

   Click on **Apply** and then **OK.**

## Running a pipeline build
- For running a pipeline build, you need to chain your jobs first. For this, go to your first job and click on configure.
- Now, under **Build Triggers**, check the **Build after other projects are built** option.

  Thus, a chain for all your jobs has been created.

- Install the **Build Pipeline view** plugin if you don't have it installed already.
- Go to your Jenkins dashboard and create a view by clicking on the **"+"** button. Select the **Build Pipeline View** option and click **OK.**
- Under **Pipeline view configuration**, locate **Pipeline Flow.**

  Under **Pipeline flow**, select the initial job to run. Now choose the job which has chains to other jobs. So, one by one, the jobs will run in the pipeline.

  When the Jenkins pipeline is running, you can check its status with the help of Red and Green status symbols. Red means the pipeline has failed, while green indicates success.

## Running Jenkins pipeline
Click on **Run** to run the Jenkins pipeline.






