class ColouredRowView extends View 
{
	String title;
	PImage logo;
	public ArrayList subs;  
	boolean deleted = false;
	StaticText commentBox;
	int indent;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ColouredRowView(String title,PImage logo)
	{
		super(0, 0,width,25);
		this.title = title;
		this.logo = logo;
		this.subs = new ArrayList();
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
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		if(deleted)
		{
			stroke(0);
			fill(STYLE_DELETED_ROW_BACK_COLOR);
			rect(-1,0,w+10,h);
			fill(0);
		}
		else
		{
			stroke(0);
			fill(colouredRowColor);
			rect(-1,0,w+10,h);
			fill(0);
		}
		
		textAlign(LEFT,CENTER);
		textFont(fbold);
		textSize(12);
		image(logo, indent,6);
		text(title, indent + 35,12);
	}
}
