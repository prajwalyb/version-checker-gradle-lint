pipeline {
    agent any
    
    stages {
        
        stage('Build Bundle') {
            steps {
                echo 'Building'
                script {
                    
                    sh "./gradlew  bundleRelease"
                }
            }
        }
    }
}
