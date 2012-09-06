///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpViewBase extends View 
{
	float arrowX, arrowY;
	Button commit, notApplicable;
	SecondLevelRowView parent;
	ClosePopUpView close;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpViewBase(float w_, SecondLevelRowView parent)
	{
		super(0, 0,w_ ,0);
		close = new ClosePopUpView(0,-20,w,20);
		this.subviews.add(close);
		
		//commit = new Button(20,0,150,20,"Save Changes",0,255);
		//notApplicable = new Button(200,0,180,20,"Mark as Read",0,255);
		commit = new Button(20,0,150,20,"Save to POC",200,0);
		notApplicable = new Button(200,0,180,20,"Close without saving",200,0);
		
		this.subviews.add(commit);
		this.subviews.add(notApplicable);	
		this.parent = parent;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		h = 0;
		for(int i = 0; i < subviews.size();i++)
		{
			View v = (View)popUpView.subviews.get(i);
			v.y = h;
			h += v.h;
			if(v != commit && v != notApplicable && v != close)
			{
				v.w = this.w;
			}
		}
		
		// v2.1: popup never goes off-screen vertically.
		if(y + h > SCREEN_HEIGHT)
		{
			y = SCREEN_HEIGHT - h;
		}
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		int ys = 0;
		for(int i = 0 ;i<subviews.size();i++)
		{
			View v = (View)subviews.get(i);

			if(!v.equals(commit) && !v.equals(notApplicable))
			{
				v.y = ys;
				ys +=v.h;
			}
		}
		
		commit.y = ys;
		notApplicable.y = ys;  

		int border = 5;
		fill(0, 0, 0, 180);
		noStroke();
		rect(-border, -border, w + border, h + border);
		triangle(-border, 10, arrowX - x, arrowY - y, -border, ys - 10);
		fill(255);
		rect(0, 0, w, h);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onAbortClicked() 
	{
		parent.stopBlinking();		
		hide();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void hide() 
	{
		mainView.subviews.remove(this);
		popUpView = null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked() 
	{
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(notApplicable.selected)
		{
			onAbortClicked();
			notApplicable.selected = false;
		}
		if(commit.selected)
		{
			onOkClicked();
			commit.selected = false;
		}
		return true;
	}
}
