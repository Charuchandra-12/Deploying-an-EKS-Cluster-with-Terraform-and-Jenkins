pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY_ID = credentials('AWS_SECRET_ACCESS_KEY_ID')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout GitHub Repo'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Charuchandra-12/Deploying-an-EKS-Cluster-with-Terraform-and-Jenkins.git']])
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('EKS_Terraform'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatting Terraform Code'){
            steps{
                script{
                    dir('EKS_Terraform'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform Code'){
            steps{
                script{
                    dir('EKS_Terraform'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Creating an EKS Cluster'){
            steps{
                script{
                    dir('EKS_Terraform') {
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
        // stage('Destroying an EKS Cluster'){
        //     steps{
        //         script{
        //             dir('EKS_Terraform') {
        //                 sh 'terraform apply --auto-approve'
        //             }
        //         }
        //     }
        // }
        stage('Deploying AnimeQuotesApp Application') {
            steps{
                script{
                    dir('EKS_Terraform/deployments') {
                        sh 'aws eks update-kubeconfig --name dev-eks-cluster'
                        sh 'kubectl apply -f deployment.yml'
                    }
                }
            }
        }
    }
}

