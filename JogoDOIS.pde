// Marina Laura Villaça e Melo

import java.util.Collections;

final int LINHAS = 10;
final int COLUNAS = 10;
final int TAMANHO_CELULA = 70;
final int GRAMA = 0;
final int AREIA = 1;
final int AGUA = 2;
final int CORAL = 3;
final int PEDRA = 4;
final int CACTUS = 5;

int[][] grid = new int[LINHAS][COLUNAS];
int[][] distancias;
Ponto[][] anteriores;
boolean[][] visitados;

Jogador jogador;
ArrayList<Ponto> caminho;

PImage imagemPlayerTerrestre;
PImage imagemPlayerComBarco;
PImage imagemCoral;
PImage imagemPedra;
PImage imagemCactus;

class Ponto {
    int linha, coluna;
    
    Ponto(int linha, int coluna) {
        this.linha = linha;
        this.coluna = coluna;
    }

    boolean igual(Ponto outro) {
        return this.linha == outro.linha && this.coluna == outro.coluna;
    }
}

class Jogador {
    int linha, coluna;
    boolean possuiBarco;
    int destinoLinha, destinoColuna;

    Jogador(int linha, int coluna) {
        this.linha = linha;
        this.coluna = coluna;
        this.possuiBarco = true;
        this.destinoLinha = linha;
        this.destinoColuna = coluna;
    }

    void exibir() {
        PImage imagemAtual = (grid[linha][coluna] == AGUA && possuiBarco) ? imagemPlayerComBarco : imagemPlayerTerrestre;
        image(imagemAtual, coluna * TAMANHO_CELULA, linha * TAMANHO_CELULA, TAMANHO_CELULA, TAMANHO_CELULA);
    }


int tempoUltimoMovimento = 0;  // Tempo desde o último movimento
int velocidadeAtual = 1; // Velocidade inicial (grama)
int tempoParaMover;  // Tempo necessário para o próximo movimento

void mover() {
    // Verifica se o caminho está vazio ou se o tempo necessário não passou
    if (caminho.isEmpty()) 
      return;

    // Verifica o tempo desde o último movimento
    int tempoAtual = millis();
    if (tempoAtual - tempoUltimoMovimento < tempoParaMover) 
      return;

    // Atualiza o tempo do último movimento
    tempoUltimoMovimento = tempoAtual;

    // Obter o próximo ponto do caminho
    Ponto proximoPonto = caminho.get(0);  // Obter o próximo ponto do caminho
    caminho.remove(0);  // Remover o ponto atual do caminho

    if (grid[proximoPonto.linha][proximoPonto.coluna] != PEDRA && grid[proximoPonto.linha][proximoPonto.coluna] != CACTUS && grid[proximoPonto.linha][proximoPonto.coluna] != CORAL){

        // Atualizar a posição do jogador
        linha = proximoPonto.linha;
        coluna = proximoPonto.coluna;

        // Ajuste de velocidade baseado no terreno
        if (grid[linha][coluna] == GRAMA) {
            velocidadeAtual = 1;
            tempoParaMover = 1000;  // 1 bloco por segundo
        } 
        
        else if (grid[linha][coluna] == AREIA) {
            velocidadeAtual = 2;
            tempoParaMover = 2000;  // 0,5 bloco por segundo
        }
        
        else if (grid[linha][coluna] == AGUA && possuiBarco) {
            velocidadeAtual = 2;
            tempoParaMover = 500;  // 2 blocos por segundo
        } 
        
        else if (grid[linha][coluna] == AGUA && !possuiBarco) {
            velocidadeAtual = Integer.MAX_VALUE;
            tempoParaMover = Integer.MAX_VALUE;  // Impossível mover-se sem barco
        }
    }
}

}

void gerarBiomas() {
    for (int linha = 0; linha < LINHAS; linha++) {
        for (int coluna = 0; coluna < COLUNAS; coluna++) {
            float chance = random(1);
            if (chance < 0.5) 
              grid[linha][coluna] = GRAMA;
              
            else if (chance < 0.7) 
              grid[linha][coluna] = AREIA;
              
            else if (chance < 0.9) 
              grid[linha][coluna] = AGUA;
              
            else {
                int tipoObstaculo = int(random(3));
                
                if (tipoObstaculo == 0) 
                  grid[linha][coluna] = CORAL;
               
                else if (tipoObstaculo == 1) 
                  grid[linha][coluna] = PEDRA;
                
                else 
                  grid[linha][coluna] = CACTUS;
            }
        }
    }
}

