///////////////////////////////////////////////////////////////////////////////////////////////////
class CheckBox extends View 
{
	boolean iconUsed, selected, icon2Used;
	String t;
	PImage icon1, icon2;
	String type = "";
	TextBox tb;
	Button infoButton;
	float tw;

	int checkX = 4;
	int checkY = 4;
	int checkW = 12;
	int checkH = 12;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	CheckBox(float x_, float y_,boolean iconUsed,boolean icon2Used,boolean selected, String t, PImage icon1, PImage icon2)
	{
		super(x_, y_,250,20); 
		this.selected = selected;
		this.t = t;
		this.iconUsed = iconUsed;
		this.icon2Used = icon2Used;
		if(iconUsed) this.icon1 = icon1;
		if(icon2Used) this.icon2 = icon2;
		tb = new TextBox(20,30);
	}
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	CheckBox(float x_, float y_,boolean iconUsed,boolean icon2Used,boolean selected, String t, PImage icon1, PImage icon2, String type)
	{
		super(x_, y_,250,20); 
		this.selected = selected;
		this.t = t;
		this.iconUsed = iconUsed;
		this.icon2Used = icon2Used;
		if(iconUsed) this.icon1 = icon1;
		  
		if(icon2Used) this.icon2 = icon2;
		this.type = type;

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
	void layout()
	{
		if(infoButton != null)
		{
			infoButton.x = w - 210;
		}
		w = popUpView.w;
		tb.x = tw + 50;
		tb.w = popUpView.w - tw - 70;
		tb.y = 0;
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
		
		if(iconUsed) image(icon1,20,2);
		if(icon2Used) image(icon2,40,2);

		fill(0);

		textSize(14);
		textFont(font);
		if(!type.equals(""))
		{
			text(type+" "+t, 40, 8);
			tw = textWidth(type+" "+t);
		}
		else
		{
			text(t, 40, 8);
			tw = textWidth(t);
		}
		textSize(12);
	}
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		int margin = 4;
		if(lx > checkX - margin && lx < checkX + checkW + margin &&
			ly > checkY - margin && ly < checkY + checkH + margin)
		{
			selected =!selected;
			tb.activated = false;
			System.out.println("Selected = "+ selected);
			if(selected)
			{
				this.subviews.add(tb);
				//this.h = 60; 
			} 
			else	
			{
				this.subviews.remove(tb);
				//this.h = 20; 
			}
		}
		return true;
	}

}


