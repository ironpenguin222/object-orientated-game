class Enemy {
  float x, y;
  int health;
  int speed;
  int reward; // Amount of money rewarded when the enemy is defeated
  int minHealth = 50;
  int maxHealth = 150;
  ArrayList<PVector> waypoints;
  int currentWaypoint = 0;
  boolean rewardTriggered = false;

 int spawnTime;

  Enemy(ArrayList<PVector> waypoints, int speed, int reward, int spawnTime, int health) {
    this.waypoints = waypoints;
    this.x = waypoints.get(0).x;
    this.y = waypoints.get(0).y;
    this.health = health;
    this.speed = speed;
    this.reward = reward;
    this.spawnTime = spawnTime;

  }
  
  void increasesHealth(int amount){
    this.minHealth += amount;
    this.maxHealth += amount;
  }


  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0 && rewardTriggered !=true) {
      println("Enemy defeated! Reward: $" + reward);
      // Add currency when the enemy is defeated
      currency += reward;
      rewardTriggered = true;
    }
  }

  void move() {
    if (currentWaypoint < waypoints.size()) {
      PVector target = waypoints.get(currentWaypoint);
      PVector direction = PVector.sub(target, new PVector(x, y));
      direction.normalize();
      direction.mult(speed);
      x += direction.x;
      y += direction.y;
      // Check if the enemy reached the current waypoint
      float distanceToTarget = dist(x, y, target.x, target.y);
      if (distanceToTarget < 5) {
        currentWaypoint++;
      }
    }else {
      // Enemy reached the end of the map
      despawn();
    }
  }

void despawn() {
    lives-=health; // Deduct a life
    if (lives <= 0) {
      // Game over
      gameOver = true;
      println("Game Over!");
    } else {
      health=0;
    }
  }

  void display() { 
    // Adjust color based on health
    float healthColor = map(health, 0, 150, 255, 0);
    fill(255, healthColor, 0); // Color based on health
    ellipse(x, y, 20, 20); //Using enemies are represented as circles
    fill(255, 255, 255);
    ellipse(x-3.5, y+2, 5, 5);
    ellipse(x+3.5, y+2, 5, 5);
    fill(0, 0, 0);
    ellipse(x-3.5, y+3, 2, 2);
    ellipse(x+3.5, y+3, 2, 2);
  }
}
