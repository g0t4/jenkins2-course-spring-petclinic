pipeline {
         agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
         tools {
                 //docker 'dockerlatest'
                   maven 'M3'
         }
        
        parameters {
                string (
                        defaultValue: '*',
                        description: '',
                        name : 'BRANCH_PATTERN')
                booleanParam (
                        defaultValue: false,
                        description: '',
                        name : 'PUBLISH')
                }
	stages {
    		stage('Build') 	{
			steps {
        			sh 'mvn package'
			}
    		}
    		stage('parallel stages') {
    		        parallel {
    			        stage('Archival') {
				        steps {
        				        archiveArtifacts 'target/*.war'
				        }
    			        }
		
			        stage('Test cases') {
				        steps {
        				        junit 'target/surefire-reports/*.xml'
				        }
    		                }

		        } 
                }

  	}
	post {
		always {
			notify('started')
		}
		failure {
			notify('err')
		}
		success {
			notify('success')
		}
	}
}

def notify(status){
    emailext (
    to: "devops.kphb@gmail.com",
    subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
    body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME}  [${env.BUILD_NUMBER}]</a></p>""",
    )
 }
