# Mapeamento de Elementos - Site Divvino.com

|   Nome do Elemento    |   Tipo de Elemento    |   Seletor    |    Texto visível   |   Observações     |
|-----------------------|-----------------------|--------------|--------------------|-------------------|
|ARR_BTN_CATEGORIAS     |Ul                     |ul[class*="headerMenuDesktop"]| N/A|Vísivel somente em desktop|
|ARR_PRODUTOS           |div                    |div[class*="ProductListstyled__ProductListContainer"]| N/A| |
|ICO_LUPA_BUSCA         |Button                 |button[aria-label="Buscar produtos"]| N/A|             |
|BTN_CARRINHO           |Span                   |span[class*="divvino-minicart"]| Meu Carrinho |Texto visível somente em Desktop|

---

```
Estratégia utilizada:

Essa estratégia de mapeamento prioriza a clareza e a robustez, utilizando seletores que são menos suscetíveis a mudanças frequentes na interface. Para elementos como ARR_BTN_CATEGORIAS e ARR_PRODUTOS, o uso de ul[class*="headerMenuDesktop"] e div[class*="ProductListstyled__ProductListContainer"] respectivamente, foca em partes dos nomes de classes que provavelmente se manterão estáveis, mesmo que a ordem ou outros caracteres na classe mudem. No caso do ICO_LUPA_BUSCA, o seletor button[aria-label="Buscar produtos"] é ideal porque aria-label é um atributo de acessibilidade que raramente muda e é uma forma confiável de identificar o botão. Já para o BTN_CARRINHO, o seletor span[class*="divvino-minicart"] combinado com o texto visível "Meu Carrinho" oferece uma identificação precisa, especialmente porque o texto está sujeito a ser exibido ou oculto dependendo do dispositivo. Em geral, a escolha dos seletores se baseia em atributos e partes de classes que são intrínsecos à função do elemento e menos propensos a alterações visuais ou estruturais superficiais.
```