# 🚀 Player com Algoritmo de Dijkstra
### 🕹️ Jogo de Aventura em Grid - Processing - JAVA
### 🎯 Objetivo
Este projeto tem como objetivo implementar um player que se movimenta pelo caminho mais curto em um grid finito, utilizando o **algoritmo de Dijkstra**. O grid representa diferentes tipos de terreno e obstáculos:

- **Terrenos:** Grama, Areia, Água
- **Obstáculos:** Pedras, Cactos, Corais

O player só pode navegar pela água caso tenha um barco, que será colocado aleatoriamente no grid.
---
🎮 Funcionalidades:

🌍 Mapa Procedural: O jogo gera automaticamente um grid 10x10 com biomas variados.

🚶 Movimentação Estratégica: O jogador deve se mover pelo mapa considerando terrenos com diferentes velocidades.

⛵ Uso de Barco: Em locais com água, o jogador só pode atravessar se possuir um barco.

🧱 Obstáculos: Corais, pedras e cactos impedem a passagem.

🗺️ Algoritmo de Caminho: 
Implementação do algoritmo Dijkstra para encontrar o caminho mais eficiente entre pontos

## ✅ Requisitos do Trabalho

### 🏃 Implementação do Player
- Criar uma classe `Player` com atributos para **posição, velocidade e posse do barco**.
- O player deve se mover do **ponto inicial** até o **ponto clicado no grid**, utilizando o **algoritmo de Dijkstra**.
- Regras de movimento:
  - **Grama:** 1 bloco por segundo
  - **Areia:** 0,5 blocos por segundo (velocidade reduzida pela metade)
  - **Água:** 2 blocos por segundo **(somente com barco)**

### 🔢 Implementação do Algoritmo de Dijkstra
- O algoritmo deve calcular o **caminho mais curto** considerando os pesos dos terrenos:
  - **Água:** Peso 1 (se tiver barco) / Infinito (se não tiver barco)
  - **Grama:** Peso 2
  - **Areia:** Peso 3

### 🌍 Criação de Biomas
- O grid deve incluir **biomas variados**, gerados com diferentes tipos de terrenos e obstáculos.

### 🖱️ Ações no Grid
- O player deve **se mover até o ponto clicado** no grid, utilizando Dijkstra para encontrar o caminho mais curto.
---
📦 Como executar
- Instale o Processing
- Clone o repositório: git clone https://github.com/seu-usuario/seu-repositorio.git
- Abra o código no Processing e clique em Run.
🚀

🛠️ Tecnologias utilizadas
- Processing (Java)
- Estruturas de dados (Listas, Matrizes)
- Algoritmos de busca (Dijkstra)

🖥️ Sobre o Processing:

O Processing é uma linguagem de programação e um ambiente de desenvolvimento voltado para a criação de arte visual e interativa. Com uma sintaxe simples baseada em Java, o Processing permite que artistas, designers e programadores desenvolvam gráficos 2D e 3D, animações e interações de forma rápida e intuitiva.
A plataforma é amplamente utilizada em áreas como arte digital, visualização de dados, educação e prototipagem de jogos, oferecendo uma interface fácil de usar e recursos poderosos para explorar criatividade por meio da programação.

🧪 Playtest

> Veja a exibição de jogo aqui:
> https://www.youtube.com/watch?v=0zMqBWq7JJQ&list=PLCI7snv1cekFfE4Alojy-UxX8I-c6UE1R

