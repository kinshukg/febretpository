///////////////////////////////////////////////////////////////////////////////////////////////////
class SecondLevelRowView extends View 
{
	String title;
	String message;
	PImage logo;
	String comment = "";
	int firstColumn,secondColumn;
	public ArrayList subs ;

	Button graphButton, actionButton;
	Button infoButton;

	PopUpView actionPopUp;
	GraphPopUpView graphPopUp;
	ColouredRowView parent;
          
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView(float x_, float y_,String title,PImage logo, int firstColumn, int secondColumn, ColouredRowView parent)
	{
		super(x_, y_,width,25);
		this.title = title;
		this.logo = logo;
		this.firstColumn = firstColumn;
		this.secondColumn = secondColumn;
		this.subs = new ArrayList();
		this.parent=  parent;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		if(!comment.equals("")) h = 50;
		else h = 25;
		stroke(0);
		
		fill(secondLevelRowColor);
		rect(-1,0,w+10,h);
		fill(0);
		textSize(12);
		image(logo,40,4);
		text(title,75,12);
		
		if(firstColumn != 0) text(firstColumn, 650, 12);
		if(secondColumn != 0) text(secondColumn, 750, 12);

		if(message != null)
		{
			fill(alertHighColor);
			text(message, 200, 12);
		}
		if(!comment.equals(""))
		{
			textFont(font);
			textSize(12);
			text(comment,100, 32);
			textFont(fbold);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setAlertButton(int level, PopUpView p)
	{
		color buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;

		if(OPTION_LONG_ALERT_BUTTON)
		{
			this.actionButton = new Button(200, 6, 0, 14, "Mrs. Taylor's Pain Level is not controlled.", buttonColor, 0);
		}
		else 
		{
			this.actionButton = new Button(450, 6, 0, 14, "ACTIONS", buttonColor, 0);
			this.message = "Mrs. Taylor's Pain Level is not controlled.";
		}
		subviews.add(this.actionButton);
		
		if(OPTION_ALERT_INFO_BUTTON)
		{
			infoButton = new Button(520, 6, 16, 16, infoIcon);
			infoButton.tooltipText = 
				"This requires action because analysis of similar patient's data shows: BULLET \n " +
				"* It is difficult to control Pain in EOL ptients who also have impaired Gas Exchange\n " + 
				"* >50% of EOL patients do not achieve expected NOC Pain Rating by discharge or death\n";
			subviews.add(infoButton);
		}
		
		//this.actionButton.tooltipText = "Tooltip text, bla bla bla ba bla blag askdj sfjwev fweic";
		//this.actionButton.tooltipMode = 1;

		this.actionPopUp = p;   
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void setGraphButton(int level, PImage graphIcon, GraphPopUpView p)
	{
		color buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;
		graphButton = new Button(550, 5, 50, 16, graphIcon);
		graphButton.transparent = false;
		graphButton.buttonColor = buttonColor;
		subviews.add(this.graphButton);
		this.graphPopUp = p;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		if(actionButton != null)
		{
			if(actionButton.selected)
			{
				if(popUpView == null)
				{
					mainView.subviews.add(actionPopUp);
					popUpView = actionPopUp;
					actionPopUp.x = mouseX + 50;
					actionPopUp.y = mouseY - 250;
					actionPopUp.arrowX = mouseX;
					actionPopUp.arrowY = mouseY;
					actionButton.selected = false;
				}
			}
		}
		if(graphButton != null)
		{
			if(graphButton.selected)
			{
				if(popUpView == null)
				{
					mainView.subviews.add(graphPopUp);
					popUpView = graphPopUp;
					graphPopUp.x = mouseX + 20;
					graphPopUp.y = mouseY - 50;
					graphPopUp.arrowX = mouseX;
					graphPopUp.arrowY = mouseY;
					graphButton.selected = false;
				}
			}
		}
		return true;
	}
}
