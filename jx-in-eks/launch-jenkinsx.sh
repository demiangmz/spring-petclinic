cd jenkinsx
jx add app jx-app-ui
echo "Waiting for app UI PR to get merged in dev repository..."
sleep 2m
echo "Check your dev repository to validate the PR was approved for UI"
jx import --url https://github.com/demiangmz/spring-petclinic.git
jx ui