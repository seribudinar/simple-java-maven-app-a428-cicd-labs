node {
    withDockerContainer(args: '-v /root/.m2:/root/.m2', image: 'maven:3.9.0') {
        stage('Build') {
            sh 'mvn -B -DskipTests clean package'
        }
        stage('Test') {
            sh 'mvn test'
            junit 'target/surefire-reports/*.xml'
        }
        stage('Deliver') {
            sh './jenkins/scripts/deliver.sh'
        }
    }
}
