class Projectile {
  float x, y;
  float speed;
  Enemy target;
  int damage;

  Projectile(float x, float y, Enemy target, int damage) {
    this.x = x;
    this.y = y;
    this.target = target;
    this.damage = damage;
    this.speed = 5;
  }

  void update() {
    // Move towards the enemy
    float angle = atan2(target.y - y, target.x - x);
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  void display() {
    fill(205, 133, 63); // yellow color for projectiles
    ellipse(x, y, 10, 10); // projectiles are represented as circles
    fill(255, 255, 0); // yellow color for projectiles
    ellipse(x, y, 8, 8); // projectiles are represented as circles
    fill(255, 0, 0); // yellow color for projectiles
    ellipse(x+2, y, 2, 2);
    ellipse(x+1, y+2, 2, 2);
    ellipse(x-1, y+2, 2, 2);
    ellipse(x+2, y-2, 2, 2);
    ellipse(x-2, y-2, 2, 2);
  }


  boolean hitEnemy() {
    float distance = dist(x, y, target.x, target.y);
    if (distance < 10) {
      target.takeDamage(damage);
      return true;
    }
    return false;
  }
}
