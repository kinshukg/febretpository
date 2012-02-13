///////////////////////////////////////////////////////////////////////////////////////////////////
class StaticText extends View 
{
	String text;
	String textLines;
	float arrowX, arrowY;
	int numLines;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	StaticText(float x_, float y_, float w_, String text)
	{
		super(x_, y_,w_ ,0);
		this.text = text;
		
		numLines = 0;
		textSize(12);
		textLines = _wrapText(text, (int)w_);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		stroke(0);
		fill(0);
		System.out.println(textLines);
		textSize(12);
		textAlign(LEFT, TOP);
		text(textLines, 0, 0);
		h = numLines * (textAscent() + textDescent());
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	String _wrapText(String string, int lineWidth)
	{
		String[] words = string.split(" ");
		String output = "";
		String line = "";
		for(int i = 0; i < words.length; i++)
		{
			line += words[i] + " ";
			if(textWidth(line) >= lineWidth)
			{
				output += line + "\n";
				line = "";
				numLines++;
			}
		}
		output += line;
		return output;
	}
}
