# 🤖 Testes Automatizados - API Restful Booker

## 📌 Sobre o Projeto
Este repositório contém uma suíte de testes automatizados desenvolvida com Robot Framework para testar os principais endpoints da API Restful Booker. O projeto tem como objetivo exercitar práticas de automação de testes em APIs RESTful utilizando uma ferramenta de fácil leitura e manutenção.

## 🧰 Tecnologias Utilizadas
* Linguagem: Python
* Framework: Robot Framework
* Bibliotecas:

    *RequestsLibrary* – para requisições HTTP

    *Collections* - 

* Gerenciador de dependências: pip
* Editor sugerido: VSCode

## ✅ Casos de Teste Implementados

### 🔐 Autenticação
    POST /auth: Geração de token com credenciais válidas

### 📄 CRUD de Reservas

    GET /booking: Lista de reservas

    GET /booking/{id}: Detalhes de uma reserva

    POST /booking: Criação de nova reserva

    PUT /booking/{id}: Atualização de reserva (com autenticação)

    DELETE /booking/{id}: Exclusão da reserva

## 🧪 Estrutura do Projeto
    📁 Restful-Book-API/
    ├── tests/
    │   ├── /auth
    │   │      └──  CreateToken_test.robot
    │   └── /booking
    │          ├── CreateBooking_test.robot
    │          ├── DeleteBooking_test.robot
    │          ├── GetBooking_test.robot
    │          ├── GetBookingIds_test.robot
    │          └── UpdateBooking_test.robot
    └── README.md (Você está aqui)

## 📊 Relatórios
Após a execução, o Robot Framework gera automaticamente os seguintes arquivos:

* log.html

* report.html

* output.xml

Abra o report.html em seu navegador para visualizar os resultados.

## 👨‍💻 Autor
Desenvolvido por _Gabriel Lobo_, QA Júnior na Compass UOL.
🔗 [LinkedIn](https://www.linkedin.com/in/devgabrielvitor/) | [GitHub](https://github.com/Gvitor10)