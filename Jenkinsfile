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
        stage('Git Checkout') {                   # checks out the code from the Git repository 
            steps {
                git branch: 'main', url: 'https://github.com/itkarank/java-project.git'
            }
        }
        
        stage('COMPILE') {                       # Maven is used to compile the Java code
            steps {
                sh "mvn clean compile -DskipTests=true"
            }
        }
        
        stage('Sonarqube Analysis') {               # static code analysis using SonarQube
            steps {
                sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.url=http://54.159.121.84:9000/ -Dsonar.login=squ_74bfb21266469eaf271d83e5f123820d19b38f13 -Dsonar.projectName=Shopping-Cart \
                   -Dsonar.java.binaries=. \
                   -Dsonar.projectKey=Shopping-Cart '''
            }
        }
        
        stage('Build') {                             #  builds the project using Maven
            steps {
                sh "mvn clean package -DskipTests=true"
            }
        }
        
        stage('Docker Build & Push') {                 # the application will build as a Docker image and then it will be pushed to Dockerhub       
            steps {
                script {
                    withDockerRegistry(credentialsId: 'e8442a03-f89f-46d7-853e-ca9d84d501d0', toolName: 'java-project') {
                        sh "docker build -t java-project -f docker/Dockerfile ."
                        sh "docker tag java-project karan143/java-project:latest"
                        sh "docker push karan143/java-project:latest"
                    }
                }
            }
        }    
        
        stage('Docker Deploy to Container') {
            agent { label 'Production-server' }                      #  Deploys the Docker image to a container on the Production-server
            steps {
                script {
                    
                    sh "docker run -d --name java-project -p 8070:8070 karan143/java-project:latest"
                    
                }
            }
        }
    }
}
