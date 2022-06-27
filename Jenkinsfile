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
            checkout([$class: 'GitSCM', branches: [[name: '*/cvqa']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ponnamnagesh/ECRandEKSClusterorchestration.git']]])            
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
    }
}
