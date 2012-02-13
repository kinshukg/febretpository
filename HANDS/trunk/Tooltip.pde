///////////////////////////////////////////////////////////////////////////////////////////////////
class Tooltip extends View 
{
	String text;
	float arrowX, arrowY;
	String[] rationaleString;
	
	StaticText label;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	Tooltip(float x_, float y_, float w_, float h_, String text)
	{
		super(x_, y_,w_ ,h_);
		
		label = new StaticText(text, FORMAT_NORMAL);
		subviews.add(label);
		
		this.text = text;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		label.w =  w - 10;
		label.x = 5;
		label.y = 5;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();

		fill(0);
		roundrect(-1, -1, (int)w + 2, (int)h + 2, 5);
		
		fill(tooltipColor);
		stroke(0);
		strokeWeight(1);
		triangle(0, 0, arrowX - x, arrowY - y, 0, h);
		
		fill(255, 255, 255);
		roundrect(0, 0, (int)w, (int)h, 5);
	}
}
