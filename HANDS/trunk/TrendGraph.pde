///////////////////////////////////////////////////////////////////////////////
class TrendGraph extends TrendView 
{
	///////////////////////////////////////////////////////////////////////////
	TrendGraph(float x_, float y_)
	{
        super(x_,y_,546,280);
	}
	
	///////////////////////////////////////////////////////////////////////////
	void layout()
	{
	}
	
	///////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		noStroke();
        imageMode(CORNER);
        
        int iy = 50;
        
		fill(0);
		textFont(fbold);
		textSize(22);
		text(title,80,20);
        
        image(IMG_PLOT_BASE, 0, iy);
        
        int ph = 38;
        int pw = 62;
        
        int tx = 90;
        int ty = 162 + iy;
        
        strokeWeight(6);
        
        imageMode(CENTER);
        // Past trend
        int curY = ty - (pastTrend[0] - 1)  * ph;
        int curX = tx;
        
        if(pastTrend[0] > 0)
        {
            image(IMG_BLACK_DOT, curX, curY);
        }
        
        for(int i = 1; i < now; i++)
        {
            stroke(0);
            int lastY = curY;
            int lastX = curX;
            curY = ty - (pastTrend[i] - 1) * ph;
            curX = lastX + pw;
            
            if(pastTrend[i - 1] > 0)
            {
                line(lastX, lastY, curX, curY); 
            }
            image(IMG_BLACK_DOT, curX, curY);
        }
        
        // Good projection line
        int projX = curX;
        curY = ty - (pastTrend[now - 1] - 1)  * ph;
        for(int i = now; i < 7; i++)
        {
            stroke(0,116,52);
            int lastY = curY;
            int lastX = curX;
            curY = ty - (projectionGood[i] - 1) * ph;
            curX = lastX + pw;
            line(lastX, lastY, curX, curY); 
            image(IMG_GREEN_DOT, curX, curY);
        }
		fill(0,116,52);
		textSize(14);
		text("If treated\naggressively", curX + 10, curY - 20);

        // Bad projection line
        curY = ty - (pastTrend[now - 1] - 1)  * ph;
        curX = projX;
        for(int i = now; i < 7; i++)
        {
            stroke(192,0,0);
            int lastY = curY;
            int lastX = curX;
            curY = ty - (projectionBad[i] - 1) * ph;
            curX = lastX + pw;
            line(lastX, lastY, curX, curY); 
            image(IMG_RED_DOT, curX, curY);
            // Redraw current point to overlay red/green line
            if(i == now)
            {
                image(IMG_BLACK_DOT, lastX, lastY);
            }
        }
		fill(192,0,0);
		textSize(14);
		text("If no plan\nchanges", curX + 10, curY - 20);
        
        // NOW marker
        imageMode(CORNER);
        image(IMG_NOW_MARKER, projX - 28, iy + 6);
		fill(0);
		textSize(12);
		text("Actual   Projected", projX - 46, iy + 16);
	}
}
