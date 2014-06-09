class ScrollingView extends View 
{
	ArrayList subs;
	
	////////////////////////////////////////////////////////////////////////////
	ScrollingView(float x_, float y_, float w_, float h_)
	{
		super(x_, y_, w_, h_);
		subs = new ArrayList();
	}

	////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		fill(0);
		text("Current \nRating", 840, - 30);
		text("Expected \nRating", 940, - 30);
        
		strokeWeight(3);
		stroke(0);
		fill(255);
		rect(-5,0,w+15,h);
		strokeWeight(1);
		this.subviews =  new ArrayList();
		int usedSpace = 0;
		for (int i = 0; i < this.subs.size() && usedSpace < h;i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) subs.get(i);
			tempRow.y = usedSpace;
			tempRow.w = this.w;
			usedSpace += tempRow.h;
			this.subviews.add(tempRow);
			for (int j = 0; j < tempRow.subs.size() && usedSpace < h; j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
				tempRow2.y = usedSpace;
				tempRow2.w = this.w;
				usedSpace += tempRow2.h;
				this.subviews.add(tempRow2);
				for (int k = 0; k < tempRow2.subs.size() && usedSpace < h; k++ ) 
				{
					ThirdLevelRowView tempRow3 = (ThirdLevelRowView) tempRow2.subs.get(k);
					tempRow3.y = usedSpace;
					tempRow3.w = this.w;
					usedSpace += tempRow3.h;
					if(usedSpace <= h) this.subviews.add(tempRow3);
				}
			}
		}
	}
}

