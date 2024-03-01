pipeline {
    agent any
    tools{
        jdk  'jdk11'
        maven  'maven3'
    }
    
    environment{
        SCANNER_HOME= tool 'sonar-scanner'
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main',url: 'https://github.com/itkarank/java-project.git'
            }
        }
        
        stage('COMPILE') {
            steps {
                sh "mvn clean compile -DskipTests=true"
            }
        }
        
        stage('Sonarqube Analysis') {
            steps {
                   sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.url=http://54.159.121.84:9000/ -Dsonar.login=squ_74bfb21266469eaf271d83e5f123820d19b38f13 -Dsonar.projectName=Shopping-Cart \
                   -Dsonar.java.binaries=. \
                   -Dsonar.projectKey=Shopping-Cart '''
            }
        }
        
        stage('Build') {
            steps {
                sh "mvn clean package -DskipTests=true"
            }
        }
        
        stage('Docker Build & Push') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'e8442a03-f89f-46d7-853e-ca9d84d501d0', toolName: 'java-project') {
                        
                        sh "docker build -t java-project -f docker/Dockerfile ."
                        sh "docker tag  java-project karan143/java-project:latest"
                        sh "docker push karan143/java-project:latest"
                    }
                }
            }
        }    
        
        stage('Docker Deploy to Container') {
            steps {
                script {
                withDockerRegistry(credentialsId: 'e8442a03-f89f-46d7-853e-ca9d84d501d0', toolName: 'java-project') {
                    sh "docker run -d --name java-project -p 8070:8070 karan143/java-project:latest" }
                }
                
            }
        }
    }
}
