pipeline {
	agent any
	tools {
        maven 'M3_HOME' 
    }
	stages {
    	stage('Build') {
			steps {
				sh label: '', script: 'mvn clean package -Dmaven.test.skip=true'
			}
    	}
		stage('Parallel Stage') {
			parallel {
				stage('Nexus') {
					steps {
						nexusArtifactUploader artifacts: [[artifactId: 'spring-petclinic', classifier: '', file: 'target/petclinic.war', type: 'war']], credentialsId: 'nexusCred', groupId: 'org.springframework.samples', nexusUrl: '3.92.210.17:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'releases', version: "4.2.${BUILD_NUMBER}"
					}
				}
				stage('Archival') {
					steps {
						archiveArtifacts 'target/petclinic.war'
					}
				}
			}
		}
		stage('Deploy') {
			steps {
				sh label: '', script: 'ansible-playbook --ask-vault-pass site.yml -i hosts'
			}
    	}
    } 
}
