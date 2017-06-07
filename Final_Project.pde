


public menuIcon[] iconList = new menuIcon[3];
public ArrayList<fighter> fighterList = new ArrayList();
public int selection = 0;
public int targetSelection = 0;
public int skillSelection = 0;
public ArrayList<fighter> targetList = new ArrayList();
public boolean ready = false;

public skill[] skillList = new skill[3];




public String gameState = "mainMenu";


void setup() {
  frameRate(60);
  size(800, 800);
  textSize(20);
  PFont ebic = loadFont("ComicSansMS-20.vlw");
  //String[] fontList = PFont.list();
  //printArray(fontList);
  PFont unknown = createFont("Pokemon: Annon", 20);
  PFont tentacle = createFont("Tentacles", 20);
  PFont dovah = createFont("Dovahkiin", 20);
  textFont(ebic);
  menuIcon a = new menuIcon(new PVector(110, 430), 30, color(250, 50, 50), true, loadImage("attack_beeg.png"));
  menuIcon b = new menuIcon(new PVector(160, 430), 30, color(50, 250, 50), false, loadImage("special_beeg.png"));
  menuIcon c = new menuIcon(new PVector(210, 430), 30, color(50, 50, 250), false, loadImage("item_beeg.png"));

  iconList[0] = a;
  iconList[1] = b;
  iconList[2] = c;

  skill pistol = new skill("Pistol", "One", 1.1, 1);
  skillList[0] = pistol;

  skill tommyGun = new skill("Tommy Gun", "All", 1.1, 2);
  skillList[1] = tommyGun;

  skill bulletFlurry = new skill("First Aid", "Self", -5, 5);
  skillList[2] = bulletFlurry;




  PImage[] playerIdle = {loadImage("idle1.png"), loadImage("idle2.png"), loadImage("idle1.png"), loadImage("idle3.png")};
  fighter player = new fighter("player", 10, 1, 5, playerIdle);
  fighterList.add(player);
  player.defense = 1;

  fighter enemy1 = new fighter("enemy", 10, 1, 5, playerIdle);
  fighterList.add(enemy1);

  fighter enemy2 = new fighter("enemy", 10, 1, 5, playerIdle);
  fighterList.add(enemy2);

  fighter enemy3 = new fighter("enemy", 10, 1, 5, playerIdle);
  fighterList.add(enemy3);

  //fighter boss = new fighter("boss", 10, 1, 5);
  //fighterList.add(boss);


  reader = createReader("scores.txt");
}


void draw() {
  if (gameState == "mainMenu") {
    background(0);
    textAlign(CENTER);
    text("Press Enter to Start", width/2, height/2);
    /*text("Press R to Reset Highscore",width/2,height/2+22);
     fileReader();
     for(int i = 0; i < a.length; i++){
     text(a[i],width/2, height/2+(3+i)*22);
     }*/
  } else {
    textAlign(LEFT);
    background(200);
    fill(100, 50, 50);
    rect(0, height*2/3, width, height);
    int enemyCount = 0;
    for (fighter f : fighterList) {
      if (f.type.equals("player")) {
        f.pos = new PVector(100, 500);
      } else if (f.type.equals("boss")) {
        f.pos = new PVector(450, 500);
      } else if (f.type.equals("enemy")) {
        enemyCount += 1;
        f.pos = new PVector(350 + enemyCount*100, 500);
      }
    }

    if (gameState == "selectAction" && fighterList.get(0).health <= 0) {
      exit();
    }


    for (menuIcon i : iconList) {
      if (gameState == "selectAction"|| i.selected) {

        i.render();

        i.selfect();
      }
    }
    for (fighter f : fighterList) {

      f.render();
    }
    if (gameState == "enemyTurn") {
      for (fighter f : fighterList) {

        if (f.type.equals("enemy")) {
          f.strike(fighterList.get(0));
        }
      }

      gameState = "selectAction";
    }

    if (gameState == "skillMenu") {
      fill(50, 180, 50, 100);
      rect(90, 170, 285, skillList.length*22+44);
      line(90, 198, 375, 198);
      fill(0);
      text("Skill", 95, 190);
      text("Targets", 245, 190);
      for (int i = 0; i < skillList.length; i ++) {

        text(skillList[i].name, 95, 222+i*22);
        text(skillList[i].targeting, 245, 222+i*22);
        if (skillList[i].selected) {
          fill(0);
          rect(65, 210+i*22, 10, 10);
          triangle(75, 205+i*22, 75, 225+i*22, 85, 215+i*22);
        }
      }
    }
  }
}