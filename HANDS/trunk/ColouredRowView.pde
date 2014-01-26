class ColouredRowView extends View 
{
	String title;
	public ArrayList subs;  
	boolean deleted = false;
	StaticText commentBox;
	int indent;
	
	Button iconButton;
	
    // Native HANDS buttons
	Button addButton;
	Button removeButton;
	Button prioritizeButton;
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	ColouredRowView(String title,PImage logo)
	{
		super(0, 0,width,25);
		this.title = title;
		this.subs = new ArrayList();
		
		iconButton = new Button(0, 0, 16, 16, logo);
		subviews.add(iconButton);
		
		indent = 10;
        
        int cx = 320;
        
        addButton = new Button(cx += 28, 1, 24, 24, checkIcon); addButton.helpText = "Add NIC";
        removeButton = new Button(cx += 28, 1, 24, 24, checkIcon); removeButton.helpText = "Remove NOC";
        prioritizeButton = new Button(cx += 28, 1, 24, 24, checkIcon); prioritizeButton.helpText = "Prioritize NOC";
        
        subviews.add(addButton);
        subviews.add(removeButton);
        subviews.add(prioritizeButton);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void markDeleted()
	{
		deleted = true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addComment(String comment)
	{
		commentBox = new StaticText(comment);
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
		iconButton.x = indent;
		iconButton.y = 4;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		stroke(0);
		fill(colouredRowColor);
		rect(-1,0,w+10,h);
		fill(0);
		
		if(deleted)
		{
			stroke(STYLE_DELETED_ROW_BACK_COLOR);
			fill(STYLE_DELETED_ROW_BACK_COLOR);
		}
		
		textAlign(LEFT,CENTER);
		textFont(fbold);
		textSize(12);
		
		text(title, indent + 35,12);
		
		if(deleted)
		{
			line(0, 15, w, 15);
		}
	}
}
