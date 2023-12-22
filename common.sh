log_file=/tmp/expense.log
colour="\e[36m"

status_check() {
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[32m FAILURE \e[0m"
fi

}



pipeline {
  agent {
    node { label 'workstation'}
  }

  stages {

    stage('compile'){
      steps {
        echo 'compile'
      }
    }

    stage('Testcases'){
      steps {
        echo 'Testcases'
      }
    }
    stage('Build'){
      steps {
          echo 'Build'
      }
    }
    stage('Release'){
      steps {
          echo 'Release'
      }
    }
  }
}



