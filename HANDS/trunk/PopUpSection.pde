class PopUpSection extends View {

  String title;
  
  
  PopUpSection(float x_, float y_, ArrayList<CheckBox> actions, String title)
  {
    super(x_, y_, 400, 60+(actions.size()*20));
    this.title = title;
    
    int ys = 35;
    for(int i = 0; i < actions.size(); i++){
    
    CheckBox c = actions.get(i);
    c.y = ys;
    this.subviews.add(c);
    ys += 25;
    }    
  }
  void drawContent()
  {
    noStroke();
    fill(popUpSectionColor);
    rect(0,0,w,h);
    
    fill(0);
    textSize(16);
    text(title, 10,10);
    textSize(12);
  }
}

