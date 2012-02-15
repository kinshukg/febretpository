///////////////////////////////////////////////////////////////////////////////////////////////////
class SecondLevelRowView extends View 
{
	String title;
	String message;
	PImage logo;
	StaticText commentBox;
	int firstColumn,secondColumn;
	public ArrayList subs ;
	int indent;

	Button graphButton, actionButton;
	Button infoButton;

	PopUpView actionPopUp;
	GraphPopUpView graphPopUp;
	ColouredRowView parent;
          
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView(String title,PImage logo, int firstColumn, int secondColumn, ColouredRowView parent)
	{
		super(0, 0,width,25);
		this.title = title;
		this.logo = logo;
		this.firstColumn = firstColumn;
		this.secondColumn = secondColumn;
		this.subs = new ArrayList();
		this.parent=  parent;
		indent = 40;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void addComment(String comment)
	{
		commentBox = new StaticText(comment, FORMAT_NORMAL);
		commentBox.w = w;
		subviews.add(commentBox);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		h = 25;
		if(commentBox != null)
		{
			commentBox.y = h;
			commentBox.x = indent + 80;
			h += 25;
		}
	}
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		stroke(0);
		
		if(parent.deleted)
		{
			fill(STYLE_DELETED_ROW_BACK_COLOR);
			rect(-1,0,w+10,h);
			fill(0);
		}
		else
		{
			fill(secondLevelRowColor);
			rect(-1,0,w+10,h);
			fill(0);
		}
		textAlign(LEFT,CENTER);
		textSize(12);
		image(logo, indent,4);
		text(title, indent + 35,12);
		
		if(firstColumn != 0) text(firstColumn, 650, 12);
		if(secondColumn != 0) text(secondColumn, 750, 12);

		if(message != null)
		{
			fill(alertHighColor);
			text(message, 170, 12);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setAlertButton(int level, PopUpView p, PImage graph)
	{
		color buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;

		if(OPTION_LONG_ALERT_BUTTON)
		{
			this.actionButton = new Button(250, 5, 0, 16, "Mrs. Taylor's Pain Level is not controlled.", buttonColor, 0);
		}
		else 
		{
			this.actionButton = new Button(450, 5, 0, 16, "Actions", buttonColor, 0);
			this.message = "Mrs. Taylor's Pain Level is not controlled.";
		}
		this.actionButton.blinking = true;
		subviews.add(this.actionButton);
		
		if(graph != null)
		{
			this.actionButton.icon = graph;
		}
		
		if(OPTION_ALERT_INFO_BUTTON)
		{
			infoButton = new Button(520, 1, 24, 24, infoIcon);
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
	void setGraphButton(int level, PImage graphIcon, GraphPopUpView p, int x)
	{
		color buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;
		graphButton = new Button(x, 5, 40, 16, graphIcon);
		graphButton.transparent = false;
		graphButton.buttonColor = buttonColor;
		subviews.add(this.graphButton);
		if(level == 3) graphButton.blinking = true;
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
					actionPopUp.y = mouseY - 350;
					actionPopUp.arrowX = mouseX;
					actionPopUp.arrowY = mouseY;
					actionButton.selected = false;
					
					if(actionPopUp.y < 50) actionPopUp.y = 50;
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
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void stopBlinking()
	{
		if(actionButton != null) actionButton.blinking = false;
		if(graphButton != null) graphButton.blinking = false;
	}
}
