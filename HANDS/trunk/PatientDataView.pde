class PatientDataView extends View 
{
	String title, entry;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	PatientDataView(float x_, float y_,float w_,float h_,String title)
	{
		super(x_, y_,w_ ,h_);
		this.title = title;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
        textAlign(LEFT,CENTER);
		// textLeading(fbold);
		fill(0);
		textSize(12);
		text(title,10,15);
		textFont(font);
		textSize(12);
		text(entry, 125,15);
		textFont(fbold);
	}
}
