pipeline {
    agent none
    options {
        timestamps()
    }
        stages {
           stage('setup node') {
                agent {
                    label 'master'
                }
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                extensions: [], userRemoteConfigs: [[credentialsId: 'github_ssh_key',
                url: 'git@github.com:OlehZz/epam_final_project_DevOps.git']]])

                sh 'ansible-playbook ansible/setup_node.yml'
            }
        }
        stage('setup files for artifact') {
                agent {
                    label 'maven'
                }
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                extensions: [], userRemoteConfigs: [[credentialsId: 'github_ssh_key',
                url: 'git@github.com:OlehZz/epam_final_project_DevOps.git']]])
                
                checkout([$class: 'GitSCM', branches: [[name: '*/release/1.0.0']],
                extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'footgo']],
                userRemoteConfigs: [[credentialsId: 'github_ssh_key', url: 'git@github.com:OlehZz/FootGo.git']]])
                
                sh 'ansible-playbook /home/ubuntu/jenkins/workspace/\'setup jenkins node\'/ansible/setup_db_access.yml'
            }
        }
        stage('build artifact') {
                agent {
                    label 'maven'
                }
                environment {
                    MAVEN_OPTS = '-Xmx800m'

            }
            steps {
                sh ' mvn -f /home/ubuntu/jenkins/workspace/\'setup jenkins node\'/footgo/pom.xml clean package'
            }
        }
        stage('Make Container') {
                agent {
                    label 'maven'
                }
            steps {
                sh "docker build -t footgo:${env.BUILD_ID} /home/ubuntu/jenkins/workspace/\'setup jenkins node\'/"
                sh "docker tag footgo:${env.BUILD_ID} footgo:latest"
                docker.withRegistry('https://622371100744.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws-ecr-cred') {
    docker.image('footgo').push('latest')
  }
            }
        }
        stage('deploy artifact') {
                agent {
                    label 'maven'
                }
            steps {
                sh 'ansible-playbook /home/ubuntu/jenkins/workspace/\'setup jenkins node\'/ansible/deploy_artifact.yml'
            }
        }
    }
}