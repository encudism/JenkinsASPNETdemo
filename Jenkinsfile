pipeline {
    agent {
        label 'Build-In'
    }
    
    environment {
        DOCKER_IMAGE = "encudism/testapp"
    }
    stages {
        stage('Checkout code'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/encudism/JenkinsASPNETdemo.git'
                }
            }
        }
	    stage('Build and Release') {
            steps{
                script{
                    //bat "\"${tool 'MyMSBuild'}\" JenkinsDemo1.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
                    bat "\"${tool 'MyMSBuild'}\" JenkinsDemo1.sln /p:DeployOnBuild=true /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:SkipInvalidConfigurations=true /t:build /p:Configuration=Release /p:Platform=\"Any CPU\" /p:DeleteExistingFiles=True /p:publishUrl=c:\\data\\jenkins_home\\workspace\\ASPNETDocker1\\jenkins_publish"
                }
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    bat 'docker build -t %DOCKER_IMAGE% .'
                }
            }
        }
        
        stage('Push image to hub'){
            steps{
                script{
                    
                    withCredentials([usernamePassword(credentialsId: 'dockerhubaccount', passwordVariable: 'DHP', usernameVariable: 'DHU')]) {
                        bat 'docker login --username %DHU% --password %DHP%'
                        bat 'docker push encudism/testapp'
                    }
                    
                    //clean image on docker host
                    bat 'docker image rm %DOCKER_IMAGE%'
                    
                }
            }
        }
         
    }
}
