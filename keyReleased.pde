


void keyReleased() {
  if (key == 'x') {
    fileWriter("scores.txt", "TJ", 1100);
  }
  if (key == 'd') {
    if (gameState.equals("selectAction")) {
      selection ++;

      if (selection < iconList.length) {
        for (menuIcon i : iconList) {

          i.pos.x -= 50;
        }
      }
    }
    if (gameState.equals("selectTarget") || gameState.equals("selectTargetSkill")) {
      if (targetSelection < targetList.size()-1) {
        targetList.get(targetSelection).targeted = false;
        targetSelection ++;
        targetList.get(targetSelection).targeted = true;
      }
    }
    if (gameState.equals("skillMenu")) {
      if (skillSelection < skillList.length-1) {
        skillList[skillSelection].selected = false;
        skillSelection ++;
        skillList[skillSelection].selected = true;
      }
    }
  }

  if (key == 'a') {
    if (gameState.equals("selectAction")) {
      selection --;

      if (selection >= 0) {
        for (menuIcon i : iconList) {

          i.pos.x += 50;
        }
      }
    }
    if (gameState.equals("selectTarget") ||gameState.equals("selectTargetSkill")) {
      if (targetSelection > 0) {
        targetList.get(targetSelection).targeted = false;
        targetSelection --;
        targetList.get(targetSelection).targeted = true;
      }
    }
    if (gameState.equals("skillMenu")) {
      if (skillSelection > 0) {
        skillList[skillSelection].selected = false;
        skillSelection --;
        skillList[skillSelection].selected = true;
      }
    }
  }

  if (key == 's') {
    if (gameState.equals("skillMenu")) {
      if (skillSelection < skillList.length-1) {
        skillList[skillSelection].selected = false;
        skillSelection ++;
        skillList[skillSelection].selected = true;
      }
    }
  }

  if (key == 'w') {
    if (gameState.equals("skillMenu")) {
      if (skillSelection > 0) {
        skillList[skillSelection].selected = false;
        skillSelection --;
        skillList[skillSelection].selected = true;
      }
    }
  }

  selection = constrain(selection, 0, iconList.length-1);

  if (key == ENTER) {
    System.out.println(gameState);
    if (gameState.equals("mainMenu")) {
      gameState = "selectAction";
    } else if (gameState.equals("selectAction")) {
      if (selection == 0) {
        for (int i = 1; i < fighterList.size(); i++) {

          targetList.add(fighterList.get(i));
        }

        gameState = "selectTarget";
        targetList.get(0).targeted = true;
      } else if (selection == 1) {
        gameState = "skillMenu";
        skillList[0].selected = true;
      }
      if (!iconList[selection].selected) {
        iconList[selection].selected = true;
      }
    } else if (gameState.equals("selectTarget")) {
      //System.out.println(ready);
      gameState = "attack";
    }

    if (gameState.equals("attack")) {
      fighterList.get(0).strike(targetList.get(targetSelection));
      targetList.get(targetSelection).targeted = false;
      iconList[selection].selected = false;
      gameState = "enemyTurn";
    } else if (gameState.equals("skillMenu")) {
      if (ready) {
        ready = false;
        gameState = "selectTargetSkill";
      } else {
        ready = true;
      }
    } else if (gameState.equals("selectTargetSkill")) {
      if (skillList[skillSelection].targeting.equals("All")) {
        for (int i = 1; i < fighterList.size(); i++) {

          targetList.add(fighterList.get(i));
          //targetList.get(0).targeted = true;
          targetList.get(targetSelection).targeted = true;
        }
      }
      if (skillList[skillSelection].targeting.equals("One")) {
        for (int i = 1; i < fighterList.size(); i++) {

          targetList.add(fighterList.get(i));
        }
      }
    } else if (gameState.equals("enemyTurn")) {
    }
  }
}