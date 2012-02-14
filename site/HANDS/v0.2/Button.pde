///////////////////////////////////////////////////////////////////////////////////////////////////
class Button extends View 
{
	boolean selected = false, flashing = false;
	String t;
	color buttonColor, textColor;
	PImage icon;
	
	// Tooltip mode: 0 = disabled, 1 = open on click, 2 = open on hover.
	String tooltipText;
	
	boolean transparent;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, PImage icon_)
	{
		super(x_, y_,w_ ,h_); 
		icon = icon_;
		transparent = true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, String t, color buttonColor, color textColor)
	{
		super(x_, y_,w_ ,h_); 
		this.t = t;
		this.buttonColor = buttonColor;
		this.textColor = textColor;
		icon = null;
		transparent = false;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		if(w == 0)
		{
			w = textWidth(t) + 10;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
		//   if(flashing)

		if(!transparent)
		{
			fill(0);
			roundrect(-1, -1, (int)w + 2, (int)h + 2, 5);

			fill(buttonColor);
			roundrect(0,0,(int)w,(int)h,5);
		}
		
		if(icon != null)
		{
			image(icon, -1, 0);
		}
		
		if(t != null)
		{
			fill(textColor);
			textAlign(CENTER,CENTER);
			text(t, w / 2, h / 2 - 2);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		if(!OPTION_TOOLTIP_AUTO_OPEN && tooltipText != null && tooltipText.length() != 0)
		{
			showTooltip();
		}
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		selected =!selected;
		System.out.println("Clicked");

		return false;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void showTooltip()
	{
		tooltipView = new Tooltip(mouseX + 10, mouseY + 10, 300, 60, tooltipText);
		tooltipView.arrowX = mouseX;
		tooltipView.arrowY = mouseY;
		// If mouse X is closer to border of screen, resize popup accordingly.
		if(mouseX > SCREEN_WIDTH - 400)
		{
			tooltipView.y = mouseY + 20;
			tooltipView.x = mouseX - 100;
			tooltipView.w = 200;
		}
	}
}
