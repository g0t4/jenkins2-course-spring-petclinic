pipeline {
	agent any
	tools {
        maven 'M3_HOME' 
    }
	stages {
		stage('Checkout') {
			steps{
				git credentialsId: 'gitcred', url: 'https://github.com/akmaharshi/petclinic.git'
			}
		}
		stage('Build') {
			steps{
				sh label: '', script: 'mvn clean package'
			}
		}
		
		stage('Parallel Stage') {
			parallel {
				stage('Push Artifact to Nexus') {
					steps{
						nexusArtifactUploader artifacts: [[artifactId: 'spring-petclinic', classifier: '', file: 'target/petclinic.war', type: 'war']], credentialsId: 'nexuscred', groupId: 'org.springframework.samples', nexusUrl: 'localhost:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'snapshots', version: '4.2.6-SNAPSHOT'
					}
				}
				stage('Archive') {
					steps{
						archiveArtifacts 'target/*.?ar'
					}
				}
				stage('Test Results') {
					steps{
						junit 'target/surefire-reports/*.xml'
					}
				}
			}
		}
	}
	post {
		failure {
			notify('Failed')
		}
		success {
			notify('Success')
		}
		aborted {
			notify('Aborted')
		}
	}

}

def notify (status) {
	emailext (
		body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""", 
		subject: "${status}:Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'", 
		to: 'anilmaharshi.p@gmail.com'
	)
}
