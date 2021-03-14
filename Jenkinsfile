pipeline {
    agent none
    options {
        timestamps()
    }
        stages {
            stage('checkout playbook for setup jenkins node') {
                agent { 
                    label 'master'
                }
            steps {
               checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
               extensions: [], userRemoteConfigs: [[credentialsId: 'github_ssh_key', 
               url: 'git@github.com:OlehZz/epam_final_project_DevOps.git']]])
            }
        }
           stage('setup node') {
                agent { 
                    label 'master'
                }
            steps {
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
    }
}