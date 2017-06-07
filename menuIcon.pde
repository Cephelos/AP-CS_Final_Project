public class menuIcon {

  private PVector pos;
  private int size;
  private color fill;
  private boolean active;
  private boolean selected;
  private PImage sprite;

  public menuIcon(PVector pos, int size, color fill, boolean active, PImage sprite) {

    this.pos = pos;
    this.size = size;
    this.fill = fill;
    this.active = active;
    this.sprite = sprite;
  }
  void render() {
    PVector newpos = pos;
    if (selected) {
      //fill(fill);
      image(sprite, newpos.x - size / 2, newpos.y - size / 2, size * 2, size * 2);
    } else if (active) {
      //fill(fill);
      image(sprite, newpos.x, newpos.y, size, size);
    } else {
      //fill(red(fill) / 4, green(fill) / 4, blue(fill) / 4);
      image(sprite, newpos.x, newpos.y, size * .8, size * .8);
      newpos = pos;
    }
  }




  void selfect() {

    if (iconList[selection].equals(this)) active = true;
    else active = false;
  }
}