package com.qstream.jenkins

import groovy.json.JsonSlurper

def plan(String environment) {
  sh script: "terraform plan -detailed-exitcode -out=${environment}_plan", returnStatus: true
}

def apply(String environment) {
  sh "terraform apply -auto-approve ${environment}_plan"
}

def output() {
  def output = sh script: 'terraform output --json', returnStdout: true
  def parsed = new groovy.json.JsonSlurper().parseText(output)
  return parsed
}

def setup(String environment) {
  sshagent(credentials: ['git']) {
    clean(environment)
    init()
    workspace(environment)
    validate()
  }
}

private

def clean(String environment) {
  echo 'Cleaning up old plans & state'
  sh "rm -rf ${environment}_plan ${environment}_output.state"
  sh 'rm -rf .terraform'
}

def init() {
  echo 'Initialise Terraform'
  sh """
  terraform init -upgrade=true \
    -backend-config=\"bucket=gar-ddt-networking\" \
    -backend-config=\"encrypt=true\" \
    -backend-config=\"dynamodb_table=gar-ddt-tfstatelock\" \
    -backend-config=\"region=eu-west-1\"
  """
}

def workspace(String environment) {
  echo 'Select workspace'
  sh "if ! \$(terraform workspace list | grep -q ${environment}); then terraform workspace new ${environment}; fi"
  sh "terraform workspace select ${environment}"
}

def validate() {
  echo 'Validate blueprint'
  sh 'terraform validate'
}