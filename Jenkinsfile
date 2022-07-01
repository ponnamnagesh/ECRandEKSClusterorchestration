pipeline {
    agent any
    
    stages {
        //stage ('s3 - create bucket') {
          //  steps {
               // sh ('ansible-playbook s3-bucket.yml')
             //}
       //}
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/cvdev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ponnamnagesh/ECRandEKSClusterorchestration.git']]])            
              //git([url: 'git@github.com:ponnamnagesh/TerraformJenkinsS3Ansible.git', branch: 'main', credentialsId: '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'])

          }
        }    
        stage ("Terraform Init") {
            steps {
                sh ('terraform init') 
            }
        }
        stage ("Terraform Plan") {
            steps {
                sh ('terraform plan') 
            }
        }
        stage ("Terraform Action") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve') 
                //sh ('terraform apply --auto-approve') 
                //sh ('terraform destroy --auto-approve')
           }
        }
        stage('Update EKS KubeConfig') {
            steps {
                script {
                    input message: 'Proceed?', ok: 'Yes', submitter: 'admin'
                }
                sh ('aws sts get-caller-identity')
                sh ('aws eks --region us-east-2 update-kubeconfig --name cvdev-cluster')
                sh ('kubectl get pods --kubeconfig ./.kube/config')
            }
            post {
                aborted{
                    echo "stage has been aborted"
                }
            }            
        }
    }
        }
    

