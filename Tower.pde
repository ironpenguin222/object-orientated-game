class Tower {
  float x, y;
  int damage;
  int framerate;
  int range;
  int fireRate; // Fire rate in frames
  int cooldown; // Cooldown counter
  int maxProjectiles; // Maximum number of projectiles allowed
  ArrayList<Projectile> projectiles;

  Tower(float x, float y, int damage, int range, int fireRate, int maxProjectiles) {
    this.x = x;
    this.y = y;
    this.damage = damage;
    this.range = range;
    this.fireRate = fireRate;
    this.cooldown = 0;
    this.maxProjectiles = maxProjectiles;
    this.projectiles = new ArrayList<>();
    this.framerate = 0;
  }

  void attack(ArrayList<Enemy> enemies) {
    if (canAttack()) {
     framerate+=1;
     if((framerate % enemyCount-1) == 0){
      for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = enemies.get(i);
        float distance = dist(x, y, enemy.x, enemy.y);
        if (distance < range && projectiles.size() < maxProjectiles) {
          Projectile projectile = new Projectile(x, y, enemy, damage);
          projectiles.add(projectile);
          println("Tower attacks an enemy!");
          resetCooldown();
          break;
        }
      }
      }
    } else {
      decreaseCooldown();
    }
  }

  private boolean canAttack() { // (21) Declare & call a function with a return type
    return cooldown <= 0;
  }

  private void resetCooldown() {
    cooldown = fireRate;
  }

  private void decreaseCooldown() {
    if (cooldown > 0) {
      cooldown--; // Decrease cooldown counter
    }
  }

  void updateProjectiles() {
    for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile projectile = projectiles.get(i);
      projectile.update();
      projectile.display();
      if (projectile.hitEnemy()) {
        projectiles.remove(i);
      }
    }
  }

  void display() {
    fill(255, 255, 255); // White color for towers
    ellipse(x, y, 25, 25);

    // Add other ellipse shapes for tower details
    fill(255, 255, 255);
    ellipse(x-10, y, 10, 10);
    ellipse(x-8.5, y-3, 10, 10);
    ellipse(x-6.5, y-6, 10, 10);
    ellipse(x-4, y-9, 10, 10);
    ellipse(x-1, y-9.6, 10, 10);
    ellipse(x+2, y-9.5, 10, 10);
    ellipse(x+4, y-9, 10, 10);
    ellipse(x+6, y-6, 10, 10);
    ellipse(x+8, y-3, 10, 10);
    ellipse(x+9, y-1, 10, 10);
    ellipse(x+9, y+2, 10, 10);
    ellipse(x+10, y, 10, 10);
    ellipse(x+8.5, y+3, 10, 10);
    ellipse(x+6.5, y+6, 10, 10);
    ellipse(x+4, y+9, 10, 10);
    ellipse(x+1, y+9.6, 10, 10);
    ellipse(x-2, y+9.5, 10, 10);
    ellipse(x-4, y+9, 10, 10);
    ellipse(x-6, y+6, 10, 10);
    ellipse(x-8, y+3, 10, 10);
    ellipse(x-9, y+1, 10, 10);
    ellipse(x-9, y-2, 10, 10);
    ellipse(x, y, 20, 20);

    // Display projectiles
    updateProjectiles();
  }
}
