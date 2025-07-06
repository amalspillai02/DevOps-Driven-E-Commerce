pipeline {
    agent any

    environment {
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
        DOCKER_REGISTRY = 'amalspillai02'
        TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push Images') {
            parallel {
                stage('Auth Service') {
                    steps {
                        script {
                            sh "docker build -t $DOCKER_REGISTRY/auth-service:$TAG auth-service"
                        }
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            sh '''
                                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                                docker push $DOCKER_REGISTRY/auth-service:$TAG
                            '''
                        }
                    }
                }

                stage('Product Service') {
                    steps {
                        script {
                            sh "docker build -t $DOCKER_REGISTRY/product-service:$TAG product-service"
                        }
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            sh '''
                                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                                docker push $DOCKER_REGISTRY/product-service:$TAG
                            '''
                        }
                    }
                }

                stage('Order Service') {
                    steps {
                        script {
                            sh "docker build -t $DOCKER_REGISTRY/order-service:$TAG order-service"
                        }
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            sh '''
                                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                                docker push $DOCKER_REGISTRY/order-service:$TAG
                            '''
                        }
                    }
                }
            }
        }

        stage('Deploy DB Services') {
            steps {
                withEnv(["KUBECONFIG=$KUBECONFIG"]) {
                    sh 'kubectl apply -f k8s/db/'
                }
            }
        }

        stage('Deploy App Services') {
            parallel {
                stage('Deploy Auth') {
                    steps {
                        withEnv(["KUBECONFIG=$KUBECONFIG"]) {
                            sh 'kubectl apply -f k8s/auth/'
                        }
                    }
                }

                stage('Deploy Product') {
                    steps {
                        withEnv(["KUBECONFIG=$KUBECONFIG"]) {
                            sh 'kubectl apply -f k8s/product/'
                        }
                    }
                }

                stage('Deploy Order') {
                    steps {
                        withEnv(["KUBECONFIG=$KUBECONFIG"]) {
                            sh 'kubectl apply -f k8s/order/'
                        }
                    }
                }
            }
        }

        stage('Deploy Ingress') {
            steps {
                withEnv(["KUBECONFIG=$KUBECONFIG"]) {
                    sh 'kubectl apply -f k8s/ingress/ingress.yaml'
                }
            }
        }
    }
}
