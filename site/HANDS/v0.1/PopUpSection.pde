class PopUpSection extends View 
{
	String title;
	
	StaticText titleBox;
	StaticText descriptionBox;
	
	Button titleButton;
	int titleButtonMode;
	
	int separatorStyle;
	ArrayList<CheckBox> actionBoxes;

	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpSection(float x_, float y_, ArrayList<CheckBox> actions, String title)
	{
		super(x_, y_, 400, 0);
		if(actions != null) 
		{
			h = 60 + (actions.size() * 20);
		}
		else
		{
			h = 60;
		}
		
		this.title = title;
		this.titleBox = new StaticText(title, FORMAT_HEADING1);
		subviews.add(titleBox);
		
		actionBoxes = actions;
		
		if(actions != null)
		{
			int ys = 35;
			for(int i = 0; i < actions.size(); i++)
			{
				CheckBox c = actions.get(i);
				c.y = ys;
				this.subviews.add(c);
				ys += 25;
			}
		}		
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setDescription(String text)
	{
		descriptionBox = new StaticText(text, FORMAT_NORMAL);
		subviews.add(descriptionBox);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setInfoButton(String text)
	{
		titleButton = new Button(0, 0, 16, 16, infoIcon);
		titleButton.tooltipMode = 1;
		titleButton.tooltipText = text;
		subviews.add(titleButton);
		titleButtonMode = 1;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void enableExpandableDescription()
	{
		titleButton = new Button(0, 0, 16, 16, infoIcon);
		subviews.add(titleButton);
		titleButtonMode = 2;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		if(titleButton != null)
		{
			titleButton.y = 2;
			titleButton.x = 0;
			titleButton.w = 16;
			titleButton.h = 16;
			titleBox.x = 20;
		}
		else
		{
			titleBox.x = 0;
		}
		titleBox.w = w;
		h = titleBox.h + 5;
		if(descriptionBox != null)
		{
			if(titleButtonMode == 2)
			{
				descriptionBox.visible = titleButton.selected;
				if(titleButton.selected)
				{
					descriptionBox.y = titleBox.h + 5;
					descriptionBox.x = 10;
					descriptionBox.w = w;
					h = descriptionBox.y + descriptionBox.h;
				}
			}
			if(titleButtonMode == 0)
			{
				descriptionBox.y = titleBox.h + 5;
				descriptionBox.x = 10;
				descriptionBox.w = w;
				h = descriptionBox.y + descriptionBox.h;
			}
		}
		if(actionBoxes != null)
		{
			for(int i = 0; i < actionBoxes.size(); i++)
			{
				CheckBox cb = actionBoxes.get(i);
				cb.x = 15;
				cb.y = h;
				h += cb.h + 10;
			}
		}
		if(separatorStyle != 0)
		{
			h += 16;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
		fill(popUpSectionColor);
		rect(0,0,w,h);

		if(separatorStyle != 0)
		{
			strokeWeight(4);
			stroke(0);
			line(0, h - 2, w, h - 2);
			strokeWeight(1);
		}
	}
}

