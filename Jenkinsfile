pipeline {
    agent any
    stages {
        stage("Compile") {
            steps {
                sh "./gradlew compileJava --status"
            }
        }       
        stage("Unit test") {
            steps {
                sh "./gradlew test"
            }
        }
        stage("Code coverage") {
            steps {
                sh "./gradlew jacocoTestReport"
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: "JaCoCo Report"
                ])
            }
        }
        stage("Static code analysis") {
            steps {
                sh "./gradlew checkstyleMain"
            }
        }
        stage("Package") {
            steps {
                sh "./gradlew build"
            }
        }
        stage("Docker build") {
            steps {
                sh "docker version"
                sh "docker build -t vungdv/calculator ."
            }
        }
        stage("Docker push") {
            environment {
                docker_usr = credentials("dockerhub-username")
                docker_psw = credentials("dockerhub-pass")
            }
            steps {
               sh 'docker login -u $docker_usr -p $docker_psw'
               sh "docker push vungdv/calculator"
            }
        }
        stage("Deploy to staging") {
            steps {
                sh "docker-compose up -d"               
            }
        }
        stage("Acceptance test") {
            steps {
                sleep 5
                sh "chmod +x ./acceptance_test.sh"
                sh "./acceptance_test.sh"
            }
        }
    }
    post {
        always {
            sh "docker-compose down"
        }
    }
}