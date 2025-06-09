*** Settings ***
Documentation       Arquivo para geração de massas de dados dinâmicas.
Library             FakerLibrary

*** Keywords ***
Criar Dados Usuario Valido
    ${nome}         FakerLibrary.Name
    ${email}        FakerLibrary.Email
    &{payload}      Create Dictionary
        ...         nome=${nome}
        ...         email=${email}
        ...         password="teste"
        ...         administrador=true
    RETURN          &{payload}