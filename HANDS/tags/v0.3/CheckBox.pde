///////////////////////////////////////////////////////////////////////////////////////////////////
class CheckBox extends View 
{
	boolean iconUsed, selected, icon2Used;
	String t;
	PImage icon1, icon2;
	String type = "";
	TextBox tb;
	Button infoButton;

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
		infoButton = new Button(0, 0, 16, 16, infoIcon);
		infoButton.tooltipText = text;
		subviews.add(infoButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		if(infoButton != null)
		{
			infoButton.x = w - 20;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		textAlign(LEFT,CENTER);
		strokeWeight(3);
		stroke(0);
		if(selected)
		{
			fill(0);
		}
		else
		{
			fill(popUpSectionColor);
		}

		rect(5,1.65,23,16);
		if(iconUsed) image(icon1,30,2);
		if(icon2Used) image(icon2,48,2);

		fill(0);

		textSize(16);
		if(!type.equals(""))
		{
			text(type+" "+t, 70, 8);
		}
		else
		{
			text(t, 70, 8);
		}
		textSize(12);
	}
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		selected =!selected;
		tb.activated = false;
		System.out.println("Selected = "+ selected);
		if(selected)
		{
			this.subviews.add(tb);
			this.h = 60; 
		} 
		else	
		{
			this.subviews.remove(tb);
			this.h = 20; 
		}
		return true;
	}

}


