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
		
		label = new StaticText(5, 5, w_ - 10, text);
		subviews.add(label);
		
		this.text = text;
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
