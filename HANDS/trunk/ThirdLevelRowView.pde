class ThirdLevelRowView extends View 
{
	String title;
	PImage logo;
	ArrayList<String> comments;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView(float x_, float y_,String title,PImage logo)
	{
		super(x_, y_,width,25);
		this.title = title;
		this.logo = logo;
		comments = new ArrayList<String>();

	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		h = 25+(25*comments.size());
if(comments.size()>1)
System.out.println("Title = "+ title+ " Comment = " +comments.get(0)+".");

		//if(comments.size()>1)
		//System.out.println(comments.size() + "so h = "+h);
		stroke(0);
		// textLeading(fbold);
		fill(thirdLevelRowColor);
		rect(-1,0,w+10,h);
		fill(0);
		textSize(12);
		image(logo,60,4);
		//ellipse(37,12,12,12);
		textAlign(LEFT,CENTER);
		text(title,95,12);
		for(int i = 0; i< comments.size();i++)
		{
		textFont(font);
		textSize(11);
		text(comments.get(i),115,12+(25*(i+1)));
		textFont(fbold);
		}
	}
}
