class TitleView extends View {

  PImage logo;
  String title,subtitle;
  color main, titleColor, subtitleColor;
   TitleView(float x_, float y_,float w_, PImage img, String title,String subtitle, color main, color titleColor, color subtitleColor)
  {
    super(x_, y_,w_ , 20);
    this.logo = img;
    this.title = title;
    this.main = main;
    this.titleColor = titleColor;
    this.subtitleColor = subtitleColor;
    this.subtitle = subtitle;
  }

 void drawContent()
  {
    noStroke();
    fill(main);
    rect(0,0,this.w,27);
    image(logo,0,0);
    textFont(fbold);
    textSize(18);
    fill(titleColor);
    textAlign(LEFT,CENTER);
    text(title, logo.width+5,10);
    textSize(12);
    fill(subtitleColor);
    text(subtitle,logo.width+title.length()*15,11);
  }
}
