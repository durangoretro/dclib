pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
			RESCOMP = ../fun_rescomp/target/rescomp.jar
			make clean all
                '''
            }
        }
    }
}

