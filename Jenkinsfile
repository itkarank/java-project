pipeline {
    agent any

    stages {
        
  stage('Ansible Playbook') {
    steps {
      withCredentials ([ file(credentialsId: 'newkey.pem', variable: 'PEM_FILE_PATH')]) {
        sh """ ansible-playbook -i hosts -e 'ansible_ssh_private_key_file=$PEM_FILE_PATH' config.yml """
      }
    }
  }
}
}    
    

      

