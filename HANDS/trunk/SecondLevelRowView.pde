///////////////////////////////////////////////////////////////////////////////////////////////////
class SecondLevelRowView extends View 
{
    POCManager pocManager;
	String title;
	String message;
	Button iconButton;
	StaticText commentBox;
	int firstColumn,secondColumn;
	public ArrayList subs ;
	int indent;

	ColouredRowView parent;
	
	// Popups
	PopUpViewBase actionPopUp;
	RatingPopUpView ratingPopUp;

	// CDS and rating Buttons
	Button actionButton;
	Button expectedRatingButton;
	Button currentRatingButton;
    
    // Native HANDS buttons
	Button addButton;
	Button removeButton;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView(String title,PImage logo, int firstColumn, int secondColumn, ColouredRowView parent, POCManager poc)
	{
		super(0, 0,width,25);
        pocManager = poc;
		this.title = title;
		iconButton = new Button(0, 0, 16, 16, logo);
		subviews.add(iconButton);
		this.firstColumn = firstColumn;
		this.secondColumn = secondColumn;
		this.subs = new ArrayList();
		this.parent=  parent;
		parent.subs.add(this);
		indent = 40;
        
        int cx = 320;
        
        addButton = new Button(cx += 28, 1, 24, 24, checkIcon); addButton.helpText = "Add NIC";
        removeButton = new Button(cx += 28, 1, 24, 24, checkIcon); removeButton.helpText = "Remove NOC";
        
        subviews.add(addButton);
        subviews.add(removeButton);
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
		}		
		
		textAlign(LEFT,CENTER);
		textFont(fbold);
		textSize(12);
		text(title, indent + 35,12);
		
		if(parent.deleted)
		{
			line(0, 15, w, 15);
		}
		
		// Draw expected and current rating text only if we are not using current / expected rating buttons for this NOC row.
		if(currentRatingButton == null)
		{
			if(firstColumn != 0) text(firstColumn, 850, 12); else text("NR", 850, 12);
		}
		
		if(expectedRatingButton == null)
		{
			if(secondColumn != 0) text(secondColumn, 950, 12); else text("NR", 950, 12);
		}

		if(message != null)
		{
			fill(alertHighColor);
			text(message, 300, 12);
		}
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
	void enableCurrentRatingButton()
	{
		color buttonColor = 200;
		color textColor = 0;
		currentRatingButton = new Button(840, 5, 0, 16, "NR", buttonColor, textColor);
		subviews.add(this.currentRatingButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void enableExpectedRatingButton()
	{
		color buttonColor = 200;
		color textColor = 0;
		expectedRatingButton = new Button(940, 5, 0, 16, "NR", buttonColor, textColor);
		subviews.add(this.expectedRatingButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void disableExpectedRatingButton()
	{
		subviews.remove(expectedRatingButton);
		expectedRatingButton = null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void showPopUp()
	{
		if(popUpView == null)
		{
			mainView.subviews.add(actionPopUp);
			popUpView = actionPopUp;
			actionPopUp.x = mouseX + 50;
			actionPopUp.y = mouseY - actionPopUp.h - 160; //350;
			actionPopUp.arrowX = mouseX;
			actionPopUp.arrowY = mouseY;
			if(actionPopUp.y < 50) actionPopUp.y = 50;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void showRatingPopUp()
	{
		if(popUpView == null)
		{
			// If rating popup has not been created, do it now.
			if(ratingPopUp == null)
			{
				ratingPopUp = new RatingPopUpView(this, iconButton.tooltipImage);
				ratingPopUp.reset();
			}
			
			mainView.subviews.add(ratingPopUp);
			popUpView = ratingPopUp;
			ratingPopUp.x = mouseX - 650;
			ratingPopUp.y = mouseY - 350;
			ratingPopUp.arrowX = mouseX;
			ratingPopUp.arrowY = mouseY;
			if(ratingPopUp.y < 50) ratingPopUp.y = 50;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(actionButton != null && actionButton.selected)
		{
			showPopUp();
			actionButton.selected = false;
		}
		if(expectedRatingButton != null && expectedRatingButton.selected)
		{
			showRatingPopUp();
			expectedRatingButton.selected = false;
		}
		if(currentRatingButton != null && currentRatingButton.selected)
		{
			showRatingPopUp();
			currentRatingButton.selected = false;
		}
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void stopBlinking()
	{
		if(actionButton != null) actionButton.blinking = false;
	}
}
