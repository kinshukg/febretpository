///////////////////////////////////////////////////////////////////////////////////////////////////
class SecondLevelRowView extends View 
{
	String title;
	PImage logo;
	int firstColumn,secondColumn;
	public ArrayList subs ;
	Button graphButton, actionButton;
	public PopUpView actionPopUp, graphPopUp;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView(float x_, float y_,String title,PImage logo, int firstColumn, int secondColumn)
	{
		super(x_, y_,width,25);
		this.title = title;
		this.logo = logo;
		this.firstColumn = firstColumn;
		this.secondColumn = secondColumn;
		this.subs = new ArrayList();
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
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
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setAlertButton(int level, PopUpView p)
	{
		color buttonColor = 0;
		if(level == 1)
		buttonColor = alertLowColor;
		if(level == 2)
		buttonColor = alertMidColor;
		if(level == 3)
		buttonColor = alertHighColor;

		this.actionButton = new Button(450, 6, 35, 14, "", buttonColor, 255);
		subviews.add(this.actionButton);
		
		this.actionButton.tooltipText = "Tooltip text, bla bla bla ba bla blag askdj sfjwev fweic";
		this.actionButton.tooltipMode = 1;

		this.actionPopUp = p;   
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		if(actionButton != null)
		{
			if(actionButton.selected)
			{
				if(!mainView.subviews.contains(actionPopUp)) mainView.subviews.add(actionPopUp);
				actionPopUp.arrowX = mouseX;
				actionPopUp.arrowY = mouseY;
				actionButton.selected = false;
			}
			else
			{
				mainView.subviews.remove(actionPopUp);
			}
		}
		return true;
	}
}
