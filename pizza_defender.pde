// Martin Pocock
// Pizza Defender
// Tower defense game, place towers to stop aliens from reaching the end and stealing your pizza
//1, 2, 3, 4 to place down towers at mouse location, space to start a wave (secret tower at 1000 cost)


// Variables
int lives = 150; // (10) declare and use a global variable
boolean gameOver = false; // (13) Boolean expressions
int lastWaveSpawnFrame = 0;
int waveSpawnDelay = 250; // Delays between waves
int wave;
int enemyCount = 5; // Amount of enemies spawned
int minEnemyHealth = 13;
int maxEnemyHealth = 17;
int enemySpawnDelay = 5;
boolean menu = true;
int currency = 100; // Currency used to buy towers
// Arraylists
ArrayList<Tower> towers;
ArrayList<Enemy> enemies;
ArrayList<PVector> waypoints; // (38) Use the PVector class

void setup() { // (4) setup()
  size(400, 400);
  towers = new ArrayList<>(); // (34) Initialize and populate an ArrayList
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
  background(160, 110, 80); // (5) background()
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
  // Draw UI elements
  rect(30, 0, 40, 180); // (1) rect()
  rect(30, 180, 190, 40);
  rect(180, 40, 40, 140);
  rect(180, 40, 180, 40);
  rect(320, 40, 40, 400);
  fill(0); // (2) fill()
  textSize(16);
  text("Lives: " + lives, 210, 30);
  text("Wave: " + wave, 295, 30);
  fill(255, 80, 70);
  rect(10, 325, 70, 70);
  fill(190, 200, 90);
  rect(87, 325, 70, 70);
  fill(190, 170, 240);
  rect(164, 325, 70, 70);
  fill(190, 30, 210);
  rect(241, 325, 70, 70);
  fill(255, 255, 255);
  text("1", 15, 340);
  text("2", 92, 340);
  text("3", 169, 340);
  text("4", 246, 340);
  text("50$", 55, 340);
  text("120$", 125, 340);
  text("100$", 201, 340);
  text("60$", 286, 340);
  text("Pizza", 15, 365);
  text("Chef", 15, 385);
  text("Pizza", 92, 365);
  text("Sniper", 92, 385);
  text("Pizza", 169, 365);
  text("Tosser", 169, 385);
  text("Pizza", 246, 365);
  text("Puncher", 246, 385);
}

void spawnAndMoveEnemies() {
  for (Enemy enemy : enemies) {
    if (frameCount >= enemy.spawnTime) { // (12) conditional statements
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
  enemies.removeIf(enemy -> enemy.health <= 0); // (36) Use an ArrayList method: remove()
}

void displayCurrency() {
  fill(0);
  textSize(16);
  text("Currency: $" + currency, 90, 30);
}

void displayMenu() {
  fill(230, 220, 100);
  rect(0, 0, 400, 400);
  textSize(60);
  fill(205, 133, 63);
  ellipse(200,200,200,200);
  fill(255, 255, 0);
  ellipse(200,200,160,160);
  fill(255, 0, 0);
  ellipse(202, 200, 40, 40);
  ellipse(241, 232, 40, 40);
  ellipse(149, 232, 40, 40);
  ellipse(242, 158, 40, 40);
  ellipse(160, 178,40, 40);
  
  fill(20, 205, 210);
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
  if (mouseX > 0 && mouseX < 400 && mouseY > 0 && mouseY < 400) { // (14) Logical operators
    menu = false;
  }
}

void keyPressed() { // (7) keyPressed()
  switch (key) { // (15) switch statement
    case 'e':
      spawnRandomEnemy();
      break; // (18) break
    case ' ':
      if (frameCount - lastWaveSpawnFrame > waveSpawnDelay) {
      spawnEnemyWave(enemyCount);
       enemyCount+=1; // (8) Increment operator
      lastWaveSpawnFrame = frameCount;
      }
      break;
    case '1':
      placeTower(50, 20, 110, 33, 5);
      break;
    case '2':
      placeTower(120, 60, 1000, 100, 1);
      break;
    case '3':
      placeTower(100, 8, 200, 0, 1000);
      break;
    case '4':
      placeTower(60, 60, 50, 50, 1);
      break;
      case '5':
      placeTower(1000, 150, 1000, 0, 1000);
      break;
    default:
  }
}

void spawnRandomEnemy() {
  int reward = 20; // (9) declare and use a local variable
  int health = (int) random(minEnemyHealth, maxEnemyHealth + 1);
  Enemy enemy = new Enemy(waypoints, 2, reward, 2, health);
  enemies.add(enemy);
  println("Enemy spawned! Health: " + enemy.health); // (11) println()
}

void spawnEnemyWave(int numEnemies) {
  wave++;
  int reward = 20;
  minEnemyHealth *= 1.015;
  maxEnemyHealth *= 1.015;
  minEnemyHealth += 11;
  maxEnemyHealth += 15;

  for (int i = 0; i < numEnemies; i++) { // (16) for loop
    int spawnTime = i * enemySpawnDelay + frameCount;
    int health = (int) random(minEnemyHealth, maxEnemyHealth + 1);
    Enemy enemy = new Enemy(waypoints, 2, reward, spawnTime, health);
    enemies.add(enemy);
    println("Wave " + wave + " spawned! Enemy Health: " + enemy.health);
  }
}

void placeTower(int cost, int damage, int range, int fireRate, int maxProjectiles) { // (23) Pass by copy
  if (currency >= cost) {
    Tower tower = new Tower(mouseX, mouseY, damage, range, fireRate, maxProjectiles);
    towers.add(tower);
    currency -= cost;
    println("Tower placed! Remaining money: $" + currency);
  } else {
    println("Not enough money to place a tower!");
  }
}
