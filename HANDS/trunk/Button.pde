///////////////////////////////////////////////////////////////////////////////////////////////////
class Button extends View 
{
	boolean selected = false, flashing = false;
	String t;
	color buttonColor, textColor;
	PImage icon;
	int style = 1;
	boolean blinking;
	
	// Tooltip mode: 0 = disabled, 1 = open on click, 2 = open on hover.
	String tooltipText;
	PImage tooltipImage;
	
	boolean transparent;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, PImage icon_)
	{
		super(x_, y_,w_ ,h_); 
		icon = icon_;
		transparent = true;
		interactive = true;
		tooltipImage = null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, String t, color buttonColor, color textColor)
	{
		super(x_, y_,w_ ,h_); 
		this.t = t;
		this.buttonColor = buttonColor;
		this.textColor = textColor;
		icon = null;
		interactive = true;
		transparent = false;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		if(w == 0)
		{
			textFont(font);
			textSize(14);
			w = textWidth(t) + 15;
			if(icon != null)
			{
				w += icon.width;
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();

		color baseColor = buttonColor;	
		if(blinking) 
		{
			baseColor = lerpColor(buttonColor, color(200), (1 + sin(radians(frameCount) * 8)) / 2);
		}

		if(!transparent)
		{
			if(style == 0)
			{
				fill(0);
				roundrect(-1, -1, (int)w + 2, (int)h + 2, 5);

				fill(buttonColor);
				roundrect(0,0,(int)w,(int)h,5);
			}
			if(style == 1)
			{
				strokeWeight(1);
				
				gu.drawVGradient(0, 0, w + 1, h + 1, baseColor, 180, baseColor, 255, 0.6);

				gu.drawBox(0, 0, (int)w, (int)h, 1, 0, 255);
				gu.drawBox(0, 0, (int)w, (int)h, 2, 0, 60);
			}
			if(style == 2)
			{
				textFont(fbold);
				strokeWeight(1);
				stroke(buttonColor);
				line(0, h - 1, w, h - 1);
			}
		}
		
		if(icon != null)
		{
			image(icon, 1, 1);
		}
		
		if(t != null)
		{
			fill(textColor);
			textFont(font);
			textSize(14);
			if(style == 2)
			{
				textFont(fbold);
				fill(buttonColor);
			}
			textAlign(CENTER,CENTER);
			int textW = (int)w;
			if(icon != null) 
			{
				textW -= icon.width;
				text(t, icon.width + textW / 2, h / 2 - 2);
			}
			else
			{
				text(t, textW / 2, h / 2 - 2);
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
	
		if(!OPTION_TOOLTIP_AUTO_OPEN && (tooltipText != null && tooltipText.length() != 0) || tooltipImage != null)
		{
			showTooltip();
		}
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		selected =!selected;
		//System.out.println("Clicked");

		return false;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void showTooltip()
	{
		if(tooltipImage != null)
		{
			tooltipView = new Tooltip(mouseX + 10, mouseY + 10, 300, 60, tooltipImage);
		}
		else
		{
			tooltipView = new Tooltip(mouseX + 10, mouseY + 10, 300, 60, tooltipText);
		}
		
		tooltipView.arrowX = mouseX;
		tooltipView.arrowY = mouseY;
		// If mouse X is closer to border of screen, resize popup accordingly.
		if(mouseX > SCREEN_WIDTH - 300)
		{
			tooltipView.y = mouseY + 20;
			tooltipView.x = mouseX - 100;
			tooltipView.w = 300;
		}
	}
}
