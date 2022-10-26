pipeline {
    agent any
    //triggers {
    //    cron "H 23 * * *"
    //}
    options {
        timestamps()
        ansiColor("xterm")
        disableConcurrentBuilds()
    }
    stages {
        stage('build') {
            steps {
                sh "env"
                // sh "./build.sh"
            }
        }
    }
    post {
        cleanup {
            cleanWs(deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true)
        }
    }
}
