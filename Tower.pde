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
    this.framerate =0;
  }

  void attack(Enemy enemy) {
    float distance = dist(x, y, enemy.x, enemy.y);
    framerate+=1;
   if((framerate % enemyCount-1) == 0){
    if (distance < range && cooldown <= 0 && projectiles.size() < maxProjectiles) {
      Projectile projectile = new Projectile(x, y, enemy, damage);
      projectiles.add(projectile);
      println("Tower attacks an enemy!");
      cooldown = fireRate; // Reset cooldown counter
    } else if (cooldown > 0) {
      cooldown--; // Decrease cooldown counter
    }
  }
  }
  

  void updateProjectiles() {
    for (Projectile projectile : projectiles) {
      projectile.update();
      projectile.display();
    }

    // Remove projectiles that are out of range or hit enemies
    projectiles.removeIf(projectile -> projectile.hitEnemy());
  }

  void display() {
    fill(255, 255, 255); // White color for towers
    ellipse(x, y, 25, 25); //towers are represented as rectangles
  }
}
