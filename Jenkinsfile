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
                sh "docker build -t vungdv/calculator ."
            }
        }
        stage("Docker push") {
            steps {
               sh "docker push vungdv/calculator"
            }
        }
    }
}