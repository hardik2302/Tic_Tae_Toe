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
                    // Ensure pip is installed and install dependencies in a virtual environment
                    sh 'python3 -m venv venv || python -m venv venv'  // Create virtual environment
                    sh './venv/bin/pip install --upgrade pip || venv\\Scripts\\pip install --upgrade pip'  // Upgrade pip to ensure latest version
                    sh './venv/bin/pip install numpy || venv\\Scripts\\pip install numpy'  // Install numpy
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
