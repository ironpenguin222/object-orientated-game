int lives = 150; // Starting number of lives
int maxLives = 5; // Maximum number of lives
boolean gameOver = false;
int lastWaveSpawnFrame = 0;
int waveSpawnDelay = 250; // Delay between each enemy wave spawn
int wave;
int enemyCount =5;
int minEnemyHealth;
int maxEnemyHealth;
int framerate;
boolean menu = true;
// Lists to store towers, enemies, and projectiles
ArrayList<Tower> towers;
ArrayList<Enemy> enemies;
ArrayList<PVector> waypoints;
int currency = 100; // Starting amount of money

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
  if(menu == true){
  rect(0,0,400,400);
  }
  rect(30, 0, 40, 180);
  rect(30, 180, 190, 40);
  rect(180, 40, 40, 140);
  rect(180, 40, 180, 40);
  rect(320, 40, 40, 400);
framerate +=1;
fill(0);
  textSize(16);
  text("Lives: " + lives, width - 250, height - 20);

  // Check for game over
  if (gameOver) {
    fill(255, 0, 0); // Red color for game over text
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2);
    noLoop(); // Stop the draw loop
  }

  // Display and move enemies
 for (Enemy enemy : enemies) {
    // Check if it's time to spawn the enemy
    if (frameCount >= enemy.spawnTime) {
      enemy.move();
      enemy.display();
    }
  }


  // Display and update towers and their projectiles
  for (Tower tower : towers) {
    tower.updateProjectiles();
    tower.display();
  }
  
  // Tower attacks enemies within range
  for (Tower tower : towers) {
    for (Enemy enemy : enemies) {
      tower.attack(enemy);
    }
  }
  

  // Remove defeated enemies
  enemies.removeIf(enemy -> enemy.health <= 0);

  // Display currency
  fill(0);
  textSize(16);
  text("Currency: $" + currency, 10, height - 20);
  text("Wave: " + wave, 240, height - 20);
}

void mousePressed() {
  if(mouseX > 0 && mouseX < 400){
    if(mouseY > 0 && mouseY < 400){
      menu = false;
    }
  }
}
  

int enemySpawnDelay = 10;

void spawnEnemyWave(int numEnemies) {
  wave++;
  int reward = (int) random(10, 30); // Random reward between 10 and 30

  // Increase min and max enemy health after each wave
  minEnemyHealth *= (1.03);
  maxEnemyHealth *= (1.03); 
  minEnemyHealth += 15;
  maxEnemyHealth += 25; 

  for (int i = 0; i < numEnemies; i++) {
    int spawnTime = i * enemySpawnDelay + frameCount;
    int health = (int) random(minEnemyHealth, maxEnemyHealth + 1); // Random health between min and max
    Enemy enemy = new Enemy(waypoints, 2, reward, spawnTime, health);

    enemies.add(enemy);
    println("Wave " + wave + " spawned! Enemy Health: " + enemy.health);
  }
}
void keyPressed() {
  switch (key) {
    case 'e':
    int reward = (int) random(23, 27); // Random reward between 10 and 30
    Enemy enemy = new Enemy(waypoints, 2, reward, 2, 10); // Enemy stats
    enemies.add(enemy);
    println("Enemy spawned! Health: " + enemy.health);

      break;
    case ' ':
      if (frameCount - lastWaveSpawnFrame > waveSpawnDelay) {
        spawnEnemyWave(enemyCount);
        lastWaveSpawnFrame = frameCount;
        enemyCount += 1;
      }
      break;
      
      case '1':
      if (currency >= 50) {
    Tower tower = new Tower(mouseX, mouseY, 20, 120, 30, 5); // damage, range, fire rate, and max projectiles
    towers.add(tower);
    currency -= 50;
    println("Tower placed! Remaining money: $" + currency);
  } else {
    println("Not enough money to place a tower!");
  }
  break;

    case '2':
      if (currency >= 100) {
        Tower powerfulTower = new Tower(mouseX, mouseY, 60, 1000, 100, 1);
        towers.add(powerfulTower);
        currency -= 100;
        println("Powerful Tower placed! Remaining money: $" + currency);
      } else {
        println("Not enough money to place a Powerful Tower!");
      }
      break;
    case '3':
      if (currency >= 120) {
        Tower quickTower = new Tower(mouseX, mouseY, 15, 180, 10, 100);
        towers.add(quickTower);
        currency -= 120;
        println("Quick Tower placed! Remaining money: $" + currency);
      } else {
        println("Not enough money to place a Quick Tower!");
      }
      break;
    case '4':
      if (currency >= 60) {
        Tower meleeTower = new Tower(mouseX, mouseY, 50, 40, 50, 1);
        towers.add(meleeTower);
        currency -= 60;
        println("Melee Tower placed! Remaining money: $" + currency);
      } else {
        println("Not enough money to place a Melee Tower!");
      }
      break;
    default:  
  }
}
