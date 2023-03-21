List<String> checks = []
List<String> projects = []
def check_script_name = "pipeline-check.sh"
def py_requirements = ["requirements.txt", "requirements-check.txt"]

def pip(args) {
    def pip = "python3 -m pip --trusted-host artifactory.gold.mgmt.carezen.net"
    return sh("${pip} ${args} | grep -v 'already satisfied'")
}

pipeline {
    agent any
    //triggers {
    //    cron "H 23 * * *"
    //}
    options {
        timestamps()
        ansiColor("xterm")
        disableConcurrentBuilds()
        buildDiscarder(
            logRotator(
                numToKeepStr:'30',
                artifactNumToKeepStr: '1'
            )
        )
    }
    stages {
        stage('checkout') {
            steps {
                checkout scm
            }
        }

        stage('changes') {
            steps {
                script {
                    def compare_to = env.GIT_BRANCH == "main" ? "HEAD~1" : "remotes/origin/${env.CHANGE_TARGET}";
                    def changed = sh(
                        script: "git diff --name-only  ${compare_to} ${env.GIT_COMMIT}",
                        returnStdout: true).split("\n")
                    echo "changed files: \n - ${changed.join('\n - ')}"

                    projects = changed.findAll { item ->
                        item.split('/').size() > 0
                    }.collect { item ->
                        item.split('/')[0]
                    }.unique()
                    echo "changed projects: \n - ${projects.join('\n - ')}"

                    checks = projects.findAll { item ->
                        fileExists item + "/" + check_script_name
                    }
                }
            }
        }

        stage('checks') {
            when {
                expression { checks.size() > 0 }
            }
            environment {
                TEMP_DIR = sh(script: "mktemp -d", returnStdout: true)
            }
            steps {
                script {
                    dir(env.TEMP_DIR) {
                        sh "virtualenv venv"
                        // add 'set +x' to activate script, otherwise
                        // output in jenkins is too verbose
                        //sh "sed -i '1s/^/set +x\\n/' venv/bin/activate"
                        sh "#!/bin/sh -e\n . venv/bin/activate"
                    }

                    checks.each { project ->
                        dir(project) {
                            py_requirements.each { item ->
                                if (fileExists(item)) {
                                    pip("install -r ${item}")
                                }
                            }
                            sh "./${check_script_name}"
                            echo "OK: ${project}"
                        }
                    }
                }
            }
            post {
                always{
                    dir(env.TEMP_DIR) {
                        echo "rm: ${env.TEMP_DIR}"
                        deleteDir()
                    }
                }
            }
        }
        stage('build') {
            when {
                expression { projects.size() > 0 }
            }
            steps {
                script {
                    projects.each { project ->
                        sh "./build.sh ${project}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs(
                cleanWhenNotBuilt: false,
                deleteDirs: true,
                disableDeferredWipeout: true,
                notFailBuild: true)
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
