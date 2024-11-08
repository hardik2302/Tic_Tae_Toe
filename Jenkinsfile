pipeline {
    agent any

    environment {
        // SONARQUBE = 'sonarqube' // Name of your SonarQube server
        // SONAR_TOKEN = credentials('SonarQube-Secret') // Use Jenkins credentials for the SonarQube token
        IMAGE_NAME = "hardikagrawal2320/Tic-Tae-Toe"
        VERSION_TAG = "${BUILD_NUMBER}" // Use Jenkins build number as version tag
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
                    def scannerHome = tool 'SonarScanner';
                    withSonarQubeEnv() {
                      sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
        // stage('Quality Gate') {
        //     steps {
        //         script {
        //             timeout(time: 1, unit: 'HOURS') {
        //                 waitForQualityGate abortPipeline: true
        //             }
        //         }
        //     }
        // }
        stage('Docker build') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        sh "docker build -t ${IMAGE_NAME}:${VERSION_TAG} ."
                    }
                }
            }
        }
        stage('Docker Push Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        sh "docker push ${IMAGE_NAME}:${VERSION_TAG}"
                    }
                }
            }
        }
    }
}
