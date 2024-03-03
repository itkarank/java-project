pipeline {
    agent any
    tools {
        jdk 'jdk11'
        maven 'maven3'
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    
    stages {
        stage('Git Checkout') {                   
            steps {
                git branch: 'main3', url: 'https://github.com/itkarank/java-project.git'
            }
        }
        
        stage('COMPILE') {                       // Maven is used to compile the Java code
            steps {
                sh "mvn clean compile -DskipTests=true"
            }
        }
        
        stage('Sonarqube Analysis') {               // static code analysis using SonarQube
            steps {
                sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.url=http://44.223.76.98:9000/ -Dsonar.login=squ_squ_ac48af98da172db0fcb1276edaa4a446d0608f2a -Dsonar.projectName=java-project \
                   -Dsonar.java.binaries=. \
                   -Dsonar.projectKey=java-project '''
            }
        }
        
        stage('Build') {                             //  builds the project using Maven
            steps {
                sh "mvn clean package -DskipTests=true"
            }
        }
        
        stage('Docker Build & Push') {                 // the application will build as a Docker image and then it will be pushed to Dockerhub       
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DOCKER_CRED', toolName: 'docker') {
                        sh "docker build -t java-project -f docker/Dockerfile ."
                        sh "docker tag java-project karan143/java-project:latest"
                        sh "docker push karan143/java-project:latest"
                    }
                }
            }
        }    
        
        stage('Docker Deploy to Container') {
            agent { label 'Production-server' }                      //  Deploys the Docker image to a container on the Production-server
            steps {
                script {
                    
                    sh "docker run -d --name java-project -p 8070:8070 karan143/java-project:latest"
                    
                }
            }
        }
    }
}
