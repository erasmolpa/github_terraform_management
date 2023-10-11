# Applies to every targets in the file! https://www.gnu.org/software/make/manual/html_node/One-Shell.html
.ONESHELL:

##TODO Create a docker image with all the tools used and run all the commands using containers 
TF_PROVIDER_FILE = https://gitlab.com/-/snippets/2498907/raw/main/localstack_terraform_conf.tf
lint:
	terraform validate

# https://github.com/im2nguyen/rover
graph:
	rover -tfPath `which terraform` -genImage

fmt:
	terraform fmt -recursive

# https://github.com/terraform-linters/tflint install -> brew install tflint
lint:
    docker run --rm -v $(pwd):/data -t ghcr.io/terraform-linters/tflint
init:
	terraform init

plan:
	terraform init
    terraform plan -var="repo_data=$(cat repos.yaml | yq -y .)"

apply:
	terraform apply -var="repo_data=$(cat repos.yaml | yq -y .)"

destroy:
	terraform destroy --auto-approve

tf-security-check:
	docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src

# tools url:
# https://github.com/shihanng/tfvar Install -> brew install shihanng/tfvar/tfvar
# https://github.com/terraform-docs/terraform-docs Install -> brew install terraform-docs
tf-docs:
	docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs > MODULE.md

## SEE https://github.com/nektos/act
github-action-lint:
	act

