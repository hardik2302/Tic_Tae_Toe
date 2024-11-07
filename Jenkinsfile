pipeline{
	agent any
	
	environment {
        SONARQUBE = 'SonarQube' // This should be the name of your SonarQube server in Jenkins
        SONAR_TOKEN = credentials('SonarQube-Secret') // Use Jenkins credentials for the SonarQube token
    }
	
	stages{
		stage('Git Checkout'){
			steps{
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

		stage('SonarQube Analysis'){
			steps{
				script {
                    withSonarQubeEnv(SONARQUBE) {
                        sh 'sonar-scanner -Dsonar.projectKey=tic_tae_toe -Dsonar.sources=main.py'
                    }
                }
			}
		}
		stage('Quality Gate') {
            steps {
                script {
                    // Wait for the SonarQube Quality Gate status
                    timeout(time: 1, unit: 'HOURS') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }
	}
}
