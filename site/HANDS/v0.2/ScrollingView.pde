///////////////////////////////////////////////////////////////////////////////////////////////////
class ScrollingView extends View 
{
	ArrayList subs;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ScrollingView(float x_, float y_, float w_, float h_)
	{
		super(x_, y_, w_, h_);
		subs = new ArrayList();
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		fill(0);
		text("Current \nRating", 640, - 30);
		text("Expected \nRating", 740, - 30);
	
		strokeWeight(4);
		stroke(0);
		fill(255);
		rect(-5,0,w+10,h);
		strokeWeight(1);
		this.subviews =  new ArrayList();
		int usedSpace = 0;
		for (int i = 0; i < this.subs.size() && usedSpace < h;i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) subs.get(i);
			tempRow.y = usedSpace;
			usedSpace += tempRow.h;
			this.subviews.add(tempRow);
			for (int j = 0; j < tempRow.subs.size() && usedSpace < h; j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
				tempRow2.y = usedSpace;
				usedSpace += tempRow2.h;
				this.subviews.add(tempRow2);
				for (int k = 0; k < tempRow2.subs.size() && usedSpace < h; k++ ) 
				{
					ThirdLevelRowView tempRow3 = (ThirdLevelRowView) tempRow2.subs.get(k);
					tempRow3.y = usedSpace;
					usedSpace += tempRow3.h;
					if(usedSpace <= h) this.subviews.add(tempRow3);
				}
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void rearrange()
	{
		this.subviews =  new ArrayList();
		int usedSpace = 0;
		for (int i = 0; i < this.subs.size() && usedSpace < h;i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) subs.get(i);
			tempRow.y = usedSpace;
			usedSpace += tempRow.h;
			this.subviews.add(tempRow);

			for (int j = 0; j < tempRow.subs.size() && usedSpace < h; j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
				tempRow2.y = usedSpace;
				usedSpace += tempRow2.h;
				this.subviews.add(tempRow2);
				for (int k = 0; k < tempRow2.subs.size() && usedSpace < h; k++ ) 
				{
					ThirdLevelRowView tempRow3 = (ThirdLevelRowView) tempRow2.subs.get(k);
					tempRow3.y = usedSpace;
					usedSpace += tempRow3.h;
					if(usedSpace <= h)
					this.subviews.add(tempRow3);
				}
			}
		}
	}
}

