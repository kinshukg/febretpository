class ClosePopUpView extends View {

 boolean pressed = false;
  ClosePopUpView(float x_, float y_,float w_,float h_)
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
     boolean contentPressed(float lx, float ly)
  {
    // override this
    // lx, ly are in the local coordinate system of the view,
    // i.e. 0,0 is the top left corner of this view
    // return false if the click is to "pass through" this view
   pressed = true;
    return true;
  }

}
