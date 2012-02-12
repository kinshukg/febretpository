///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpView extends View 
{
	ClosePopUpView c;
	float arrowX, arrowY;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpView(float x_, float y_, float w_)
	{
		super(x_, y_,w_ ,0);
		c = new ClosePopUpView(0,0,w,20); 
		this.subviews.add(c);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		int ys = 0;
		for(int i = 0 ;i<subviews.size();i++)
		{
		  View v = (View)subviews.get(i);
		  v.y = ys;
		  ys +=v.h;
		 // System.out.println(ys);
		}
		fill(popUpSectionColor);
		triangle(0, 0, arrowX - x, arrowY - y, 0, ys);
	}
}
