///////////////////////////////////////////////////////////////////////////////
class TrendView extends View 
{
    SecondLevelRowView noc;
    String title;
    int now;
    int[] pastTrend = new int[8];
    int[] projectionGood = new int[8];
    int[] projectionBad = new int[8];
    
	///////////////////////////////////////////////////////////////////////////
	TrendView(float x, float y, float w, float h)
	{
        super(x,y,w,h);
	}
}