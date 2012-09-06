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

	PopUpViewBase actionPopUp;
	
	GraphPopUpView graphPopUp;
	ColouredRowView parent;
	
	// Cycle 2 stuff
	StaticText qa1Text;
	Button qa1YesButton;
	Button qa1NoButton;
	
	StaticText qa2Text;
	Button qa2YesButton;
	Button qa2NoButton;
          
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
		if(comment == "")
		{
			if(commentBox != null)
			{
				subviews.remove(commentBox);
				commentBox = null;
			}
		}
		else
		{
			if(commentBox == null)
			{
				commentBox = new StaticText(comment);
				subviews.add(commentBox);
				commentBox.w = w;
			}
			else
			{
				commentBox.setText(comment);
			}
		}
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
		
		fill(secondLevelRowColor);
		rect(-1,0,w+10,h);
		fill(0);
		
		if(parent.deleted)
		{
			stroke(STYLE_DELETED_ROW_BACK_COLOR);
			fill(STYLE_DELETED_ROW_BACK_COLOR);
			if(graphButton != null)
			{
				subviews.remove(graphButton);
				graphButton = null;
			}
		}		
		
		textAlign(LEFT,CENTER);
		textFont(fbold);
		textSize(12);
		image(logo, indent,4);
		text(title, indent + 35,12);
		
		if(parent.deleted)
		{
			line(0, 15, w, 15);
		}
		
		if(firstColumn != 0) text(firstColumn, 850, 12);
		if(secondColumn != 0) text(secondColumn, 950, 12);

		if(message != null)
		{
			fill(alertHighColor);
			text(message, 170, 12);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void enableQuickActionButton1(int cx, int textWidth, String text)
	{
		//float cx = 250;
		qa1Text = new StaticText(text);
		qa1Text.w = textWidth;
		qa1Text.x = cx;
		qa1Text.y = 4;
		subviews.add(qa1Text);
		cx += qa1Text.w - 10;
		qa1YesButton = new Button(cx, 1, 24, 24, checkIcon);
		subviews.add(qa1YesButton);
		cx += 28;
		qa1NoButton = new Button(cx, 1, 24, 24, crossIcon);
		subviews.add(qa1NoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void enableQuickActionButton2(int cx, int textWidth, String text)
	{
		//float cx = 550;
		qa2Text = new StaticText(text);
		qa2Text.w = textWidth;
		qa2Text.x = cx;
		qa2Text.y = 4;
		subviews.add(qa2Text);
		cx += qa2Text.w - 10;
		qa2YesButton = new Button(cx, 1, 24, 24, checkIcon);
		subviews.add(qa2YesButton);
		cx += 28;
		qa2NoButton = new Button(cx, 1, 24, 24, crossIcon);
		subviews.add(qa2NoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void removeQuickActionButton1()
	{
		subviews.remove(qa1NoButton);
		subviews.remove(qa1YesButton);
		subviews.remove(qa1Text);
		qa1NoButton = null;
		qa1YesButton = null;
		qa1Text = null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void removeQuickActionButton2()
	{
		subviews.remove(qa2NoButton);
		subviews.remove(qa2YesButton);
		subviews.remove(qa2Text);
		qa2NoButton = null;
		qa2YesButton = null;
		qa2Text = null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setInfoButton(int bx, String text)
	{
		infoButton = new Button(bx, 1, 24, 24, infoIcon);
		infoButton.tooltipText = text;
		subviews.add(infoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setAlertButton(int level, String text, int bx, PImage graph)
	{
		color buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;

		this.actionButton = new Button(bx, 5, 0, 16, text, buttonColor, 0);
		this.actionButton.blinking = true;
		subviews.add(this.actionButton);
		
		if(graph != null)
		{
			this.actionButton.icon = graph;
		}
		
		//this.actionButton.tooltipText = "Tooltip text, bla bla bla ba bla blag askdj sfjwev fweic";
		//this.actionButton.tooltipMode = 1;

		//this.actionPopUp = p;   
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
	void showPopUp()
	{
		if(popUpView == null)
		{
			mainView.subviews.add(actionPopUp);
			popUpView = actionPopUp;
			actionPopUp.x = mouseX + 50;
			actionPopUp.y = mouseY - 350;
			actionPopUp.arrowX = mouseX;
			actionPopUp.arrowY = mouseY;
			if(actionPopUp.y < 50) actionPopUp.y = 50;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(qa1NoButton != null)
		{
			if(qa1NoButton.selected)
			{
				showPopUp();
			}
		}
		if(qa1YesButton != null)
		{
			if(qa1YesButton.selected)
			{
				removeQuickActionButton1();
				pocManager.addNIC(NIC_CONSULTATION_TEXT, "", pocManager.anxietySelfControlView);
			}
		}
		if(qa2YesButton != null)
		{
			if(qa2YesButton.selected)
			{
				removeQuickActionButton2();
				pocManager.addNANDA(pocManager.nandaInterruptedFamilyProcess);
			}
		}
		if(qa2NoButton != null)
		{
			if(qa2NoButton.selected)
			{
				removeQuickActionButton1();
			}
		}
		if(actionButton != null)
		{
			if(actionButton.selected)
			{
				showPopUp();
				actionButton.selected = false;
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
				}
				graphButton.selected = false;
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
