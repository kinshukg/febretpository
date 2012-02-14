class SecondLevelRowView extends View {

  String title;
  PImage logo;
  int firstColumn,secondColumn;
 public  ArrayList subs ;
  SecondLevelRowView(float x_, float y_,String title,PImage logo, int firstColumn, int secondColumn)
  {
    super(x_, y_,width,25);
    this.title = title;
    this.logo = logo;
    this.firstColumn = firstColumn;
    this.secondColumn = secondColumn;
    this.subs = new ArrayList();
  }

  void drawContent()
  {
   stroke(0);
   // textLeading(fbold);
   fill(secondLevelRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(12);
   image(logo,40,4);
   //ellipse(37,12,12,12);
   text(title,75,12);
   text(firstColumn, 650, 12);
   text(secondColumn, 750, 12);
  }
}
