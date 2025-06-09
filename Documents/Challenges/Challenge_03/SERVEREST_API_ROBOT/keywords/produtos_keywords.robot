*** Settings ***
Documentation       Variables e Keywords do endpoint /login.

*** Keywords ***
POST Endpoint /produtos
    &{headers}      Create Dictionary       Authorization=${tokenAuth}
    &{payload}      Create Dictionary
        ...         nome=MaisUmProdutoDeTeste
        ...         preco=1
        ...         descricao=Produto à preco de banana
        ...         quantidade=100

    ${response}     POST On Session         serverest       /produtos      data=&{payload}      headers=${headers}
    Log To Console      Response: ${response.content}
    Set Global Variable     ${response}

DELETE Endpoint /produtos
    &{headers}      Create Dictionary       Authorization=${tokenAuth}
    ${response}     DELETE On Session         serverest       /produtos/${idProduto}            headers=${headers}
    Log To Console      Response: ${response.content}
    Set Global Variable     ${response}

Validar Ter Criado Produto
    Should Be Equal     ${response.json()["message"]}       Cadastro realizado com sucesso
    Should Not Be Empty     ${response.json()["_id"]}

Criar Produto E Obter Id
    POST Endpoint /produtos
    Validar Ter Criado Produto
    ${idProduto}            Set Variable        ${response.json()["_id"]}
    Set Global Variable     ${idProduto}