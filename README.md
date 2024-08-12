## Sobre 

A implementacao do code challenge envolveu a criação de um cluister EKS, com a VPC, subnets e roles IAM necessários. O modulo utilizado para o EKS já cria os security groups seguindo a politica de privilegio minimo.

Para a esteira CICD, foi utilizado o Github como source, o Codepipeline como orquestrador, o Codestar para gerenciar a conexão com o Github, o ECR como repositorio das imagens docker e o Codebuild para as fases de teste, build e deploy.

Na fase de testes, estao sendo realizados testes simples nos endpoints da aplicacao e foi adicionada uma fase de lint no processo.

O deploy faz uso do Helm para provisionar a aplicacao no EKS.

## Como fazer o deploy da infraestrutura, contemplando o cluster EKS e os servicos de CICD

1. Primeiro, clonar o repositorio onde estao o codigo terraform e a aplicacao:

```
git clone https://github.com/eofaria-lab/kanastra-code-challenge.git
```

2. Entrar no diretorio:

```
cd kanastra-code-challenge
```

3. Alterar a variavel com o repositorio (repo_identifier), no arquivo variables.tf, com o repositorio que sera utilizado nos testes. OBS: foi utilizado "main" como branch para disparar o inicio da pipeline.

4. Inicializar o terraform:

```
terraform init
```

5. Aplicar o terraform:

```
terraform apply
```

6. Entrar na console AWS. Abrir o Codepipeline. No menu da esquerda, entrar em settings -> connections. Entrar na conexão kanastra-github. Escolher "Update Pending Connection" e "Install a new app". Prosseguir com as informações de autenticacao e autorizacao no repositorio GitHub escolhido na etapa 3 e clicar em "Connect".


## Como testar a Pipeline CI/CD

1. A pasta kanastra-app-repo representa a pasta raiz do repositorio configurado anteriormente para ser o source da pipeline. Portanto, copiar os tres subdiretorios (kanastra-app, helm_charts e pipeline_files) para o diretorio local que representara a raiz do repositorio.

2. Depois, entrar neste diretorio e realizar os comandos add, commit, e push:

```
cd [diretorio-raiz-repo]
git add helm_charts/ pipeline_files/ kanastra-app/
git commit -m "Adicionando codigo da aplicacao, arquivos de configuracao do CodeBuild e helm charts"
git push origin main
```

3. Apos fazer o push, entrar no Codepipeline via console AWS e verificar a execucao das etapas. 

4. Qualquer novo push na main ira disparar a pipeline novamente.

## Limpeza

Para limpar, rodar do diretorio inicialmente clonado:

```
terraform destroy
```