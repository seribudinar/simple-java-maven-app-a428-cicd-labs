node {
    withDockerContainer(args: '-v /root/.m2:/root/.m2', image: 'maven:3.9.0') {
        stage('Build') {
            checkout scm
            sh 'mvn -B -DskipTests clean package'
        }
        stage('Test') {
            checkout scm
            sh 'mvn test'
            junit 'target/surefire-reports/*.xml'
        }
        stage('Deliver') {
            checkout scm
            sh './jenkins/scripts/deliver.sh'
        }
    }
}
