
# Links
```
[Link Name](URL)
```
[GitHub - Basic Formatting Syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)


# Code Blocks
- You can create fenced code blocks by placing triple backticks ``` before and after the code block.
- We recommend placing a blank line before and after code blocks to make the raw formatting easier to read.
  
```
write-host "This is a code block"
write-host "triple backticks only visible on edit"
```



# Styling Text<br>
```
**bold**<br>
_italicized_<br>
<ins>underlined</ins><br>
~~strikethrough~~<br>
<br>
**This text is _extremely_ important**<br>
***All this text is important***<br>
This is <sub>subscript</sub> text<br>
This is <sup>superscript</sup> text<br>
This is  text<br>
```


# Number List
- Start each list item with a number followed by a period and a space.
- The specific number used for each item does not need to be sequential in the source Markdown; the rendering engine will automatically handle the numbering.
- It is common practice to use "1." for every item to simplify reordering.
- Ensure a __blank line__ separates the list from any preceding or following paragraphs. Without a blank line, the text may not be rendered as a list.
```
1. First item
2. Second item
3. Third item
```

# Table Formatting
- You can create tables with pipes `|` and hyphens `-`.
- Hyphens are used to create each column's header, while pipes separate each column.
- You must include a blank line before your table in order for it to correctly render.
- The pipes on either end of the table are optional.
- Cells can vary in width and do not need to be perfectly aligned within columns.
- There must be at least three hyphens in each column of the header row.

| Command | Description |
| --- | --- |
| Command 1 | Command 1 description |
| Command 2 | Command 2 description |

- You can align text to the left, right, or center of a column by including colons `:` to the left, right, or on both sides of the hyphens within the header row.
  
| Left-aligned | Center-aligned | Right-aligned |
| :---         |     :---:      |          ---: |
| git status   | git status     | git status    |



# Images
> [!IMPORTANT]
> - **25 MB**: for files added via the browser.
> - **100 MB**: for files added via the command line. Pushing a file larger than 50MB will typically result in a warning, while files exceeding 100MB will be blocked.

### From LOCAL REPO:
```
<p align="center">
  <img src="VISUALS/google-dino.png">
  <br/>
</p>
```

### From WEB:
```
Code:
![alt text](https://github.com/[username]/[reponame]/blob/[branch]/image.jpg?raw=true)

Example:
![Sample](https://github.com/franco-on-git/Images/blob/main/Scripts-and-Commands/GitHub_AutoSize.jpg)
```

# Font Coloring

```html
<span style="color:red;">This text is red.</span>

<span style="color:#008000;">This text is green using a hex code.</span>

<font color="cyan">This text is Cyan.</font>
```

# Alerts
> [!NOTE]
> - Useful information that users should know, even when skimming content.

> [!TIP]
> - Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> - Key information users need to know to achieve their goal.

> [!WARNING]
> - Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> - Advises about risks or negative outcomes of certain actions.



