class ThirdLevelRowView extends View 
{
	String title;
	Button iconButton;
	SecondLevelRowView parent;
	int indent;
	StaticText commentBox;
  
    // Native HANDS buttons
	Button removeButton;
    
	////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView(String title,PImage logo, SecondLevelRowView parent_)
	{
		super(0, 0,width,25);
		this.title = title;

		iconButton = new Button(0, 0, 16, 16, logo);
		subviews.add(iconButton);
		
		parent = parent_;
		parent.subs.add(this);  
		indent = 70;
        
        int cx = 360;
        removeButton = new Button(cx += 20, 4, 24, 24, crossIcon); removeButton.helpText = "Remove NOC";
        
        subviews.add(removeButton);
	}

	////////////////////////////////////////////////////////////////////////////
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
	
	////////////////////////////////////////////////////////////////////////////
	void addComment(String comment)
	{
		commentBox = new StaticText(comment);
		commentBox.w = w;
		subviews.add(commentBox);
	}
	
	////////////////////////////////////////////////////////////////////////////
    void draw()
    {
        super.draw(!parent.parent.deleted);
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mousePressed(float px, float py)
    {
        if(!parent.parent.deleted) return super.mousePressed(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mouseMoved(float px, float py)
    {
        if(!parent.parent.deleted) return super.mouseMoved(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mouseReleased(float px, float py)
    {
        if(!parent.parent.deleted) return super.mouseReleased(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mouseClicked(float px, float py)
    {
        if(!parent.parent.deleted) return super.mouseClicked(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
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
		textAlign(LEFT,CENTER);
		text(title, indent +  35,12);
		
		// if(parent.parent.deleted)
		// {
			// line(0, 15, w, 15);
		// }
	}
    
	////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(removeButton != null && removeButton.selected)
		{
			parent.pocManager.removeNIC(this);
			removeButton.selected = false;
		}
        return true;
    }
}
