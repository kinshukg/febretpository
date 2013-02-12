class IndividualCheckBox extends View 
{
	boolean selected;
	String caption;
        int id;
        Rating ratingGroup;
        int checkX = 4;
	int checkY = 4;
	int checkW = 12;
	int checkH = 12;

        IndividualCheckBox(float x, float y, String caption, int id, Rating ratingGroup){
        
          super(x,y,250,20);
          this.id = id;
          this.caption = caption;
          this.ratingGroup  = ratingGroup;
          this.selected = false;
        }
        
        void drawContent(){
        
          strokeWeight(2);
          stroke(0);
          if(!selected)
          fill(255);
          else
          fill(0);
         
          rect(0,0,20,20);
          strokeWeight(1);
          noStroke();
          
          textFont(fbold);
          textSize(12);
          fill(0);
          text(caption, 35,7); 
            
    
        }
        boolean contentClicked(float lx, float ly)
	{
		int margin = 7;
		if(lx > checkX - margin && lx < checkX + checkW + margin &&
			ly > checkY - margin && ly < checkY + checkH + margin)
		{
			selected =!selected;
                        if(selected)
                          this.ratingGroup.toggle(id);
                        return true;
      }
else{
return false;
}      
            
  }
}

