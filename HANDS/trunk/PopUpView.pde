///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpView extends View 
{
	ClosePopUpView c;
	float arrowX, arrowY;
		Button commit, notApplicable;
 SecondLevelRowView parent;

	
	///////////////////////////////////////////////////////////////////////////////////////////////
		PopUpView(float x_, float y_, float w_, SecondLevelRowView parent)
{
		super(x_, y_,w_ ,0);
		c = new ClosePopUpView(0,0,w,20); 
		this.subviews.add(c);
		    commit = new Button(20,0,150,20,"             Save Changes",0,255);
                notApplicable = new Button(200,0,180,20,"       Not Applicable, because...",0,255);
                this.subviews.add(commit);
                this.subviews.add(notApplicable);	
    this.parent = parent;

	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
			int ys = 0;
		for(int i = 0 ;i<subviews.size();i++)
		{
		View v = (View)subviews.get(i);
		  
                 if(!v.equals(commit) && !v.equals(notApplicable)){
                  v.y = ys;
		  ys +=v.h;
                 }
		 // System.out.println(ys);
		}
                noStroke();
                fill(popUpSectionColor);
                rect(0,ys,w,ys+30);
                commit.y = ys;
                notApplicable.y = ys;                
		fill(popUpSectionColor);
		triangle(0, 0, arrowX - x, arrowY - y, 0, ys);
}
}
