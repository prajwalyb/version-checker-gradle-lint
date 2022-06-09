pipeline {
    agent { dockerfile true }
    
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
