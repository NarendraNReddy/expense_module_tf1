#!/bin/bash
# user data will get sudo access
dnf install ansible -y
cd /tmp
git clone https://github.com/daws-78s/expense-ansible-roles.git
cd expense-ansible-roles
#git clone https://github.com/NarendraNReddy/ANSIROLES.git
#cd ANSIROLES
ansible-playbook main.yaml -e component=backend -e login_password=ExpenseApp1
ansible-playbook main.yaml -e component=frontend