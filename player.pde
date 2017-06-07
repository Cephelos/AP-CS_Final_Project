


public class fighter {

  private String type;
  private PVector pos;
  private PVector vel;
  private int health;
  private int maxHealth;
  private int attack;
  private int mana;
  private int maxMana;

  private PImage[] sprites;

  private int defense;
  private boolean targeted;

  private int spriteNum = 0;
  

  public fighter(String type, int health, int attack, int mana, PImage[] sprites) {
    this.type = type;
    this.health = health;
    this.attack = attack;
    this.mana = mana;
    this.sprites = sprites;

    this.maxHealth = health;
    this.maxMana = mana;
  }



  void render() {
    fill(#ED841A);
    rect(pos.x, pos.y, 50, 100);
    if (frameCount % 15 == 0) {
      spriteNum += 1;
    }
    if (spriteNum >= sprites.length) {
      spriteNum = 0;
    }
    image(sprites[spriteNum], pos.x, pos.y, 50, 100);

    if (targeted) {
      fill(0);
      rect(pos.x+20, pos.y - 30, 10, 10);
      triangle(pos.x+15, pos.y-20, pos.x +35, pos.y-20, pos.x+25, pos.y -10);
    }
    text("(" + health + "/" + maxHealth + ")", pos.x, pos.y-25);
  }




  int strike(fighter target) {
    int dmg = attack - target.defense;
    if (dmg < 0) {
      dmg = 0;
    }
    target.health -= dmg;

    return(dmg);
  }

  void cast(ArrayList<fighter> targets, skill spell) {
    int dmg = 0;
    for (fighter f : targets) {
      dmg = (int)(attack * spell.dmgMod) - f.defense;
      if (dmg < 0) {
        dmg = 0;
      }
      f.health -= dmg;
    }
    this.mana -= spell.cost;
  }
}