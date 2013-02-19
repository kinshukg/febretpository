class RatingPopUpView extends View
{



  float arrowX, arrowY; 
  Button commit, notApplicable;
  SecondLevelRowView parent;
  ClosePopUpView close;
  Rating current,expected;

  RatingPopUpView(int x_, int y_, int w_, int h_, SecondLevelRowView parent)
  {

    super(x_, y_, w_, h_);
    close = new ClosePopUpView(0, -20, w, 20);
    this.subviews.add(close);
    commit = new Button(20, 0, 150, 20, "Save to POC", 200, 0);
    notApplicable = new Button(200, 0, 180, 20, "Close without saving", 200, 0);

    this.subviews.add(commit);
    this.subviews.add(notApplicable);	
    this.parent = parent;
    
    expected = new Rating(0, 0, w, "Set Expected Rating");
    current = new Rating(0, 100, w, "Set Current Rating");

    popUpView = this;
    
    this.subviews.add(current);
    this.subviews.add(expected);
   
  }
  void hide() 
  {
    mainView.subviews.remove(this);
    popUpView = null;
  } 



  void layout()
  {
    h = 0;
    for (int i = 0; i < subviews.size();i++)
    {
      View v = (View)this.subviews.get(i);
      v.y = h;
      h += v.h;
      if (v != commit && v != notApplicable && v != close)
      {
        v.w = this.w;
      }
    }

    // v2.1: popup never goes off-screen vertically.
    if (y + h > SCREEN_HEIGHT)
    {
      y = SCREEN_HEIGHT - h;
    }
  }
  void drawContent()
  {

    fill(0);
    rect(0, 0, w, h);


    int ys = 0;
    for (int i = 0 ;i<subviews.size();i++)
    {
      View v = (View)subviews.get(i);

      if (!v.equals(commit) && !v.equals(notApplicable))
      {
        v.y = ys;
        ys +=v.h;
      }
    }

    commit.y = ys;
    notApplicable.y = ys;  

    int border = 5;
    fill(0, 0, 0, 180);
    noStroke();
    rect(-border, -border, w + border, h + border);
  //  triangle(-border, 10, arrowX - x, arrowY - y, -border, ys - 10);
    fill(255);
    rect(0, 0, w, h);
  }

  void onAbortClicked() 
  {		
    mainView.subviews.remove(this);
  }

  boolean contentClicked(float lx, float ly)
  {
    if (notApplicable.selected)
    {
      onAbortClicked();
      notApplicable.selected = false;
    }
    if (commit.selected)
    {
      onOkClicked();
      commit.selected = false;
    }
    return true;
  }
  void onOkClicked() 
  {
    if(current!= null){
    
      for(int i=0; i < current.checkboxes.size(); i++){
        IndividualCheckBox ich = current.checkboxes.get(i);
        
        if(ich.selected){
          parent.firstColumn = i+1;
          this.subviews.remove(current);
          current = null;
          parent.subviews.remove(parent.insertFirstValue);
          break;
        }
      }
    }
    if(expected!= null){
    
      for(int i=0; i < expected.checkboxes.size(); i++){
        IndividualCheckBox ich = expected.checkboxes.get(i);
        
        if(ich.selected){
          parent.secondColumn = i+1;
          this.subviews.remove(expected);
          expected = null;
          parent.subviews.remove(parent.insertSecondValue);
          break;
        }
      }
    }
    mainView.subviews.remove(this);
    popUpView = null;
  }
}

