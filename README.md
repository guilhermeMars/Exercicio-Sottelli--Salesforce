# Sinopse
Foi o exercício que mais demandou tempo enquanto estive na Sottelli. Serviu para testar as habilidades com salesforce e programação front e back end, sendo totalmente didático e sem fins lucrativos.

Além disso, convido a visitar meu [perfil no Trailhead](https://www.salesforce.com/trailblazer/guilhermemars). Pois lá estão minhas conquistas, pontuações e exercícios relacionados a Salesforce.

Lembrando que a maior parte do conteúdo está nas pastas de `force-app/main/default`. Tudo dentro dessas pastas é relacionado a desenvolvimento. Sendo:
- **Front-end**: `/lwc`
- **Back-end**: `/classes` e `/triggers`
# Ideia inicial
Ter um objeto, dentro de Accounts, para criação de avaliações.
## 1° Exercício
Nele teria um formulário com o avaliador, título, descrição e nota. Após feita a avaliação, os dados são atualizados em uma data-table abaixo do formulário, sem fazer refresh da página/
## 2° Exercício
Agora as notas são como "semáforos", círculos que mudam de cor dependendo de qual nota foi feita. No topo são mostrados os círculos da nota mínima e máxima. E na data-table é necessário ter um campo personalizado para mostragem do círculo.

Além disso, precisa de um novo objeto para armazenar as médias diárias das contas. Esse objeto verifica diariamente se foi feita uma avaliação para a conta, e, caso seja verdadeiro, ele cria uma média das notas desse mesmo dia. Os dados também são mostrados em uma data-table.
# Resultado
![image](https://github.com/guilhermeMars/Exercicio-Sottelli--Salesforce/assets/83723703/59ec4714-04e4-4e38-8abf-094cda66ee79)
![image](https://github.com/guilhermeMars/Exercicio-Sottelli--Salesforce/assets/83723703/de3b1412-368b-4566-810c-4ced191f66fb)

