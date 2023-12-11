int lives = 150;
int maxLives = 5;
boolean gameOver = false;
int lastWaveSpawnFrame = 0;
int waveSpawnDelay = 250;
int wave;
int enemyCount = 5;
int minEnemyHealth;
int maxEnemyHealth;
int enemySpawnDelay = 5;
boolean menu = true;
ArrayList<Tower> towers;
ArrayList<Enemy> enemies;
ArrayList<PVector> waypoints;
int currency = 100;

void setup() {
  size(400, 400);
  towers = new ArrayList<>();
  enemies = new ArrayList<>();
  waypoints = new ArrayList<>();

  // Define waypoints to create a path
  waypoints.add(new PVector(50, 0));
  waypoints.add(new PVector(50, 200));
  waypoints.add(new PVector(200, 200));
  waypoints.add(new PVector(200, 50));
  waypoints.add(new PVector(350, 50));
  waypoints.add(new PVector(350, height));
}

void draw() {
  background(200);
  drawGameElements();
  handleGameOver();
}

void drawGameElements() {
  drawUI();
  spawnAndMoveEnemies();
  updateAndDisplayTowers();
  removeDefeatedEnemies();
  displayCurrency();

  if (menu) {
    displayMenu();
  }
}

void drawUI() {
  rect(30, 0, 40, 180);
  rect(30, 180, 190, 40);
  rect(180, 40, 40, 140);
  rect(180, 40, 180, 40);
  rect(320, 40, 40, 400);
  fill(0);
  textSize(16);
  text("Lives: " + lives, width - 250, height - 20);
  text("Currency: $" + currency, 10, height - 20);
  text("Wave: " + wave, 240, height - 20);
}

void spawnAndMoveEnemies() {
  for (Enemy enemy : enemies) {
    if (frameCount >= enemy.spawnTime) {
      enemy.move();
      enemy.display();
    }
  }
}

void updateAndDisplayTowers() {
  for (Tower tower : towers) {
    tower.updateProjectiles();
    tower.display();
    tower.attack(enemies);
  }
}

void removeDefeatedEnemies() {
  enemies.removeIf(enemy -> enemy.health <= 0);
}

void displayCurrency() {
  fill(0);
  textSize(16);
  text("Currency: $" + currency, 10, height - 20);
}

void displayMenu() {
  fill(230, 220, 100);
  rect(0, 0, 400, 400);
  textSize(60);
  fill(230, 220, 100);
  fill(210, 12, 10);
  text("Pizza Defender", 15, 170);
  textSize(20);
  text("[Click anywhere to start]", 100, 250);
}

void handleGameOver() {
  if (gameOver) {
    fill(255, 0, 0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2);
    noLoop();
  }
}

void mousePressed() {
  if (mouseX > 0 && mouseX < 400 && mouseY > 0 && mouseY < 400) {
    menu = false;
  }
}

void keyPressed() {
  switch (key) {
    case 'e':
      spawnRandomEnemy();
      break;
    case ' ':
      if (frameCount - lastWaveSpawnFrame > waveSpawnDelay) {
      spawnEnemyWave(enemyCount);
       enemyCount+=1;
      lastWaveSpawnFrame = frameCount;
      break;
    }
    case '1':
      placeTower(50, 20, 120, 30, 5);
      break;
    case '2':
      placeTower(100, 60, 1000, 100, 1);
      break;
    case '3':
      placeTower(120, 15, 180, 10, 100);
      break;
    case '4':
      placeTower(60, 50, 40, 50, 1);
      break;
    default:
  }
}

void spawnRandomEnemy() {
  int reward = (int) random(23, 27);
  int health = (int) random(minEnemyHealth, maxEnemyHealth + 1);
  Enemy enemy = new Enemy(waypoints, 2, reward, 2, health);
  enemies.add(enemy);
  println("Enemy spawned! Health: " + enemy.health);
}

void spawnEnemyWave(int numEnemies) {
  wave++;
  int reward = (int) random(10, 30);
  minEnemyHealth *= 1.03;
  maxEnemyHealth *= 1.03;
  minEnemyHealth += 15;
  maxEnemyHealth += 25;

  for (int i = 0; i < numEnemies; i++) {
    int spawnTime = i * enemySpawnDelay + frameCount;
    int health = (int) random(minEnemyHealth, maxEnemyHealth + 1);
    Enemy enemy = new Enemy(waypoints, 2, reward, spawnTime, health);
    enemies.add(enemy);
    println("Wave " + wave + " spawned! Enemy Health: " + enemy.health);
  }
}

void placeTower(int cost, int damage, int range, int fireRate, int maxProjectiles) {
  if (currency >= cost) {
    Tower tower = new Tower(mouseX, mouseY, damage, range, fireRate, maxProjectiles);
    towers.add(tower);
    currency -= cost;
    println("Tower placed! Remaining money: $" + currency);
  } else {
    println("Not enough money to place a tower!");
  }
}
