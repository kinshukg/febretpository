class ClosePopUpView extends View 
{
	boolean pressed = false;

	///////////////////////////////////////////////////////////////////////////////////////////////
	ClosePopUpView(float x_, float y_,float w_,float h_)
	{
		super(x_, y_,w_ ,h_); 
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
		textSize(12);
		textFont(fbold);
		fill(30);
		textAlign(LEFT, CENTER);
		rect(0,0,w,h);
		fill(255);
		text("Close Popup    X",w - 120,h/2-2);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(lx > w - 120)
		{
			if(popUpView != null)
			{
				popUpView.hide();
			}
			pressed = true;
		}
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentMoved(float lx, float ly)
	{
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentPressed(float lx, float ly)
	{
		if(popUpView != null)
		{
			println("moving");
			popUpView.moving = true;
			popUpView.dragX = popUpView.x - mouseX;
			popUpView.dragY = popUpView.y - mouseY;
		}
		pressed = true;
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentReleased(float lx, float ly)
	{
		pressed = false;
		return true;
	}
}
