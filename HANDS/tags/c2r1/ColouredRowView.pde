class ColouredRowView extends View 
{
	String title;
	public ArrayList subs;  
	boolean deleted = false;
	StaticText commentBox;
	int indent;
	
	Button iconButton;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ColouredRowView(String title,PImage logo)
	{
		super(0, 0,width,25);
		this.title = title;
		this.subs = new ArrayList();
		
		iconButton = new Button(0, 0, 16, 16, logo);
		iconButton.tooltipImage = IMG_IMP_GAS_EXC;
		subviews.add(iconButton);
		
		indent = 10;
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
		iconButton.y = 12;
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
