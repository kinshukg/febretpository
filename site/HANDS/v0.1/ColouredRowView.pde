class ColouredRowView extends View {

  String title;
  PImage logo;
  public ArrayList subs;  
  ColouredRowView(float x_, float y_,String title,PImage logo)
  {
    super(x_, y_,width,25);
    this.title = title;
    this.logo = logo;
    this.subs = new ArrayList();
  }

  void drawContent()
  {
   stroke(0);
   // textLeading(fbold);
   fill(colouredRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(12);
   image(logo,5,6);
   text(title,45,12);
  }
}
