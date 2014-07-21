////////////////////////////////////////////////////////////////////////////////
class PopUpViewBase extends View 
{
	float arrowX, arrowY;
	Button commit, notApplicable;
	SecondLevelRowView parent;
	ClosePopUpView close;
    
    ColouredRowView NANDAParent;
    SecondLevelRowView NOCParent;
    
    // If this popup is a CDS popup, it will be removed (together with its action button)
    // from a NOC line.
    boolean cds = false;
    
    // If delayedEnabled is set to true, this popup will be re-enabled
    // on next shift (only works for CDS popups)
    boolean delayedEnable = false;
	
	////////////////////////////////////////////////////////////////////////////
	PopUpViewBase(float w_, SecondLevelRowView parent)
	{
		super(0, 0,w_ ,0);
		close = new ClosePopUpView(0,-20,w,20);
		this.subviews.add(close);
		
		//commit = new Button(20,0,150,20,"Save Changes",0,255);
		//notApplicable = new Button(200,0,180,20,"Mark as Read",0,255);
		commit = new Button(20,0,150,20,"Save to POC",200,0);
		notApplicable = new Button(200,0,180,20,"Close without saving",200,0);
		
		this.subviews.add(commit);
		this.subviews.add(notApplicable);	
		this.parent = parent;
	}
	
	////////////////////////////////////////////////////////////////////////////
    void show()
    {
        mainView.subviews.add(this);
        popUpView = this;
        x = mouseX + 50;
        y = mouseY - h - 160; //350;
        arrowX = mouseX;
        arrowY = mouseY;
        if(y < 50) y = 50;
    }
    
	////////////////////////////////////////////////////////////////////////////
	void hide() 
	{
		mainView.subviews.remove(this);
		popUpView = null;
		if(activeTextBox != null) activeTextBox.deactivate();
	}
	
	////////////////////////////////////////////////////////////////////////////
	void reset()
	{
	}
	
	////////////////////////////////////////////////////////////////////////////
	void layout()
	{
        h = 0;
		for(int i = 0; i < subviews.size();i++)
		{
			View v = (View)popUpView.subviews.get(i);
            v.y = h;
            h += v.h;
			if(v != commit && v != notApplicable && v != close)
			{
				v.w = this.w - 16;
			}
		}
		
		// v2.1: popup never goes off-screen vertically.
		if(y + h > SCREEN_HEIGHT)
		{
			y = SCREEN_HEIGHT - h;
		}
	}

	////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		rectMode(CORNERS);
		strokeWeight(1);
		int ys = 0;
		for(int i = 0 ;i<subviews.size();i++)
		{
			View v = (View)subviews.get(i);

			if(!v.equals(commit) && !v.equals(notApplicable))
			{
				v.y = ys;
				ys +=v.h;
			}
		}
		
		commit.y = ys;
		notApplicable.y = ys;  

		int border = 5;
		fill(0, 0, 0, 180);
		noStroke();
		rect(-border, -border, w + border, h + border);
		triangle(-border, 10, arrowX - x, arrowY - y, -border, ys - 10);
		fill(255);
		rect(0, 0, w, h);
	}
	
	////////////////////////////////////////////////////////////////////////////
	void onAbortClicked() 
	{
		//parent.stopBlinking();		
		hide();
	}
	
	////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
	}
	
	////////////////////////////////////////////////////////////////////////////
	void onOkClicked() 
	{
	}
	
	////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(notApplicable.selected)
		{
			onAbortClicked();
			notApplicable.selected = false;
		}
		if(commit.selected)
		{
			onOkClicked();
			commit.selected = false;
		}
		return true;
	}
    
	////////////////////////////////////////////////////////////////////////////
    CheckBox findAction(String tag)
    {
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    if(c.tag.equals(tag)) return c;
                }
            }
        }
        return null;
    }
    
	////////////////////////////////////////////////////////////////////////////
    void onNICAdded(ThirdLevelRowView nic)
    {
        // If a NIC has been added, check the nic list in this popup and disable the relative
        // checkbox if you find it.
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    // Ignore radio buttons. Only action checkboxes.
                    if(!c.radio)
                    {
                        if(c.enabled && c.tag.equals(nic.title))
                        {
                            c.enabled = false;
                        }
                    }
                }
            }
        }
        checkCDSEnabled(true);
    }
    
	////////////////////////////////////////////////////////////////////////////
    void onNICRemoved(ThirdLevelRowView nic)
    {
        // If a NIC has been removed, check the nic list in this popup and enable the relative
        // checkbox if you find it.
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    // Ignore radio buttons. Only action checkboxes.
                    if(!c.radio)
                    {
                        if(!c.enabled && c.tag.equals(nic.title))
                        {
                            c.enabled = true;
                            c.selected = false;
                        }
                    }
                }
            }
        }
        checkCDSEnabled(false);
    }
    
	////////////////////////////////////////////////////////////////////////////
    void onNOCRemoved(SecondLevelRowView nic)
    {
        // If a NOC has been removed, check the noc list in this popup and enable the relative
        // checkbox if you find it.
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    // Ignore radio buttons. Only action checkboxes.
                    if(!c.radio)
                    {
                        if(!c.enabled && c.tag.equals(nic.title))
                        {
                            c.enabled = true;
                            c.selected = false;
                        }
                    }
                }
            }
        }
        checkCDSEnabled(false);
    }
    
	////////////////////////////////////////////////////////////////////////////
    void onNOCAdded(SecondLevelRowView nic)
    {
        // If a NIC has been added, check the nic list in this popup and disable the relative
        // checkbox if you find it.
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    // Ignore radio buttons. Only action checkboxes.
                    if(!c.radio)
                    {
                        if(c.enabled && c.tag.equals(nic.title))
                        {
                            c.enabled = false;
                        }
                    }
                }
            }
        }
        checkCDSEnabled(true);
    }
    
	////////////////////////////////////////////////////////////////////////////
    void onNANDAAdded(ColouredRowView nic)
    {
        // If a NIC has been added, check the nic list in this popup and disable the relative
        // checkbox if you find it.
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    // Ignore radio buttons. Only action checkboxes.
                    if(!c.radio)
                    {
                        if(c.enabled && c.tag.equals(nic.title))
                        {
                            c.enabled = false;
                        }
                    }
                }
            }
        }
        checkCDSEnabled(true);
    }
    
	////////////////////////////////////////////////////////////////////////////
    void checkCDSEnabled(boolean adding)
    {
        if(!cds) return;
        
        boolean anyEnabled = false;
		for(int i = 0; i < subviews.size(); i++)
		{
            if(!(subviews.get(i) instanceof PopUpSection)) continue;
            
            PopUpSection pps = (PopUpSection)subviews.get(i);
            if(pps.actionBoxes != null) 
            {
                for(int j = 0; j < pps.actionBoxes.size(); j++)
                {
                    CheckBox c = pps.actionBoxes.get(j);
                    // Ignore radio buttons. Only action checkboxes.
                    if(!c.radio) anyEnabled |= c.enabled;
                }
            }
        }
        if(!adding && anyEnabled && parent.actionButton == null)
        {
            //parent.actionPopUp = this;
            int alertButtonX = 460;
            // Tis is the image that appears in the long access bar button.
            PImage painLevelActionButtonImage = null;
            parent.setAlertButton(3, "Action required", alertButtonX, painLevelActionButtonImage);
        }
        else if(adding && !anyEnabled && parent.actionButton != null)
        {
			parent.removeAlertButton();
        }
    }
}
