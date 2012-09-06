///////////////////////////////////////////////////////////////////////////////////////////////////
class StaticText extends View 
{
	String text;
	String textLines;
	float arrowX, arrowY;
	int numLines;
	color textColor;
	
	String[] textWords;
	
	int maxTextWidth;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	StaticText(String text)
	{
		super(0, 0, 0 ,0);
		this.text = text;
		numLines = 0;
		
		textColor = color(0, 0, 0);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setText(String txt)
	{
		textLines = null;
		text = txt;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void layout()
	{
		// // Set text style.
		// if(textFormat == FORMAT_HEADING1)
		// {
			// textFont(fbold);
			// textSize(14);
		// }
		// else if(textFormat == FORMAT_NORMAL)
		// {
			// textFont(font);
			// textSize(12);
		// }
		
		// // Compute bounds
		if(textLines == null)
		{
			textLines = _wrapText(text, (int)w);
		}
		// h = numLines * (textAscent() + textDescent());
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
		// text(textLines, 0, 0);
		
		int curX = 0;
		int curY = 0;
		int textHeight = (int)textAscent() + (int)textDescent();
		boolean bullets = false;
		boolean bold = false;
		
		int curLineWidth = 0;
		int lineWidth = (int)w;
		
		maxTextWidth = 0;
		
		for(int i = 0; i < textWords.length; i++)
		{
			if(textWords[i].equals("<l>")) { bullets = true; continue; }
			if(textWords[i].equals("<b>")) { bold = true; continue; }
			if(textWords[i].equals("</b>")) { bold = false; continue; }
			if(textWords[i].equals("<h1>")) { textSize(16); continue; }
			if(textWords[i].equals("<n>")) { textSize(12); continue; }
			if(textWords[i].equals("<*>")) { curLineWidth = 32000; continue; }
			if(textWords[i].equals("<s1>")) 
			{ 
				image(starIcon,curX,curY); 
				curX += 20;
				continue; 
			}
			
			if(bold) textFont(fbold);
			else textFont(font);
			
			int wordWidth = (int)textWidth(textWords[i]);
			
			if(curLineWidth + wordWidth >= lineWidth || textWords[i].endsWith("\n"))
			{
				if(curLineWidth > maxTextWidth) maxTextWidth = curLineWidth;
				if(textWords[i].endsWith("\n"))
				{
					text(textWords[i], curX, curY);
					curY += textHeight;
					if(bullets)	
					{
						curX = 20;
						curLineWidth = 20;
					}
					else 
					{
						curX = 0;
						curLineWidth = 0;
					}
				}
				else
				{
					curY += textHeight;
					if(bullets)	
					{
						curX = 40;
						curLineWidth = 40;
					}
					else 
					{
						curX = 0;
						curLineWidth = 0;
					}
					text(textWords[i], curX, curY);
					curX += wordWidth + 5;
					curLineWidth = curX;
				}
				//numLines++;
			}
			else
			{
				text(textWords[i], curX, curY);
				curX += wordWidth + 5;
				curLineWidth = curX;
			}
		}
		if(curLineWidth > maxTextWidth) maxTextWidth = curLineWidth;
		
		h = curY + 10;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	String _wrapText(String string, int lineWidth)
	{
		textWords = string.split(" ");
		return "don";
		// String[] words = string.split(" ");
		// String output = "";
		// String line = "";
		// boolean bullets = false;
		// boolean bold = true;
		// for(int i = 0; i < words.length; i++)
		// {
			// if(words[i].equals("BULLET")) bullets = true; continue;
			// if(words[i].equals("BOLD")) bold = true; continue;
			// if(words[i].equals("NOBOLD")) bold = false; continue;
			
			// String testLine = line + words[i] + " ";
			// if(textWidth(testLine) >= lineWidth || words[i].endsWith("\n"))
			// {
				// if(words[i].endsWith("\n"))
				// {
					// output += line + words[i];
					// if(bullets) line = "  ";
					// else line = "";
				// }
				// else
				// {
					// output += line + "\n";
					// if(bullets) line = "     " + words[i] + " ";
					// else line = words[i] + " ";
				// }
				// numLines++;
			// }
			// else
			// {
				// line = testLine;
			// }
		// }
		// output += line;
		// numLines++;
		// return output;
	}
}
