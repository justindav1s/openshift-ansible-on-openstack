#!/usr/bin/env bash

rm -rf ../ansible/*.retry

<<<<<<< HEAD
ansible-playbook  -vvvv -i ../ansible/inventory/hosts ../ansible/cloud.yml
=======
ansible-playbook -i ../ansible/inventory/hosts ../ansible/cloud.yml
>>>>>>> 625826c18e159e71f7a8753eca9c1d93895c2a59
