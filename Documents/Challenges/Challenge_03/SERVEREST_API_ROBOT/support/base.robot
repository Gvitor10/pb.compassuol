# Sessão para configuração, documentação, imports de arquivos e Library.
*** Settings ***
Documentation     Arquivo simples para requisições HTTP em APIs REST.
Library             RequestsLibrary
Library             Collections
Library             OperatingSystem
Resource            ./common/common.robot
Resource            ./fixtures/dynamics.robot
Resource            ./variables/serverest_variables.robot
Resource            ../keywords/login_keywords.robot
Resource            ../keywords/produtos_keywords.robot
Resource            ../keywords/usuarios_keywords.robot

# Sessão para criação de Keywords Personalizadas.
*** Keywords ***
Criar Sessao
    Create Session      serverest       ${BASE_URL}