void desenharGrid() {
    for (int linha = 0; linha < LINHAS; linha++) {
        for (int coluna = 0; coluna < COLUNAS; coluna++) {
            int terreno = grid[linha][coluna];
            
            if (terreno == GRAMA) 
              fill(0, 255, 0);
            else if (terreno == AREIA) 
              fill(194, 178, 128);
            else if (terreno == AGUA) 
              fill(0, 0, 255);
            else 
              fill(150);
              
            rect(coluna * TAMANHO_CELULA, linha * TAMANHO_CELULA, TAMANHO_CELULA, TAMANHO_CELULA);

            if (terreno == CORAL) 
              image(imagemCoral, coluna * TAMANHO_CELULA, linha * TAMANHO_CELULA, TAMANHO_CELULA, TAMANHO_CELULA);
            else if (terreno == PEDRA) 
              image(imagemPedra, coluna * TAMANHO_CELULA, linha * TAMANHO_CELULA, TAMANHO_CELULA, TAMANHO_CELULA);
            else if (terreno == CACTUS) 
              image(imagemCactus, coluna * TAMANHO_CELULA, linha * TAMANHO_CELULA, TAMANHO_CELULA, TAMANHO_CELULA);
        }
    }
}

ArrayList<Ponto> getVizinhos(Ponto p) {
    ArrayList<Ponto> vizinhos = new ArrayList<>();
    int[][] direcoes = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    
    for (int[] dir : direcoes) {
        int novaLinha = p.linha + dir[0];
        int novaColuna = p.coluna + dir[1];
        if (novaLinha >= 0 && novaLinha < LINHAS && novaColuna >= 0 && novaColuna < COLUNAS) {
            vizinhos.add(new Ponto(novaLinha, novaColuna));
        }
    }
    return vizinhos;
}

int obterPeso(int linha, int coluna) {
    int terreno = grid[linha][coluna];
    
    if (terreno == GRAMA) 
      return 2;
    if (terreno == AREIA) 
      return 3;
    if (terreno == AGUA && jogador.possuiBarco) 
      return 1;
    if (terreno == AGUA && !jogador.possuiBarco) 
      return Integer.MAX_VALUE;
    if (terreno == PEDRA || terreno == CACTUS || terreno == CORAL) 
      return Integer.MAX_VALUE;
    
    return Integer.MAX_VALUE;
}


void dijkstra(Ponto inicio, Ponto fim) {
  
    distancias = new int[LINHAS][COLUNAS];
    anteriores = new Ponto[LINHAS][COLUNAS];
    visitados = new boolean[LINHAS][COLUNAS];

    for (int i = 0; i < LINHAS; i++) {
        for (int j = 0; j < COLUNAS; j++) {
            distancias[i][j] = Integer.MAX_VALUE;
            anteriores[i][j] = null;
            visitados[i][j] = false;
        }
    }

    distancias[inicio.linha][inicio.coluna] = 0;
    ArrayList<Ponto> fila = new ArrayList<>();
    fila.add(inicio);

    while (!fila.isEmpty()) {
        // Encontrar o ponto com menor distância na fila
        Ponto atual = fila.get(0);
        for (Ponto p : fila) {
            if (distancias[p.linha][p.coluna] < distancias[atual.linha][atual.coluna]) {
                atual = p;
            }
        }

        fila.remove(atual);
        visitados[atual.linha][atual.coluna] = true;

        if (atual.igual(fim)) 
          break;

        for (Ponto vizinho : getVizinhos(atual)) {
            if (visitados[vizinho.linha][vizinho.coluna]) 
              continue;

            int peso = obterPeso(vizinho.linha, vizinho.coluna);
            if (peso == Integer.MAX_VALUE) 
              continue;

            int novaDistancia = distancias[atual.linha][atual.coluna] + peso;
            
            if (novaDistancia < distancias[vizinho.linha][vizinho.coluna]) {
                distancias[vizinho.linha][vizinho.coluna] = novaDistancia;
                anteriores[vizinho.linha][vizinho.coluna] = atual;
                fila.add(vizinho);
            }
        }
    }

    // Reconstruir o caminho
    caminho = new ArrayList<>();
    Ponto p = fim;
    
    while (p != null) {
        caminho.add(p);
        p = anteriores[p.linha][p.coluna];
    }
    
    Collections.reverse(caminho);
}

void mousePressed() {
    int linhaDestino = mouseY / TAMANHO_CELULA;
    int colunaDestino = mouseX / TAMANHO_CELULA;
    
    Ponto inicio = new Ponto(jogador.linha, jogador.coluna);
    Ponto fim = new Ponto(linhaDestino, colunaDestino);
    
    dijkstra(inicio, fim);  // Recalcular o caminho até o destino
}

void setup() {
    size(700, 700);
    gerarBiomas();
    jogador = new Jogador(0, 0);
    caminho = new ArrayList<>();
    imagemPlayerTerrestre = loadImage("player.png");
    imagemPlayerComBarco = loadImage("barco.png");
    imagemCoral = loadImage("coral2.jpg");
    imagemPedra = loadImage("pedra2.jpg");
    imagemCactus = loadImage("cactus.png");

    Ponto inicio = new Ponto(jogador.linha, jogador.coluna);
    Ponto fim = new Ponto(LINHAS - 1, COLUNAS - 1);
    dijkstra(inicio, fim);
}

void draw() {
    background(255);
    desenharGrid();
    jogador.exibir();
    jogador.mover();
}
