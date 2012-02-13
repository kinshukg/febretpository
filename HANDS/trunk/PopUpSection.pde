class PopUpSection extends View 
{
	String title;
	
	StaticText titleBox;
	StaticText descriptionBox;
	
	int separatorStyle;

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
	void layout()
	{
		titleBox.w = w;
		if(descriptionBox != null)
		{
			descriptionBox.y = titleBox.h + 5;
			descriptionBox.x = 10;
			descriptionBox.w = w;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		if(descriptionBox != null)
		{
			h = 60 + (subviews.size() * 20) + descriptionBox.h;
		}
		
		noStroke();
		fill(popUpSectionColor);
		rect(0,0,w,h);

		// fill(0);
		// textAlign(LEFT, CENTER);
		// textFont(fbold);
		// textSize(16);
		// text(title, 10,10);
		// textSize(12);
		
		if(separatorStyle != 0)
		{
			strokeWeight(4);
			stroke(0);
			line(0, h, w, h);
			strokeWeight(1);
		}
	}
}

