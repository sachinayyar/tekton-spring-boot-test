#! /usr/bin/env groovy

pipeline {

  agent any

  tools {
    jdk 'java-17'
    maven 'maven 3.8.6'
  }

  stages {
    stage('Build') {
      steps {
        echo 'Building..'
        
        sh 'mvn clean package -DskipTests=true'
      }
    }
    stage("Docker build"){
      steps{
        script{
        withDockerRegistry(credentialsId: 'd192f063-bef2-4ad2-a796-fd652dc6676e', toolName: 'docker' ) {
        // sh 'sudo docker version'
        sh 'docker build -t ayyarsachin/first-demo-project .'
        sh 'docker image list'
        sh 'docker tag  ayyarsachin/first-demo-project ayyarsachin/first-demo-project:dev'
        sh 'docker push ayyarsachin/first-demo-project:dev'
        }
     }
    }
    }
    stage('Deployment in DEV ENV') {
      steps {
        echo 'Deployment...'
        sh 'docker rmi ayyarsachin/first-demo-project:dev'
        sh 'docker pull ayyarsachin/first-demo-project:dev'
        echo 'deleting the previous container.....'
        sh 'docker rm devcontainer'
        sh 'docker run -d --name devcontainer -p 8084:8080 ayyarsachin/first-demo-project:dev'
      }
    }
    stage('Image tag to prod env') {
      steps {
        echo 'tagging....'
        sh 'docker tag ayyarsachin/first-demo-project:dev ayyarsachin/first-demo-project:prod'
        sh 'docker push ayyarsachin/first-demo-project:prod'
      }
    }
    stage('Deployment in PROD ENV') {
      steps {
        echo 'Deployment...'
        sh 'docker rmi ayyarsachin/first-demo-project:prod'
        sh 'docker pull ayyarsachin/first-demo-project:prod'
        echo 'deleting previous running container'
        sh 'docker rm prodcontainer'
        sh 'docker run -d --name sachin -p 8084:8080 ayyarsachin/first-demo-project:prod'
      }
    }
    
//        script {
//
//          openshift.withCluster() { 
//  openshift.withProject("test-project") {
//  
//    def buildConfigExists = openshift.selector("bc", "codelikethewind").exists() 
//    
//    if(!buildConfigExists){ 
//      openshift.newBuild("--name=codelikethewind", "--docker-image=registry.redhat.io/jboss-eap-7/eap74-openjdk8-openshift-rhel7", "--binary") 
//    } 
//  
//    openshift.selector("bc", "codelikethewind").startBuild("--from-file=target/simple-servlet-0.0.1-SNAPSHOT.war", "--follow") } }
//
//       }
//      }
//    }


       
  }
}
