mkAnsibleRole() {
    for ROLE_NAME in "$@"
    do
        mkdir $ROLE_NAME;
        mkdir $ROLE_NAME/{templates,defaults,handlers,tasks};
        touch $ROLE_NAME/{templates,defaults,handlers,tasks}/main.yml;
    done
}