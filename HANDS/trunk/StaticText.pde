///////////////////////////////////////////////////////////////////////////////////////////////////
class StaticText extends View 
{
	String text;
	String textLines;
	float arrowX, arrowY;
	int numLines;
	int textFormat;
	color textColor;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	StaticText(String text, int format)
	{
		super(0, 0, 0 ,0);
		this.text = text;
		this.textFormat = format;
		numLines = 0;
		
		textColor = color(0, 0, 0);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		// Set text style.
		if(textFormat == FORMAT_HEADING1)
		{
			textFont(fbold);
			textSize(14);
		}
		else if(textFormat == FORMAT_NORMAL)
		{
			textFont(font);
			textSize(12);
		}
		
		// Compute bounds
		if(textLines == null)
		{
			textLines = _wrapText(text, (int)w);
		}
		h = numLines * (textAscent() + textDescent());
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		// stroke(0);
		// fill(0);
		// //System.out.println(textLines);
		// textSize(12);
		// textLeading(1);
		// textFont(font);
		stroke(textColor);
		fill(textColor);
		textAlign(LEFT, TOP);
		text(textLines, 0, 0);
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
			if(textWidth(line) >= lineWidth || words[i].endsWith("\n"))
			{
				if(words[i].endsWith("\n"))
				{
					output += line;
				}
				else
				{
					output += line + "\n";
				}
				line = "";
				numLines++;
			}
		}
		output += line;
		numLines++;
		return output;
	}
}
