class TrendTable extends TrendView 
{
	///////////////////////////////////////////////////////////////////////////
	TrendTable(float x_, float y_)
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
        
		fill(0);
		textFont(fbold);
		textSize(22);
		text(title,80,10);
        
        int ph = 60;
        int pw = 70;
        int lineHeight = 20;
        
        strokeWeight(2);
        stroke(0);
        
        // Past trend
        int curX = -30;
        int curY = 100;
        int endX = curX + pw * 9;
        
		textSize(12);

        line(curX, curY - lineHeight, endX, curY - lineHeight);
        line(curX, curY - lineHeight, curX, curY + ph * 3 - lineHeight);
        line(curX + pw * 9, curY - lineHeight, endX, curY + ph * 3 - lineHeight);
        
        text("NOC Rating", curX + 5, curY - 10);
        text("(Expected: " + str(noc.secondColumn) + ")", curX + 5, curY + lineHeight - 10);
        
        line(curX, curY + ph - lineHeight, endX, curY + ph - lineHeight);
        line(curX, curY + ph * 2 - lineHeight, endX, curY + ph * 2 - lineHeight);
        line(curX, curY + ph * 3 - lineHeight, endX, curY + ph * 3 - lineHeight);
        
        text("Hours Since", curX + 5, curY + ph * 2 - 10);
        text("Admission", curX + 5, curY + ph * 2 + lineHeight - 10);
        
        curX += 100;
        
        for(int i = 0; i < now; i++)
        {
            stroke(0);
            curX +=  pw;
            
            if(pastTrend[i] != 0)
            {
                text(str(pastTrend[i]), curX - 10, curY);
            }
            
            // Shift entries
            // if(i == 0)
            // {
                // text("Admission", curX, curY + ph * 2);
            // }
            if(i == now - 1)
            {
                text("NOW", curX - 20, curY + ph * 2);
            }
            else
            {
                text(str(i * 12) + "hrs", curX - 20, curY + ph * 2);
            }
            line(curX - pw / 2, curY - lineHeight, curX  - pw / 2, curY + ph - lineHeight);
            line(curX - pw / 2, curY + ph * 2 - lineHeight, curX  - pw / 2, curY + ph * 3- lineHeight);
        }
        
        // Good projection line
        for(int i = now; i < 7; i++)
        {
            curX += pw;
            text(str(projectionGood[i]), curX - 10, curY + 10);
            text(str(projectionBad[i]), curX - 10, curY + ph + 10);
            
            if(i == now)
            {
                text("With improved treatment", curX, curY - lineHeight);
                text("If current care continues", curX, curY + ph - lineHeight);
            }
            
            // Shift entries.
            text(str(i * 12) + "hrs", curX - 20, curY + ph * 2);
            
            if(i == now)
            {
                line(curX - pw / 2, curY - lineHeight, curX  - pw / 2, curY + ph * 3 - lineHeight);
            }
            else
            {
                line(curX - pw / 2, curY, curX  - pw / 2, curY + ph - lineHeight);
                line(curX - pw / 2, curY + ph, curX  - pw / 2, curY + ph * 3 - lineHeight);
            }
            
            line(curX - pw / 2, curY, endX, curY);
            line(curX - pw / 2, curY + ph, endX, curY + ph);
        }
	}
}
