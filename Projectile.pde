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
    this.speed = 2.5;
  }

  void update() {
    // Move towards the enemy
    float angle = atan2(target.y - y, target.x - x);
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  void display() {
    fill(205, 133, 63); // Yellow color for crust of projectiles
    ellipse(x, y, 10, 10);
    fill(255, 255, 0); // Yellow color for cheese of projectiles
    ellipse(x, y, 8, 8);
    displayProjectileDetails();
  }

  boolean hitEnemy() {
    float distance = dist(x, y, target.x, target.y);
    if (distance < 10) {
      target.takeDamage(damage);
      return true;
    }
    return false;
  }

  private void displayProjectileDetails() {
    fill(255, 0, 0); // Red color for pepperoni
    ellipse(x + 2, y, 2, 2);
    ellipse(x + 1, y + 2, 2, 2);
    ellipse(x - 1, y + 2, 2, 2);
    ellipse(x + 2, y - 2, 2, 2);
    ellipse(x - 2, y - 2, 2, 2);
  }
}
