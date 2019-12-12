#!/usr/bin/env bash

getIamRoleId() {
    aws iam get-role --role-name $1 --query 'Role.RoleId' --output text
}