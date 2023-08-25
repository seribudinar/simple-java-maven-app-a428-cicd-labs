node {
    withDockerContainer(args: '-v /root/.m2:/root/.m2', image: 'maven:3.9.3-eclipse-temurin-17-alpine') {
        checkout scm

        stage('Build') {
            sh 'mvn -B -DskipTests clean package'
            echo 'Build Successfull'
        }

        stage('Test') {
            try {
                sh 'mvn test'
                echo 'Test Successfull'
            } catch (e) {
                currentBuild.result = 'FAILURE'
            }
        }

        stage('Post') {
            if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
                echo 'Post Successfull'
                junit 'target/surefire-reports/*.xml'
            }
        }

        stage('Deliver') {
            sh './jenkins/scripts/deliver.sh'
            echo 'Deliver Successfull, End'
        }
    }

    withDockerRegistry(credentialsId: 'docker-hub-cred', toolName: 'myDocker', url: 'https://hub.docker.com/') {
        withEnv([
        'DOCKERHUB_CREDENTIALS = credentials("docker-hub-cred")',
        'REMOTE_SERVER = "18.141.186.62"',
        'REMOTE_USER = "ubuntu"',
        'dockerImage = ""']) {
        }

        stage('Build Docker Image') {
            dockerImage = sh 'docker build -t simple-java-maven:latest  .'
            docker.withRegistry( '', DOCKERHUB_CREDENTIALS) {
                dockerImage.push()
            }
            sh 'docker tag simple-java-maven seribudinar/simple-java-maven:latest'
        }

        // Login to DockerHub before pushing the docker Image
        stage('Login to DockerHub') {
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        }

        // Push image to DockerHub registry
        stage('Push Image to Dockerhub') {
            sh 'docker push seribudinar/simple-java-maven:latest'
            sh 'docker logout'
        }

        stage('Deploy') {
            sshagent(['ec2-cred']) {
                sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} 'docker stop simple-java-maven || true && docker rm simple-java-maven || true'"
                sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} 'docker pull seribudinar/simple-java-maven'"
                sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} 'docker run --name simple-java-maven -d -p 8081:8081 seribudinar/simple-java-maven'"
            }
        }
    }
}
