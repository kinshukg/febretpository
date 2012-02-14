///////////////////////////////////////////////////////////////////////////////////////////////////
class GraphPopUpView extends View 
{
	float arrowX, arrowY;
	SecondLevelRowView parent;
	ClosePopUpView close;

	///////////////////////////////////////////////////////////////////////////////////////////////
	GraphPopUpView(float w_, SecondLevelRowView parent)
	{
		super(0, 0,w_ ,0);
		close = new ClosePopUpView(0,0,w,20);
		this.subviews.add(close);
		this.parent = parent;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset(PImage img)
	{
		PopUpSection title = new PopUpSection(0, 0, null, "");
		title.setImage(img);
		subviews.add(title);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		h = 0;
		for(int i = 0; i < subviews.size();i++)
		{
			View w = (View)popUpView.subviews.get(i);
			w.y = h;
			h += w.h;
		}
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		
		int contours = 12;
		for(int i = 0; i < contours; i++)
		{
			int alpha = 50 - (50 / contours) * (i * i);
			fill(0, 0, 0, alpha);
			stroke(0, 0, 0, alpha);
			strokeWeight(1);
			roundrect(-i, -i, (int)w + i * 2, (int)h + i * 2, 5);
			//triangle(0, (contours - i) * 2, arrowX - x, arrowY - y, 0, h - (contours - i) * 2);
		}
		
		noStroke();
		fill(255);
		rect(0,0,w,h);
		fill(255);
		stroke(0);
		triangle(0, 0, arrowX - x, arrowY - y, 0, h);
	}
}
