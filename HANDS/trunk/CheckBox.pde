///////////////////////////////////////////////////////////////////////////////////////////////////
class CheckBox extends View 
{
	boolean selected;
    boolean enabled = true;
	StaticText text;
	TextBox tb;
	Button iconButton;
	Button infoButton;
	float tw;
	
	int id;
	String tag;

	int checkX = 4;
	int checkY = 4;
	int checkW = 12;
	int checkH = 12;
	
	boolean textBoxEnabled = true;
	boolean textBoxAlwaysVisible = false;
	boolean radio = false;
	
	PopUpViewBase owner = null;
	PopUpSection ownerSection = null;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	CheckBox(String t, PImage icon1, int id)
	{
		super(0, 0,250,20); 
		this.id = id;
		selected = false;
		this.tag = t;
		text = new StaticText(t);
		subviews.add(text);
		
		if(icon1 != null)
		{
			iconButton = new Button(25, 2, 22, 22, icon1);
			subviews.add(iconButton);
		}
		interactive = true;
		this.selected = selected;
		tb = new TextBox(20,30);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	CheckBox(String t, String tag, PImage icon1, int id)
	{
		super(0, 0,250,20); 
		this.id = id;
		selected = false;
		this.tag = tag;
		text = new StaticText(t);
		subviews.add(text);
		interactive = true;
		if(icon1 != null)
		{
			iconButton = new Button(25, 2, 22, 22, icon1);
			subviews.add(iconButton);
		}
		
		this.selected = selected;
		tb = new TextBox(20,30);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	CheckBox(String t, String tag, PImage icon1, int id, PImage tooltipImage)
	{
		super(0, 0,250,20); 
		this.id = id;
		selected = false;
		this.tag = tag;
		text = new StaticText(t);
		subviews.add(text);
		interactive = true;
		if(icon1 != null)
		{
			iconButton = new Button(25, 2, 22, 22, icon1);
            iconButton.tooltipImage = tooltipImage;
			subviews.add(iconButton);
		}
		
		this.selected = selected;
		tb = new TextBox(20,30);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setInfoButton(String text)
	{
		infoButton = new Button(0, 0, 22, 22, infoIcon);
		infoButton.tooltipText = text;
		subviews.add(infoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setIconTooltip(String text)
	{
		if(iconButton != null)
		{
			iconButton.tooltipText = text;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setIconTooltipImage(PImage img)
	{
		if(iconButton != null)
		{
			iconButton.tooltipImage = img;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void showTextBox()
	{
		textBoxAlwaysVisible = true;
		this.subviews.add(tb);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		if(infoButton != null)
		{
			infoButton.x = text.maxTextWidth + text.x + 10;
		}
		
		w = popUpView.w;
		
		if(textBoxAlwaysVisible)
		{
			tb.x = text.maxTextWidth + text.x + 10;
			tb.w = popUpView.w - tb.x - x - 20;
			tb.y = 0;
		}
		else
		{
			// The following code overlays the comment box on top of text
			// tb.x = tw + 50;
			// tb.w = popUpView.w - tw - 70;
			// tb.y = 0;
			
			// The following code puts the comment box at the right edge of this view, and applies a fixed width.
			tb.w = popUpView.w - 300;
			tb.x = w - tb.w - 20;
			
			
			tb.y = 0;
		}
		
		if(iconButton != null)
		{
			text.x = 50;
		}
		else
		{
			text.x = 25;
		}
		text.y = 2;
		text.w = w;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		textAlign(LEFT,CENTER);
		
		color checkColor = #333333;

		checkX = 4;
		checkY = 4;
		checkW = 12;
		checkH = 12;
	
		//fill(#ffffee);
		//rect(0, 0, w, h);
		
        if(enabled)
        {
            text.textColor = color(0);
            if(radio)
            {
                checkX = 2;
                checkY = 2;
                checkW = 16;
                checkH = 16;
                
                stroke(0);
                noFill();
                ellipseMode(CORNER);
                ellipse(checkX, checkY, checkW, checkH);
                if(selected)
                {
                    checkX += 4;
                    checkY += 4;
                    checkW -= 8;
                    checkH -= 8;
                    fill(checkColor, 255);
                    ellipse(checkX, checkY, checkW, checkH);
                }
            }
            else
            {
                gu.drawBox(checkX, checkY, checkW, checkH, 1, 0, 255);
                gu.drawBox(checkX, checkY, checkW, checkH, 2, 0, 60);
                if(selected)
                {
                    checkX += 4;
                    checkY += 4;
                    checkW -= 8;
                    checkH -= 8;
                    gu.drawBox(checkX, checkY, checkW, checkH, 1, checkColor, 180);
                    fill(checkColor, 255);
                    rect(checkX, checkY, checkX + checkW, checkY + checkH + 1);
                }
            }
        }
        else
        {
            text.textColor = color(128);
        }
		
		fill(0);
	}
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
        if(!enabled) return false;
        
		int margin = 4;
		if(lx > checkX - margin && lx < checkX + checkW + margin &&
			ly > checkY - margin && ly < checkY + checkH + margin)
		{
			selected =!selected;
			if(owner != null) owner.onCheckBoxChanged(this);
			if(radio && ownerSection != null) ownerSection.onRadioButtonChanged(this);
			//if(selected) tb.activate();
			//else tb.deactivate();
            
            // Cycle 4 Commented: disabled comment feature for dry run.
			/*if(!textBoxAlwaysVisible)
			{
				if(selected)
				{
					if(textBoxEnabled) this.subviews.add(tb);
					//this.h = 60; 
				} 
				else	
				{
					if(textBoxEnabled) this.subviews.remove(tb);
					//this.h = 20; 
				}
			}*/
		}
		return true;
	}

}


