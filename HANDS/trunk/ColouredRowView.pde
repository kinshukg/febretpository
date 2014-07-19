class ColouredRowView extends View 
{
    POCManager poc;
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
    
    PopUpViewBase popup;
    
	////////////////////////////////////////////////////////////////////////////
	ColouredRowView(String title,PImage logo)
	{
		super(0, 0,width,25);
		this.title = title;
		this.subs = new ArrayList();
		
		iconButton = new Button(0, 0, 16, 16, logo);
		subviews.add(iconButton);
		
		indent = 10;
        
        int cx = 360;
        
        addButton = new Button(cx += 20, 4, 24, 24, plusIcon); addButton.helpText = "Add NOC";
        removeButton = new Button(cx += 20, 4, 24, 24, crossIcon); removeButton.helpText = "Remove NANDA";
        prioritizeButton = new Button(cx += 20, 4, 24, 24, prioritizeIcon); prioritizeButton.helpText = "Prioritize NANDA";
        
        subviews.add(addButton);
        subviews.add(removeButton);
        subviews.add(prioritizeButton);
	}

	////////////////////////////////////////////////////////////////////////////
	void markDeleted()
	{
		deleted = true;
	}
	
	////////////////////////////////////////////////////////////////////////////
	void addComment(String comment)
	{
		commentBox = new StaticText(comment);
		commentBox.w = w;
		subviews.add(commentBox);
	}
	
	////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(prioritizeButton != null && prioritizeButton.selected)
		{
            poc.prioritizeNANDA(this);
			prioritizeButton.selected = false;
		}
        else if(removeButton != null && removeButton.selected)
        {
            poc.deleteNANDA(this);
			removeButton.selected = false;
        }
        else if(addButton != null && addButton.selected)
        {
            if(popUpView == null)
            {
                log("OpenNativeNOCPopup " + title);
                
                poc.NOCPopup.NANDAParent = this;
                poc.NOCPopup.show();
            }
			addButton.selected = false;
        }
		return true;
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
    void draw()
    {
        super.draw(!deleted);
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mousePressed(float px, float py)
    {
        if(!deleted) return super.mousePressed(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mouseMoved(float px, float py)
    {
        if(!deleted) return super.mouseMoved(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mouseReleased(float px, float py)
    {
        if(!deleted) return super.mouseReleased(px, py);
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
    boolean mouseClicked(float px, float py)
    {
        if(!deleted) return super.mouseClicked(px, py);
        if (ptInRect(px, py, x + focusx, y + focusy, w + focusw, h + focush))
        {        
            // If line was deleted, clickin on it restores it.
            poc.restoreNANDA(this);
            return true;
        }
        return false;
    }
    
	////////////////////////////////////////////////////////////////////////////
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
            fill(0);
            text("Click here to restore deleted NANDA", indent + 350, 12);
		}
	}
}
