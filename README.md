# Latex CV with sidebar template

## Quick start

Clone or download class `cv.cls` along with one of the templates `one_page_template.tex` and `two_pages_templates.tex` and fill the template with your personal information.

**This is the one page template as provided :**

![[Template and preview](https://raw.githubusercontent.com/viccol961/latex_cv_template/master/one_page_template.jpg)](https://raw.githubusercontent.com/viccol961/latex_cv_template/master/one_page_template.jpg)

*The wheel chart above looks weird, it is due to the pdf - jpg conversion. The actual pdf output is perfectly normal !*

## Sidebar

### Personal information

This is included in the front page sidebar.

Both a name and a job title are mandatory (displayed on both pages) :

```[latex]
\cvname{Your Name}
\cvjobtitle{Your job position / what job you're looking for / anything else really...}
```

You can choose to add a profile picture in your resume, it will be displayed above your name

Below that, you may choose to add additional information about yourself (incl contact information) : `\cvcustom{logo}{description}`. Description can be a link with `\href{link}{text}`.

For your convenience, there are several pre-defined macros with their proper icon : `\cvbirthday{}`, `\cvaddress{}`, `\cvphone{}`, `\cvmail{}` (creates a mailto: link) and `\cvsite{}` (also creates a link).

### Custom sidebar sections

To append information to either sidebars, use the following macros : `\addtofrontsidebar{}` and `\addtobacksidebar{}`. Use `\sidebarsection{}` to organize your sidebar data.

**List of commands for the sidebar :**

See template to see what these render like.

```[latex]
\aboutme{
    A short text to present yourself.
}
```

```[latex]
\namedskill{logo/flag}{Title}{Description}
\namedskill{\flag{FR.png}}{French}{Native}
```

When using `XeLaTeX` or `LuaLaTeX`, both fontawesome5 and academicons icons are available.  
When using `pdfLaTeX`, fontawesome icons are available.  
Flags available here : <https://github.com/gosquared/flags>

Use `\flag{}` for a flag to avoid the icon to be recolored appropriately to the CV style.  
Use `\cvicon{}` for any other icon.

```[latex]
\pointskill{logo/flag}{Name}{Score}[Total score]
\pointskill{}{\LaTeX}{4}[4]
```

```[latex]
\skill{icon}{Name}
\skill{\faCar}{Driver's license}
```

```[latex]
\wheelchart[rotation, default -90]{outer-diameter}{inner-diameter}{
    percentage/text-width/color/title,
    ...
}
\wheelchart{3.7em}{2em}{
    20/3em/maincolor!50/Chill,
    15/3em/maincolor!15/Play,
    30/4em/maincolor!40/Sleep,
    20/3em/maincolor!20/Eat
}
```

## CV Items

All default top spacings are `0.5em`.

Item `bis` variations are with dates in front.

```[latex]
\cvitemlogo[<top-spacing>]{<logo>}{<dates>}{<title>}{<location>}{<optional: description>}
```

```[latex]
\cvitem[<top-spacing>]{<dates>}{<cv-item title>}{<location>}{<optional: description>}
\cvitembis[<top-spacing>]{<dates>}{<cv-item title>}{<location>}{<optional: description>}
```

```[latex]
\cvitemshort{<key>}{<description>}
```

### Publications

```[latex]
\cvpubitem[<top-spacing>]{<title>}{<author>}{<journal>}{<year>}
\cvpubitembis[<top-spacing>]{<title>}{<author>}{<journal>}{<year>}
```

## Documentclass parameters

|Name|Default|Description|
|---|---|---|
|maincolor|#0E5484|Main theme color|
|sidecolor|#E7E7E7|Sidebar background color|
|sectioncolor|#0395DE|Main CV side section color|
|subsectioncolor|#4F4F4F|Main CV side subsection color|
|itemtextcolor|black!90|Main CV side description text color|
|sidebarwidth|0.34\paperwidth|Sidebar total width (all background aera)|
|topbottommargin|0.02\paperheight|Vertical document margins|
|leftrightmargin|0.02\paperwidth|Horizontal document and sidebar margins|
|profilepicsize|0.7\sidebarwidth|Profile picture diameter|
|profilepicborderwidth|2pt|Profile picture border width|
