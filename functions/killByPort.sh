killByPort() {
    kill $(lsof -t -i:$1)
}