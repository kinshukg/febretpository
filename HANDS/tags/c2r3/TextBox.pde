class TextBox extends View
{
	////////////////////////////////////////////////////////////////////////////////////////////////////
	public String text;
	public boolean  activated = false;
	// public Timer ticktock; // Timer used for blinking cursor
	public boolean timer = true;
	public int lastsec = 0;
	public int cursorPos = 0;
	public String suggestion = "Optional comment";
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	public TextBox(float x_, float y_)
	{
		super(x_, y_, 320, 20);
		text = "";
		interactive = true;
		// tickTock = new Timer();
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		fill(255);
		if (activated) stroke(0);
		else stroke(#A3A3A3);
		strokeWeight(1.5);
		rect(0, 0, w, h);

		fill(0);
		textFont(font, 12);
		textAlign(LEFT, CENTER);

		if (text.equals("") && !activated)
		{
		  fill(#A3A3A3);
		  text(suggestion, 15, 7);
		}
		else 
		{
			if (timer && activated)
			{
				String pre = text.substring(0,cursorPos);
				pre+="|";
				pre += text.substring(cursorPos);
				text(pre, 15, 7);
			}
			else
			{
				text(text, 15, 7);
			}
		}
		textFont(fbold);
		//textAlign(CENTER,CENTER);
		//System.out.println(second());

		if (second()%1 <= 0.5 && second()!=lastsec) 
		{
			timer = !timer;
			//System.out.println("Toggling "+ timer);
			lastsec = second();
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	public void activate()
	{
		if(activeTextBox != null) activeTextBox.deactivate();
		activated = true;
		filterKeyInput = true;
		activeTextBox = this;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	public void deactivate()
	{
		activated = false;
		filterKeyInput = false;
		activeTextBox = null;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	public boolean keypressed() 
	{
		if (activated) 
		{
			if (key == 8)
			{
				if(cursorPos > 0)
				{
					String pre = text.substring(0,cursorPos);
					if (pre.length() > 0) pre = pre.substring(0, pre.length() - 1);
					pre += text.substring(cursorPos);
					text = pre;
					cursorPos--;
				}
			}
			else
			{
				if (key == CODED) 
				{
					if (keyCode == RIGHT) 
					{
						if(cursorPos < text.length()) cursorPos++;
					}
					if(keyCode == LEFT)
					{
						if(cursorPos > 0) cursorPos--;
					}
				}
				else 
				{
					if (key != 65535) 
					{
						if (cursorPos == text.length()) 
						{
							text += key;
							cursorPos++;
						}
						else
						{
							String s2 = "";
							s2 += text.substring(0, cursorPos);
							s2+=key;
							s2+= text.substring(cursorPos);
							text = s2;
						}
					}
				}
			}
		}
		return activated;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Private stuff.
	PImage icon;
	String label;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		activate();
		System.out.println("Activated = "+ activated);
		return true;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// boolean mouseClicked(float px, float py)
	// {
		// //System.out.println(" Px = "+px +" Py = "+py+" x = "+x+" y = "+y+" w = "+w+" h = "+h);
		// if (!ptInRect(px, py, x, y, w, h))
		// { 
			// //System.out.println("FALSEYYYYYYYYYYYYYY");
			// return false;
		// }
		// float lx = px - x;
		// float ly = py - y;
		// // check our subviews first
		// for (int i = subviews.size()-1; i >= 0; i--) 
		// {
			// View v = (View)subviews.get(i);
			// if (v.mouseClicked(lx, ly)) return true;
		// }
		// return contentClicked(lx, ly);
	// }
}

