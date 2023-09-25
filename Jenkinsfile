pipeline {
    agent any
    stages {
        stage("Clean Workspace") {
            steps {
                echo "cleaning prior directories and files from previous builds"
                deleteDir()
            }
        }
        stage("Cloning the code"){
            steps{
                echo "Cloning the code"
                git url:"https://github.com/Jayraj-Malamdi/dotnet-api-crud-postgres-docker-jenkins-app.git", branch: "main"
            }
        }
        stage("Restore Dependencies"){
            steps{
                echo "Restoring Dependencies"
                sh "dotnet restore ${workspace}/csharp-crud-api.csproj"
            }
        }
        stage("Build Docker Image"){
            steps{
                echo "Build Database Image"
                sh "docker-compose up -d db"
            }
        }
        stage("Creating Table"){
            steps{
                echo "Creating Table inside Docker Image"
                echo "##################################"
                sh '''
                if ! docker exec -u postgres db psql -t -c "SELECT to_regclass('public.users');" | grep -q "users"; then
                    docker exec -u postgres db psql -c "CREATE TABLE \\"users\\" (
                        \\"id\\" SERIAL PRIMARY KEY,
                        \\"name\\" VARCHAR(50) NOT NULL,
                        \\"email\\" VARCHAR(255) NOT NULL
                    );"
                fi
                '''
            }
        }
        stage ("Publish Application"){
            steps{
                echo"Cleaning publish folder"
                sh "rm -rf ./publish_folder"
                echo "Publishing .NET Application"
                sh "dotnet publish ${workspace}/csharp-crud-api.csproj -c Release -o ./publish_folder"
            }
            }
        stage("Deploy"){
            steps{
                echo "Deploying the container"
                sh "docker-compose up -d"
            }
        }
    }
}
