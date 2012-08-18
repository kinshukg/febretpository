class RationaleActionBar extends View {


  RationaleActionBar(float x_, float y_,float w_,float h_)
  {
    super(x_, y_,w_ ,h_); 
  }
  void drawContent()
  {
    noStroke();
  fill(closePopUpColor);
  rect(0,0,w,h);
  fill(255);
  text("Close Popup    X",w - 100,h/2-2);
  }
}
