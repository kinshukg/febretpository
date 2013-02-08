///////////////////////////////////////////////////////////////////////////////////////////////////
class SecondLevelRowView extends View 
{
	String title;
	String message;
	Button iconButton;
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
	Button qa1InfoButton;
	boolean qa1IsEBI = false; // True if quick action 1 is supported by evidence based information (will use different icons for buttons)
	
	StaticText qa2Text;
	Button qa2YesButton;
	Button qa2NoButton;
	Button qa2InfoButton;
	boolean qa2IsEBI = false; // True if quick action 2 is supported by evidence based information (will use different icons for buttons)
          
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onQuickActionButtonClicked(int action, boolean yesClicked)
	{
		// Quick action handler for Anxiety Self Control NOC
		if(this == pocManager.anxietySelfControlView)
		{
			if(action == 1)
			{
				if(yesClicked)
				{
					removeQuickActionButton1();
					pocManager.addNIC(NIC_CONSULTATION_TEXT, "", pocManager.anxietySelfControlView, IMG_CONSULTATION);
				}
				else
				{
					showPopUp();
				}
			}
			else if(action == 2)
			{
				if(yesClicked)
				{
					removeQuickActionButton2();
					pocManager.addNANDA(pocManager.nandaInterruptedFamilyProcess);
				}
				else
				{
					removeQuickActionButton2();
				}
			}
		}
		// Quick action handler for Mobility NOC
		else if(this == pocManager.NOCMobility)
		{
			if(action == 2)
			{
				if(yesClicked)
				{
					removeQuickActionButton2();
					pocManager.addNOC("Immobility Consequences","", pocManager.NANDAImpairedPhysicalMobility, IMG_IMMOBILITY_CONSEQUENCES);
				}
				else
				{
					removeQuickActionButton2();
				}
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView(String title,PImage logo, int firstColumn, int secondColumn, ColouredRowView parent)
	{
		super(0, 0,width,25);
		this.title = title;
		iconButton = new Button(0, 0, 16, 16, logo);
		subviews.add(iconButton);
		this.firstColumn = firstColumn;
		this.secondColumn = secondColumn;
		this.subs = new ArrayList();
		this.parent=  parent;
		parent.subs.add(this);
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
		iconButton.x = indent;
		iconButton.y = 4;
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
		text(title, indent + 35,12);
		
		if(parent.deleted)
		{
			line(0, 15, w, 15);
		}
		
		if(firstColumn != 0) text(firstColumn, 850, 12); else text("NR", 850, 12);
		if(secondColumn != 0) text(secondColumn, 950, 12); else text("NR", 950, 12);

		if(message != null)
		{
			fill(alertHighColor);
			text(message, 300, 12);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void enableQuickActionButton1(int cx, int textWidth, String text, boolean ebi, String infoText)
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
		cx += 28;
		
		qa1YesButton.helpText = "Add to plan of care";
		qa1NoButton.helpText = "Remove notification";
		
		qa1IsEBI = ebi;
		if(ebi)	qa1InfoButton = new Button(cx, 1, 24, 24, IMG_EBI);
		else qa1InfoButton = new Button(cx, 1, 24, 24, IMG_SUGGESTION);
		qa1InfoButton.tooltipText = infoText;
		subviews.add(qa1InfoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void enableQuickActionButton2(int cx, int textWidth, String text, boolean ebi, String infoText)
	{
		//float cx = 550;
		qa2Text = new StaticText(text);
		qa2Text.w = textWidth;
		qa2Text.x = cx;
		qa2Text.y = -20;
		subviews.add(qa2Text);
		cx += qa2Text.w - 10;
		qa2YesButton = new Button(cx, -22, 24, 24, checkIcon);
		subviews.add(qa2YesButton);
		cx += 28;
		qa2NoButton = new Button(cx, -22, 24, 24, crossIcon);
		subviews.add(qa2NoButton);
		cx += 28;
		
		// expand focus area fo this view to cover external button
		focusy = -20;
		focush = h;
		focusx = 30;
		
		qa2YesButton.helpText = "Add to plan of care";
		qa2NoButton.helpText = "Remove notification";

		qa2IsEBI = ebi;
		if(ebi)	qa2InfoButton = new Button(cx, -22, 24, 24, IMG_EBI);
		else qa2InfoButton = new Button(cx, -22, 24, 24, IMG_SUGGESTION);
		qa2InfoButton.tooltipText = infoText;
		subviews.add(qa2InfoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void removeQuickActionButton1()
	{
		subviews.remove(qa1NoButton);
		subviews.remove(qa1YesButton);
		subviews.remove(qa1Text);
		subviews.remove(qa1InfoButton);
		qa1NoButton = null;
		qa1YesButton = null;
		qa1Text = null;
		qa1InfoButton= null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void removeQuickActionButton2()
	{
		subviews.remove(qa2NoButton);
		subviews.remove(qa2YesButton);
		subviews.remove(qa2Text);
		subviews.remove(qa2InfoButton);
		qa2NoButton = null;
		qa2YesButton = null;
		qa2Text = null;
		qa2InfoButton= null;
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
	void removeAlertButton()
	{
		if(actionButton != null)
		{
			subviews.remove(actionButton);
			actionButton = null;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setGraphButton(int level, PImage graphIcon, GraphPopUpView p, int x)
	{
		color buttonColor = 200;
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
				qa1NoButton.selected = false;
				onQuickActionButtonClicked(1, false);
				stopBlinking();		
			}
		}
		if(qa1YesButton != null)
		{
			if(qa1YesButton.selected)
			{
				qa1YesButton.selected = false;
				onQuickActionButtonClicked(1, true);
				stopBlinking();		
			}
		}
		if(qa2YesButton != null)
		{
			if(qa2YesButton.selected)
			{
				qa2YesButton.selected = false;
				onQuickActionButtonClicked(2, true);
				stopBlinking();		
			}
		}
		if(qa2NoButton != null)
		{
			if(qa2NoButton.selected)
			{
				qa2NoButton.selected = false;
				onQuickActionButtonClicked(2, false);
				stopBlinking();		
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
