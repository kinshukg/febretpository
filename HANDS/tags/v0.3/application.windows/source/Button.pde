class Button extends View {


  boolean selected = false;
  String t;
  Button(float x_, float y_,float w_,float h_,boolean selected, String t)
  {
    super(x_, y_,w_ ,h_); 
    this.selected = selected;
    this.t = t;
  }
  void drawContent()
  {
    noStroke();
    if(selected)
  fill(buttonSelectedColor);
  else
  fill(buttonNotColor);
  
  rect(0,0,w,h);
  if(selected)
  fill(0);
  else
  fill(255);
  text(t,w/2-35,h/2-2);
  }
    boolean contentPressed(float lx, float ly)
  {
    // override this
    // lx, ly are in the local coordinate system of the view,
    // i.e. 0,0 is the top left corner of this view
    // return false if the click is to "pass through" this view
   selected =!selected;
    return true;
  }

}
