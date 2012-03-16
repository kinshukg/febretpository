class ThirdLevelRowView extends View 
{
	String title;
	PImage logo;
	SecondLevelRowView parent;
	int indent;
	StaticText commentBox;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView(String title,PImage logo, SecondLevelRowView parent_)
	{
		super(0, 0,width,25);
		this.title = title;
		this.logo = logo;
		parent = parent_;
		indent = 60;
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
	void addComment(String comment)
	{
		commentBox = new StaticText(comment);
		commentBox.w = w;
		subviews.add(commentBox);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		stroke(0);
		fill(thirdLevelRowColor);
		rect(-1,0,w+10,h);
		fill(0);
		
		if(parent.parent.deleted)
		{
			stroke(STYLE_DELETED_ROW_BACK_COLOR);
			fill(STYLE_DELETED_ROW_BACK_COLOR);
		}		
		
		textSize(12);
		textFont(fbold);
		image(logo, indent, 4);
		textAlign(LEFT,CENTER);
		text(title, indent +  35,12);
		
		if(parent.parent.deleted)
		{
			line(0, 15, w, 15);
		}
	}
}
