\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2020/11/11 CV class]


% === PACKAGES === %

\RequirePackage[dvipsnames, svgnames, x11names]{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{xkeyval}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage[nohead,nofoot,nomarginpar]{geometry}


% === COLORS === %

\definecolor{cvblue}{HTML}{0E5484}
\definecolor{cvgreen}{HTML}{007170}
\definecolor{cvred}{HTML}{8B0000}
\definecolor{cvsidecolor}{HTML}{E7E7E7}
\definecolor{cvsectioncolor}{HTML}{0395DE}
\definecolor{cvsubsectioncolor}{HTML}{4D4D4D}
% Default values
\colorlet{maincolor}{cvblue}
\colorlet{sidecolor}{cvsidecolor}
\colorlet{sectioncolor}{cvsectioncolor}
\colorlet{subsectioncolor}{cvsubsectioncolor}
\colorlet{itemtextcolor}{black!90}
% Color options
\DeclareOptionX{maincolor}{\colorlet{maincolor}{#1}}
\DeclareOptionX{sidecolor}{\colorlet{sidecolor}{#1}}
\DeclareOptionX{sectioncolor}{\colorlet{sectioncolor}{#1}}
\DeclareOptionX{subsectioncolor}{\colorlet{subsectioncolor}{#1}}
\DeclareOptionX{itemtextcolor}{\colorlet{itemtextcolor}{#1}}

% Additional colors
\colorlet{pseccolor}{maincolor!90} % profile section
\colorlet{iconcolor}{maincolor!90} % icon arguments
\colorlet{wheelchartlabelcolor}{black}
\colorlet{wheeltextcolor}{black!80!white}
\colorlet{skillbg}{black!25} % unfilled skill points fill


% === MARGINS === %

\newlength\sidebarwidth
\newlength\topbottommargin
\newlength\leftrightmargin
\newlength\sidebartextwidth
% Default values
\setlength{\sidebarwidth}{0.34\paperwidth}
\setlength{\topbottommargin}{0.02\paperheight}
\setlength{\leftrightmargin}{0.02\paperwidth}
% Margins options
\DeclareOptionX{sidebarwidth}{\setlength{\sidebarwidth}{#1}}
\DeclareOptionX{topbottommargin}{\setlength{\topbottommargin}{#1}}
\DeclareOptionX{leftrightmargin}{\setlength{\leftrightmargin}{#1}}


% === PROFILE PIC PARAMS === %

\newlength\profilepicsize
\setlength{\profilepicsize}{0.7\sidebarwidth}
\DeclareOptionX{profilepicsize}{\setlength{\profilepicsize}{#1}}
\newlength\profilepicborderwidth
\setlength{\profilepicborderwidth}{3.5pt}
\DeclareOptionX{profilepicborderwidth}{\setlength{\profilepicborderwidth}{#1}}


% === LOAD ARTICLE CLASS === %

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptionsX\relax
\LoadClass{article}


% === PAGE SETUP === %

\setlength{\sidebartextwidth}{\sidebarwidth - 2\leftrightmargin}
\geometry{
	top=\topbottommargin,
	bottom=\topbottommargin,
	left=\sidebarwidth + \leftrightmargin,
	right=\leftrightmargin,
}
\pagestyle{empty}
\setlength{\parindent}{0pt}


% === ADDITIONAL PACKAGES === %

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[texcoord]{eso-pic}
\RequirePackage{titlesec}
\RequirePackage{graphbox}
\RequirePackage{tabularx}

\RequirePackage{ifluatex}\RequirePackage{ifxetex}
\ifxetex
	\ifluatex
		\RequirePackage{fontawerome5}
		\RequirePackage{academicons}
	\else
		\RequirePackage{fontawesome}
	\fi
\else
	\RequirePackage{fontawesome}
\fi

\RequirePackage{tikz}\usetikzlibrary{arrows,backgrounds}
\RequirePackage{xhfill}
\RequirePackage{ifthen}
\RequirePackage{xparse}
\RequirePackage[hidelinks]{hyperref}


% Line in the remaining line width
\newcommand*{\sectionline}[1]{#1~\xrfill[.5ex]{1pt}[pseccolor]}


% === SECTION SETUP === %
% CV Section
\newcommand*{\cvsection}[1]{\section*{#1}}
\titleformat{\section}
	{\color{sectioncolor}\normalfont\bfseries\LARGE}{}{0pt}{}
\titlespacing*{\section}{0pt}{1.5ex}{1ex}

% CV sunsection
\newcommand*{\cvsubsection}[1]{\subsection*{#1}}
\titleformat{\subsection}
    {\color{subsectioncolor}\normalfont\large}{}{0pt}{}

% Left column section
\newcommand*{\profilesection}[1]{\subsubsection*{#1}}
\titleformat{\subsubsection}
	{\color{pseccolor}\normalfont\huge}{}{0pt}{\color{pseccolor}\sectionline}
% "starred version kills the indentation of the paragraph following the title"
\titlespacing*{\subsubsection}{0pt}{1ex}{1ex}


%---------------------------------------------------------------------------
%                            SIDEBAR ELEMENTS
%---------------------------------------------------------------------------


% === PROFILE PICTURE (optional) === %
\newcommand{\plotprofilepicture}{}
\newcommand*{\cvprofilepic}[1]{
	\renewcommand{\cvprofilepic}{#1}
}

\newcommand{\profilecircle}{
	\begin{figure}\centering
		\begin{tikzpicture}[x=\profilepicsize, y=\profilepicsize]
			\begin{scope}
				\clip (0, 0) circle (0.5);
				\node[anchor=center, inner sep=0pt, outer sep=0pt]
					(profilepic) at (0,0) {
				\includegraphics[width=\profilepicsize]
					{\cvprofilepic}};
			\end{scope}
			\ifdim \profilepicborderwidth > 0pt
				\begin{scope}
					\draw[line width=\profilepicborderwidth, color=iconcolor]
						(0, 0) circle (0.5\profilepicsize);
				\end{scope}
			\fi
		\end{tikzpicture}
	\end{figure}
}


% === PERSONNAL ITEMS === %

% \persoinfo{<icon>}{<text>}
\newcommand*{\persoinfo}[2]{%
	\circleicon{#1} & {#2}\\%
}

% Record personal info
\newcommand{\personaldata}{}
\newcommand*{\cvcustom}[2]{%
	\apptocmd{\personaldata}{\persoinfo{#1}{#2}}{}{}%
}


\newcommand*{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand*{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

\newcommand{\nameandjob}{%
	{\Huge\color{maincolor}\cvname}\par%
	\setlength{\parskip}{2ex}
	{\Large\color{black!80}\cvjobtitle}\par%
	\setlength{\parskip}{1ex}
}

% Personnal items shortcuts
\newcommand*{\cvbirthday}[1]{\cvcustom{\faUser}{#1}}
\newcommand*{\cvaddress}[1]{\cvcustom{\faEnvelope}{#1}}
\newcommand*{\cvphone}[1]{\cvcustom{\faPhone}{#1}}
\newcommand*{\cvsite}[1]{\cvcustom{\faGlobe}{\href{#1}{#1}}}
\newcommand*{\cvmail}[1]{\cvcustom{\faAt}{\href{mailto:#1}{#1}}}

% Icons for personnal info
\newcommand*\circleicon[1]{
	\tikz[baseline = (char.base)]{
		\node[
			shape=circle,
			draw,
			inner sep=1pt,
			fill=iconcolor,
			maincolor,
			text=white,
			minimum size=\hsize
		] (char) {#1};
	}
}

% About me, constrain text
\newcommand{\aboutme}[1]{\parbox[b]{\linewidth}{#1}}

% Uniform icon style
\newcommand{\cvicon}[1]{
	\makebox[1em]{\color{iconcolor} #1}
}
\newcommand{\flag}[1]{\includegraphics[align=c, width=1em]{#1}}

% === SKILL DIAGRAMS === %

% \namedskill[<indent>]{<icon>}{<description>}{<name>}
% | [indent] [icon] description \hfill name
\NewDocumentCommand{\namedskill}{ O{0em} m m m }{
	\hspace{#1} \ifthenelse{\equal{#2}{}}{}{\cvicon{#2} ~} #3 \hfill #4 \par
}

% \skill[<indent>]{<icon>}{<description>}{<points>}[<maxpoints>]
% | [indent] [icon]  description  \hfill  ● ● ● ○ ○ |
\NewDocumentCommand{\pointskill}{ O{0em} m m m O{5} }{
	\hspace{#1} \ifthenelse{\equal{#2}{}}{}{\cvicon{#2} ~} #3 \hfill
	\foreach \x in {1,...,#5}{
		\space
		{\ifnumgreater{\x}{#4}{\color{skillbg}}{\color{iconcolor}}% from etoolbox
		\raisebox{0.5\height-0.4ex}{\scriptsize\faCircle}%
		}
	}\par
}

% \skill[<indent>]{<icon>}{<description>} creates in sidebar
% | [indent] [icon]  some longer skill description  |
\newcommand{\skill}[3][0em]{
	\hspace{#1} \ifthenelse{\equal{#2}{}}{}{\cvicon{#2} ~} \parbox{\linewidth-#1-2.5em}{#3} \hfill \par
}


% === WHEEL CHARTS === %

\newcommand{\wheelchart}[4][-90]{
	\def\outerradius{#2}
	\def\innerradius{#3}
	% Calculate total
	\pgfmathsetmacro{\totalnum}{0}
	\foreach\value/\colour/\name in {#4} {
		\pgfmathparse{\value+\totalnum}
		\global\let\totalnum=\pgfmathresult
	}
	\begin{tikzpicture}

		% Calculate the thickness and the middle line of the wheel
		\pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
		\pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}

		% Rotate so we start from the top
		\begin{scope}[rotate=#1, on background layer]
		% Loop through each value set. \cumnum keeps track of where we are in the
		% wheel
		\pgfmathsetmacro{\cumnum}{0}
		\foreach \value/\width/\colour/\name in {#4} {
			\pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

			% Calculate the percent value
			\pgfmathsetmacro{\percentage}{\value/\totalnum*100}
			% Calculate the mid angle of the colour segments to place the labels
			\pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

			% This is necessary for the labels to align nicely
			\pgfmathparse{
				(-\midangle>180?"west":"east")
			} \edef\textanchor{\pgfmathresult}
			\pgfmathparse{
				(-\midangle>180?"flush left":"flush right")
			} \edef\textalign{\pgfmathresult}
			\pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

			% Draw the color segments. Somehow, the \midrow units got lost, so
			% we add 'pt' at the end. Not nice...
			\filldraw[draw=white,fill=\colour]
				(-\cumnum:\outerradius)
				arc (-\cumnum:-(\newcumnum):\outerradius)
				-- (-\newcumnum:\innerradius)
				arc (-\newcumnum:-(\cumnum):\innerradius)
				-- cycle;

			% Draw the data labels
			\draw [*-,thin,wheelchartlabelcolor] node [append after command={
				(\midangle:\midradius pt) --
				(\midangle:\outerradius + 1ex) --
				(\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [
				xshift=\labelshiftdir*0.5cm,inner sep=1ex,
				outer sep=0pt,
				text width=\width,
				anchor=\textanchor,
				align=\textalign,
				font=\small,
				text=wheeltextcolor
			]{\name};
			% Set the old cumulated angle to the new value
			\global\let\cumnum=\newcumnum
		}
		\end{scope}
	\end{tikzpicture}\par
}


%---------------------------------------------------------------------------
%                            LIST ENVIRONMENTS
%---------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% \icontable{<width 1st column>}{<space between columns>}{<arraystretch>}
\newenvironment{icontable}[3][1]
{
	\renewcommand{\arraystretch}{#1}% increase linespacing in tables; default=1
	\tabularx{\sidebartextwidth}{m{#2} @{\hskip #3} X}
}{
	\endtabularx
}

% \cvtable[<array-stretch>]
\newenvironment{cvtable}[1][1]{
	\renewcommand{\arraystretch}{#1}
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}

% \cvitemlogo[<top-spacing>]{<logo>}{<dates>}{<title>}{<location>}{<optional: description>}
% | <logo>   <bold-title>, <location>         <date> |
% |          <description>                           |
\newcommand{\cvitemlogo}[6][0.5em]{
	\ifthenelse{\equal{#1}{}}{}{\vspace{#1}}
	\parbox[c]{0.17\linewidth}{ % space for logo, incl logo if arg not empty
		\ifthenelse{\equal{#2}{}}{}{\includegraphics[width=\linewidth]{#2}}
	}
	&
	\parbox{0.81\linewidth}{
		\parbox{\linewidth-\widthof{#3}-1em}{ % leave space for the date
			\raggedright\textbf{#4}
			\ifthenelse{\equal{#5}{}}{}{, #5} % , <date> if arg not empty
		} \hfill \textbf{#3}
		\ifthenelse{\equal{#6}{}}{}{ % <description> if arg not empty
			\\ \textcolor{itemtextcolor}{#6}
		}
	} \\
}

% \cvitem[<top-spacing>]{<date>}{<title>}{<location>}{<description>}
\newcommand{\cvitem}[5][0.5em]{
	\ifthenelse{\equal{#1}{}}{}{\vspace{#1}}
	\parbox{\linewidth}{
		\parbox{\linewidth-\widthof{#2}-1em}{ % leave space for the date
			\raggedright\textbf{#3}
			\ifthenelse{\equal{#4}{}}{}{, #4} % , <date> if arg not empty
		} \hfill \textbf{#2}
		\ifthenelse{\equal{#5}{}}{}{ % <description> if arg not empty
			\\ \textcolor{itemtextcolor}{#5}
		}
	} \\
}

% \cvitembis[<top-spacing>]{<date>}{<title>}{<location>}{<description>}
% | <date>         <bold-title>  \hfill  <location>  |
% |                <description>                     |
\newcommand{\cvitembis}[5][0.5em]{
	\ifthenelse{\equal{#1}{}}{}{\vspace{#1}}
	\parbox[t]{0.17\textwidth}{\raggedright #2}
	&
	\parbox[t]{0.81\textwidth}{
		\parbox{\linewidth-\widthof{#4}-1em}{ % leave space for the date
			\raggedright \textbf{#3}
		} \hfill #4
		\ifthenelse{\equal{#5}{}}{}{
			\\ \textcolor{itemtextcolor}{#5}
		}
	} \\
}

% | <keyword>      <one-line description>            |
% use parbox if text needs to use multiple lines
\newcommand{\cvitemshort}[3][0.5em]{
	\ifthenelse{\equal{#1}{}}{}{\vspace{#1}}
	\parbox[t]{0.17\textwidth}{\raggedright #2}
	& \parbox[t]{0.81\textwidth}{#3} \\
}

% \cvpubitem[<top-spacing>]{<title>}{<author>}{<journal>}{<year>}
\newcommand{\cvpubitem}[5][0.5em]{
	\ifthenelse{\equal{#1}{}}{}{\vspace{#1}}
	\parbox{\linewidth}{
		\parbox{\linewidth-\widthof{#5}-1em}{ % leave space for the date
			\raggedright \textbf{#2}
		} \hfill #5
		\textit{#3} \par #4
	} \\
}

% \cvpubitembis[<top-spacing>]{<title>}{<author>}{<journal>}{<year>}
% | <year>         <bold title>                      |
% |                <italic author>                   |
% |                <journal>                         |
\newcommand{\cvpubitembis}[5][0.5em]{
	\ifthenelse{\equal{#1}{}}{}{\vspace{#1}}
	\parbox[t]{0.17\textwidth}{\raggedright #5}
	&
	\parbox[t]{0.81\textwidth}{
		\textbf{#2} \par \textit{#3} \par #4
	} \\
}


%---------------------------------------------------------------------------
%                             SIDEBAR LAYOUT
%---------------------------------------------------------------------------

% === SIDEBAR & BACKGROUD === %

\newcommand{\drawSidebarBG}{
	\AddToShipoutPictureBG*{
		\begin{tikzpicture}[remember picture, overlay]
			\node[
				rectangle,
				fill=sidecolor,
				anchor=north west,
				minimum width=\sidebarwidth,
				minimum height=\paperheight,
			]{};
		\end{tikzpicture}
	}
}

\newenvironment{sidebarminipage}
	{\begin{minipage}{\sidebartextwidth}}
	{\end{minipage}}

\newenvironment{sidebar}{
	\drawSidebarBG
	\begin{textblock*}{\sidebartextwidth}(\leftrightmargin, \topbottommargin)
}{
	\end{textblock*}
}


% === SIDEBAR DISPLAY === %

% User interface to append to front / back sidebar
\newcommand{\frontsidebar}{}
\newcommand{\backsidebar}{}
\newcommand{\addtofrontsidebar}[1]{\apptocmd{\frontsidebar}{#1}{}{}}
\newcommand{\addtobacksidebar}[1]{\apptocmd{\backsidebar}{#1}{}{}}

\newcommand{\makefrontsidebar}{%
	\begin{sidebar}
		% most sidebar commands end with \par; increase space between them
		\setlength{\parskip}{1ex}

		% insert profile picture
		\profilecircle
		\vspace{1ex}

		% name and job
		\nameandjob

		% personal information
		\vspace*{0.5em}
		\begin{icontable}[1.6]{1.7em}{0.4em}
			\personaldata
		\end{icontable}

		% user definitions
		\frontsidebar
	\end{sidebar}
}

\newcommand{\makebacksidebar}{%
	\begin{sidebar}
		% begin with name instead of picture
		\nameandjob

		% make sure there is no space at top, but after cvjob
		\setlength{\parskip}{1ex}

		% user definitions
		\backsidebar
	\end{sidebar}
}
