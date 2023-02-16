pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
			make clean all RESCOMP=../fun_rescomp/target/rescomp.jar
                '''
            }
        }
    }
}

