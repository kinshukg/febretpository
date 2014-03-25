class PopUpSection extends View 
{
	String title;
	
	StaticText titleBox;
	StaticText descriptionBox;
	
	Button titleButton;
	int titleButtonMode;
	
	int separatorStyle;
	ArrayList<CheckBox> actionBoxes;
	
	PImage img;
	boolean centerImage = true;
    
    TrendView trendView;
	
	boolean layoutHorizontal;

	///////////////////////////////////////////////////////////////////////////
	PopUpSection(String title)
	{
		super(0, 0, 400, 0);
		// if(actions != null) 
		// {
			// h = 60 + (actions.size() * 20);
		// }
		// else
		// {
			// h = 60;
		// }
		
		layoutHorizontal = false;
		
		this.title = title;
		this.titleBox = new StaticText("<b> <h1> " + title);
		subviews.add(titleBox);
		
		//actionBoxes = actions;
		
		// if(actions != null)
		// {
			// int ys = 35;
			// for(int i = 0; i < actions.size(); i++)
			// {
				// CheckBox c = actions.get(i);
				// c.y = ys;
				// this.subviews.add(c);
				// ys += 25;
			// }
		// }		
	}
	
	///////////////////////////////////////////////////////////////////////////
	void addAction(CheckBox action)
	{
		if(actionBoxes == null) actionBoxes = new ArrayList<CheckBox>();
		actionBoxes.add(action);
		subviews.add(action);
		action.ownerSection = this;
	}
	
	///////////////////////////////////////////////////////////////////////////
	CheckBox addAction(String t, String tag, PImage icon1, int id, PImage tooltipImage)
	{
        CheckBox action = new CheckBox(t, tag, icon1, id, tooltipImage);
		if(actionBoxes == null) actionBoxes = new ArrayList<CheckBox>();
		actionBoxes.add(action);
		subviews.add(action);
		action.ownerSection = this;
        return action;
	}
    
	///////////////////////////////////////////////////////////////////////////
	void removeAction(CheckBox action)
	{
		actionBoxes.remove(action);
		subviews.remove(action);
	}
	
	///////////////////////////////////////////////////////////////////////////
	void setDescription(String text)
	{
		descriptionBox = new StaticText(text);
		subviews.add(descriptionBox);
	}
	
	///////////////////////////////////////////////////////////////////////////
	void setInfoButton(String text)
	{
		titleButton = new Button(0, 0, 16, 16, IMG_TUTORIAL);
		titleButton.tooltipText = text;
		subviews.add(titleButton);
		//titleButtonMode = 1;
	}
	
	///////////////////////////////////////////////////////////////////////////
	void onRadioButtonChanged(CheckBox cb)
	{
		// Can't unselect a selected radio button. Must click on different one. Fix selection
		if(!cb.selected) cb.selected = true;
		else
		{
			for(int j = 0; j < actionBoxes.size(); j++)
			{
				CheckBox c = actionBoxes.get(j);
				if(c != cb) c.selected = false;
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////
	void setImage(PImage img)
	{
		this.img = img;
	}
	
	///////////////////////////////////////////////////////////////////////////
	void addTrendView(TrendView view)
	{
		trendView = view;
        subviews.add(view);
	}
	
	///////////////////////////////////////////////////////////////////////////
	void enableExpandableDescription()
	{
		titleButton = new Button(0, 0, 16, 16, infoIcon);
		subviews.add(titleButton);
		titleButtonMode = 2;
	}
	
	///////////////////////////////////////////////////////////////////////////
	void layout()
	{
		titleBox.x = 10;
		titleBox.y = 0;
		titleBox.w = w;
		h = titleBox.h + 10;
		if(descriptionBox != null)
		{
			if(titleButtonMode == 2)
			{
				descriptionBox.visible = titleButton.selected;
				if(titleButton.selected)
				{
					descriptionBox.y = titleBox.h + 10;
					descriptionBox.x = 10;
					descriptionBox.w = w - 10;
					h = descriptionBox.y + descriptionBox.h;
				}
			}
			if(titleButtonMode == 0)
			{
				descriptionBox.y = titleBox.h + 10;
				descriptionBox.x = 10;
				descriptionBox.w = w - 10;
				h = descriptionBox.y + descriptionBox.h;
			}
		}
		// v2.1: place the info icon under the description (will fall next to the graph)
		if(titleButton != null)
		{
			titleButton.w = 16;
			titleButton.h = 16;
			titleButton.y = -4;
			titleButton.x = 120;
			//titleButton.x = 0;
			// titleButton.w = 16;
			// titleButton.h = 16;
			// titleButton.y = -4;
			// titleButton.x = 5;
			
			// If we have a title button, move the title box a bit to the left.
			//titleBox.x += 20;
			//titleBox.w -= 20;
		}
		if(img != null)
		{
			if(titleButtonMode == 2)
			{
				if(titleButton.selected)
				{
					h += img.height + 10;
				}
			}
			if(titleButtonMode == 0)
			{
				h += img.height + 10;
			}
			if(titleButton != null)
			{
				titleButton.y = 14;
				titleButton.x = 490;
			}
		}
        if(trendView != null)
        {
            trendView.x = (w - trendView.w) / 2;
            h += trendView.h + 10;
        }
		if(actionBoxes != null)
		{
			if(layoutHorizontal)
			{
				int curw = 15;
				int checkBoxWidth = (int)w / actionBoxes.size();
				if(checkBoxWidth > 60) checkBoxWidth = 60;
				float maxCheckboxHeight = 0;
				for(int i = 0; i < actionBoxes.size(); i++)
				{
					CheckBox cb = actionBoxes.get(i);
					cb.x = curw;
					cb.y = h;
					if(cb.h > maxCheckboxHeight) maxCheckboxHeight = cb.h;
					curw += checkBoxWidth;
				}
				if(w < curw) w = curw;
				h += maxCheckboxHeight + 10;
			}
			else
			{
				for(int i = 0; i < actionBoxes.size(); i++)
				{
					CheckBox cb = actionBoxes.get(i);
					cb.x = 15;
					cb.y = h;
					h += cb.h + 10;
				}
			}
		}
		if(separatorStyle != 0)
		{
			h += 16;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
		//fill(popUpSectionColor);
		//rect(0,0,w,h);
		
		if(img != null)
		{
			int imageY = (int)titleBox.h + 5;
			if(descriptionBox != null)
			{
				imageY = (int)descriptionBox.y + (int)descriptionBox.h + 10;
			}
			int imageX = (int)w / 2 - img.width / 2;
			if(!centerImage) imageX = 5;
			if(titleButtonMode == 2)
			{
				if(titleButton.selected)
				{
					image(img, imageX, imageY);
				}
			}
			else
			{
				image(img, imageX, imageY);
			}
		}

		if(separatorStyle != 0)
		{
			strokeWeight(3);
			stroke(0);
			line(0, h - 2, w, h - 2);
			strokeWeight(1);
		}
	}
}

