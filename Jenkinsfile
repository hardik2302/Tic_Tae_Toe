pipeline {
    agent any

    environment {
        SONARQUBE = 'SonarQube' // Name of your SonarQube server
        SONAR_TOKEN = credentials('SonarQube-Secret') // Use Jenkins credentials for the SonarQube token
    }

    stages {
        stage('Git Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/hardik2302/Tic_Tae_Toe']])
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    // Ensure sudo access, and use a virtual environment for python dependencies
                    sh 'sudo apt-get update && sudo apt-get install -y python3-numpy'
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    def SCANNER_HOME = tool 'SonarQube Scanner';
                    sh 'which sonar-scanner || echo "SonarQube Scanner not found"'
                    withSonarQubeEnv(SONARQUBE) {
                        sh '$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=tic_tae_toe -Dsonar.sources=main.py'
                    }
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }
    }
}
