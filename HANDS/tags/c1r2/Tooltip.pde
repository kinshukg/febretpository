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
		this.h = label.h + 15;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();

		int contours = 12;
		for(int i = 0; i < contours; i++)
		{
			int alpha = 50 - (16 / contours) * (i * i);
			fill(0, 0, 0, alpha);
			stroke(0, 0, 0, alpha);
			strokeWeight(1);
			roundrect(-i, -i, (int)w + i * 2, (int)h + i * 2, 5);
			//triangle(0, (contours - i) * 2, arrowX - x, arrowY - y, 0, h - (contours - i) * 2);
		}
		
		fill(tooltipColor);
		stroke(0);
		triangle(0, contours, arrowX - x, arrowY - y, 0, h - contours);
		
		fill(#FFFCE5);
		roundrect(0, 0, (int)w, (int)h, 5);
	}
}
