*** Settings ***
Documentation       Keywords de uso geral.
Library             OperatingSystem

*** Keywords ***
Validar Status Code "${statusCode}"
    Should Be True      ${response.status_code} == ${statusCode}

Importar Json Estatico
    [Arguments]     ${nomeDoArquivo}
    ${arquivo}      Get File        ${EXECDIR}/${nomeDoArquivo}
    ${data}         Evaluate        json.loads('''${arquivo}''')        json
    RETURN        ${data}