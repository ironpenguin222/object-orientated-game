class Enemy {
  float x, y;
  int health;
  int speed;
  int reward;
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

  void increaseHealth(int amount) {
    this.minHealth += amount;
    this.maxHealth += amount;
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0 && !rewardTriggered) {
      println("Enemy defeated! Reward: $" + reward);
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

      float distanceToTarget = dist(x, y, target.x, target.y); // (6) dist() / (40) distance between two points
      if (distanceToTarget < 5) {
        currentWaypoint++;
      }
    } else {
      despawn();
    }
  }

  void despawn() {
    lives -= health;
    if (lives <= 0) {
      gameOver = true;
      println("Game Over!");
    } else {
      health = 0;
    }
  }

  void display() {
    float healthColor = map(health, 0, 150, 255, 0);
    fill(255, healthColor, 0);
    ellipse(x, y, 20, 20);

    fill(255, 255, 255);
    ellipse(x - 3.5, y + 2, 5, 5);
    ellipse(x + 3.5, y + 2, 5, 5);

    fill(0, 0, 0);
    ellipse(x - 3.5, y + 3, 2, 2);
    ellipse(x + 3.5, y + 3, 2, 2);
  }
}
