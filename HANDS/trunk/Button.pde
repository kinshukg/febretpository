///////////////////////////////////////////////////////////////////////////////////////////////////
class Button extends View 
{
	boolean selected = false, flashing = false;
	String t;
	color buttonColor, textColor;
	
	// Tooltip mode: 0 = disabled, 1 = open on click, 2 = open on hover.
	int tooltipMode = 0;
	String tooltipText;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, String t, color buttonColor, color textColor)
	{
		super(x_, y_,w_ ,h_); 
		//   this.selected = selected;
		this.t = t;
		this.buttonColor = buttonColor;
		this.textColor = textColor;
		//   this.flashing = flashing;
		//  fader = new Integrator(100);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
		//   if(flashing)

		fill(0);
		roundrect(-1, -1, (int)w + 2, (int)h + 2, 5);

		fill(buttonColor);
		roundrect(0,0,(int)w,(int)h,5);
		fill(textColor);
		 textAlign(LEFT,TOP);
		text(t,0,0);
		textAlign(LEFT,CENTER);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		if(tooltipMode == 1)
		{
			tooltipView = new Tooltip(mouseX + 10, mouseY + 10, 200, 60, tooltipText);
			tooltipView.arrowX = mouseX;
			tooltipView.arrowY = mouseY;
		}
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		selected =!selected;
		System.out.println("Clicked");

		return false;
	}
}
