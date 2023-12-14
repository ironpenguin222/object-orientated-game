// Martin Pocock
// Pizza Defender
// Tower defense game, place towers to stop aliens from reaching the end and stealing your pizza
//1, 2, 3, 4 to place down towers at mouse location, space to start a wave (secret tower at 1000 cost)


// Variables
int lives = 150; // (10) declare and use a global variable
boolean gameOver = false; // (13) Boolean expressions
int lastWaveSpawnFrame = 0; // Checks for frame last wave was spawned
int waveSpawnDelay = 250; // Delays between waves
int wave; // Keeps track of what wave it is
boolean gamePaused = false;
int enemyCount = 5; // Amount of enemies spawned
int minEnemyHealth = 13; // Min  health gain possible for enemies
int maxEnemyHealth = 17; // Max  health gain possible for enemies
int enemySpawnDelay = 5;  // Delays for enemy spawns
boolean menu = true;
int currency = 100; // Currency used to buy towers
// Arraylists
ArrayList<Tower> towers;
ArrayList<Enemy> enemies;
ArrayList<PVector> waypoints; // (38) Use the PVector class

void setup(){ // (4) setup()
  size(400, 400);
  playGame();
}
void playGame() {
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
  gamePaused = false;
  // Sets variables to start game up
  lives = 150;
  gameOver = false;
  lastWaveSpawnFrame = 0;
  wave = 0;
  enemyCount = 5;
  minEnemyHealth = 13;
  maxEnemyHealth = 17;
  currency = 100;
  menu = true;
}

void draw() {
  background(160, 110, 80); // (5) background()
  drawGameElements();
  handleGameOver();
}

void drawGameElements() {
  drawUI();
  drawTrack();
  gameFunctions();
  removeDefeatedEnemies();
  displayCurrency();

  if (menu) {
    displayMenu();
  }
}

void drawTrack(){
  fill(0);
  rect(30, 0, 40, 180); // (1) rect()
  rect(30, 180, 190, 40);
  rect(180, 40, 40, 140);
  rect(180, 40, 180, 40);
  rect(320, 40, 40, 400);
}

void drawUI() {
  // Draw UI elements
  fill(0); // (2) fill()
  // Create Text
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
  text("80$", 286, 340);
  text("Pizza", 15, 365);
  text("Chef", 15, 385);
  text("Pizza", 92, 365);
  text("Sniper", 92, 385);
  text("Pizza", 169, 365);
  text("Tosser", 169, 385);
  text("Pizza", 246, 365);
  text("Puncher", 246, 385);
}
void gameFunctions(){ // Makes game function, used to allow game to pause when lost
if (!gamePaused){

  for (Enemy enemy : enemies) {
    if (frameCount >= enemy.spawnTime) { // (12) conditional statements
      enemy.move(); // Moves enemies
      enemy.display(); // Displays enemies
    }
  }


  for (Tower tower : towers) {
    tower.updateProjectiles(); // Moves projectiles
    tower.display(); // Displays towers
    tower.attack(enemies); // Allows towers to attack enemies
  }
}
}


void removeDefeatedEnemies() { // Removes enemies if their health is 0
  enemies.removeIf(enemy -> enemy.health <= 0); // (36) Use an ArrayList method: remove()
}

void displayCurrency() { //Displays the currency
  fill(0);
  textSize(16);
  text("Currency: $" + currency, 90, 30);
}

void displayMenu() { // Creates and displays the menu
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
  fill(0);
  text("Pizza Defender", 15, 170);
  textSize(20);
  text("[Click anywhere to start]", 100, 250);
}

void handleGameOver() {
  if (gameOver) {
    text("Game Over", width / 2.5, height / 1.4);
    gamePaused = true;
    if(mousePressed){
      playGame(); // Starts game again
      loop(); // Loops game
    }
  }
}

void mousePressed() { // Removes menu when mouse is pressed
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
      if (frameCount - lastWaveSpawnFrame > waveSpawnDelay) { // Summons wave on space press
      spawnEnemyWave(enemyCount);
       enemyCount+=1; // (8) Increment operator
      lastWaveSpawnFrame = frameCount;
      }
      break;
    case '1': // All the cases for each tower, sets stats
      placeTower(50, 20, 110, 33, 5);
      break;
    case '2':
      placeTower(120, 60, 1000, 100, 1);
      break;
    case '3':
      placeTower(100, 8, 200, 6, 1000);
      break;
    case '4':
      placeTower(80, 60, 50, 50, 1);
      break;
      case '5':
      placeTower(1000, 150, 1000, 0, 1000);
      break;
       case 'p':
      // Toggle game pause state when 'p' key is pressed
      gamePaused = !gamePaused;
      break;
    default:
  }
}

void spawnRandomEnemy() { // Enemy health is set and enemy is made
  int reward = 20; // (9) declare and use a local variable
  int health = (int) random(minEnemyHealth, maxEnemyHealth + 1);
  Enemy enemy = new Enemy(waypoints, 2, reward, 2, health);
  enemies.add(enemy);
  println("Enemy spawned! Health: " + enemy.health); // (11) println()
}

void spawnEnemyWave(int numEnemies) { // Uses loop to summon in enemies for wave, and sets variables
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
  if (currency >= cost) { // Checks to see if you have enough money
    Tower tower = new Tower(mouseX, mouseY, damage, range, fireRate, maxProjectiles); // Creates the tower and then removes cost
    towers.add(tower);
    currency -= cost;
    println("Tower placed! Remaining money: $" + currency);
  } else {
    println("Not enough money to place a tower!");
  }
}
