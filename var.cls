%% var.cls 
%% Copyright 2020 Sandro Leuchter (sandro.leuchter@dama.io)
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Sandro Leuchter.
%
% This work consists of the files var.cls, Makefile
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
% var class for xelatex2e, https://github.com/tastaturtier/var-layout-ste
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{var}[2020/07/07 VAR book series LaTeX class]
%
% This layout class has been developed for my series of books called "Verteilte Architekturen" (VAR)
% published by Steinbeis Edition in Stuttgart, Germany (https://verteiltearchitekturen.de/)
%
% The editorial office of the publisher helped a lot with layout, typography, and book styling
% during copy editing cycles of the first number of the series. The grown latex code was then 
% revised and rewritten as a layout bundled together with a scaffolding project layout and build 
% toolset. Starting with the second number of the book series XeLaTex, GUST's Tex Gyre fonts, and
% the var layout class are used for the production.
%  
% You may use and modify this class for your own book projects, see LICENSE
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% colour model
%%
\RequirePackage{xcolor}
\definecolor{var@colour01}{named}{black} 	           % black
\definecolor{var@colour02}{named}{white} 	           % white
\definecolor{var@colour03}{rgb}{0.98, 0.92, 0.84}    % background
\definecolor{var@colour04}{RGB}{243,102,25} 	       % basecolour 1, ocre
\definecolor{var@colour05}{named}{yellow} 	         % basecolour 2, yellow
\definecolor{var@colour06}{named}{orange} 	         % basecolour 3, orange

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% names for captions etc.
%%
\def\var@captionsgerman{%
  \def\var@excursusname{Exkurs}%
  \def\var@activitiesname{Praktikum}%
  \def\var@activityname{Aktivitätsschritt}%
  \def\var@objectivename{Ziel}%
  \def\var@activitiesheadingname{Aktivitätsschritte}%
  \def\var@abbreviationsname{Abkürzungsverzeichnis}%
  \def\var@listingname{Listing}%
  \def\var@creditsname{Bildnachweise}%
  \def\var@pagename{Seite}%
  \def\var@covername{Titelbild}%
  \def\var@appendixname{Anhang}%
  \def\var@figname{Abbildung}%
  \def\var@contentsname{Inhaltsverzeichnis}% not properly working with polyglossia?
}
\def\var@captionsbritish{%
  \def\var@excursusname{Excursus}%
  \def\var@activitiesname{Exercises}%
  \def\var@activityname{Activity Step}%
  \def\var@objectivename{Objective}%
  \def\var@activitiesheadingname{Activity Steps}%
  \def\var@abbreviationsname{Abbreviations}%
  \def\var@listingname{Listing}%
  \def\var@creditsname{Credits}%
  \def\var@pagename{Page}%
  \def\var@covername{Cover}%
  \def\var@appendixname{Appendix}%
  \def\var@figname{Figure}%
  \def\var@contentsname{Table of Contents}% not properly working with polyglossia?
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% handling of options
%%
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{kvoptions}
\DeclareBoolOption[false]{draft}
\DeclareBoolOption[false]{ebook}
\DeclareStringOption[german]{lang}
\newcommand{\var@null}{}
\DeclareStringOption[\var@null]{prefacefile}
\DeclareStringOption[\var@null]{lastpagefile}
\ProcessKeyvalOptions*
\csname var@captions\var@lang \endcsname

% from the amsgen package (not clear if available outside miktex)
% http://www.texdoc.net/texmf-dist/doc/latex/amsmath/amsgen.pdf
\long\def\@ifempty#1{\@xifempty#1@@..\@nil}
\long\def\@xifempty#1#2@#3#4#5\@nil{%
  \ifx#3#4\expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi}
\long\def\@ifnotempty#1{\@ifempty{#1}{}}

\newcommand{\varcovercredits}[1]{\def\var@covercredits{#1}}
\newcommand{\varappendiximg}[2][\var@null]{
  \ifthenelse{\equal{\var@null}{#1}}{
  }{
    \def\var@appendixcredits{#1}
  }
  \def\var@appendiximg{#2}
}

% "print" complementary to "ebook"
\newboolean{var@print} 
\ifthenelse{\boolean{var@ebook}}{
  \setboolean{var@print}{false}
}{
  \setboolean{var@print}{true}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% load base class
%%
\ifthenelse{\boolean{var@draft}}{
  \def\var@draftoption{,draft}
  \setboolean{var@print}{false}
  \setboolean{var@ebook}{true}
}{
  \def\var@draftoption{}
}
\ifthenelse{\boolean{var@print}}{
  \LoadClass[10pt,twoside\var@draftoption]{book}
}{
  \LoadClass[10pt,oneside\var@draftoption]{book}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% (portable) fonts
%%
\RequirePackage{fontspec,xunicode}
\defaultfontfeatures{Mapping=tex-text}
% portable Fonts (http://www.gust.org.pl/projects/e-foundry/tex-gyre/whole)
\setmainfont[Mapping=tex-text]{TeX Gyre Termes}
\setsansfont[Mapping=tex-text]{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% href, url, etc. with bookmark and URL-hyphenation/breaking not only at _
%%
\PassOptionsToPackage{hyphens}{url}
\RequirePackage[linktoc=all,unicode=true,bookmarks=true,bookmarksnumbered=true,bookmarksopen=true,bookmarksopenlevel=0,breaklinks=true,pdfborder={0 0 0},backref=false,colorlinks=false]{hyperref}
\def\UrlBreaks{\do\/\do-\do\_} % breaks URLs also at /, - and _

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% layout
%%
\RequirePackage{listings}
\RequirePackage{fix-cm}
\RequirePackage[export]{adjustbox}

% captions right ragged, hanging, etc.
\RequirePackage{ragged2e}
\RequirePackage[font=small,labelfont=bf,labelsep=colon,format=plain,justification=RaggedRight,singlelinecheck=false]{caption}

% section headings (below chapter) all right ragged:
\RequirePackage{sectsty}
\sectionfont{\raggedright}
\subsectionfont{\raggedright}
\subsubsectionfont{\raggedright}
\paragraphfont{\raggedright}

\RequirePackage[all]{nowidow}
\raggedbottom

\RequirePackage[absolute]{textpos} 

% Parameter, die die Positionierung von floats (figure, table, listing, exkurs) beeinflussen:
\setcounter{totalnumber}{6}            % max. Anzahl floats gesamt
\setcounter{topnumber}{4}              % max. Anzahl floats im Bereich top
\setcounter{bottomnumber}{4}           % max. Anzahl floats im Bereich bottom
\renewcommand{\topfraction}{0.7}       % maximale Größe des top-Bereichs
\renewcommand{\bottomfraction}{0.9}    % maximale Größe des bottom-Bereichs
\renewcommand{\textfraction}{0.1}      % minimale Größe des Textbereichs (float-freier Teil)
\floatsep10pt plus5pt minus5pt         % Abstand zwischen floats innerhalb top/bottom
\textfloatsep10pt plus5pt minus5pt     % Abstand zwischen top/bottom und Textbereich
\intextsep10pt plus5pt minus5pt        % Abstand zwischen "here"-float und Text davor/danach
\renewcommand{\floatpagefraction}{0.6} % minimaler Anteil einer Seite, der durch floats besetzt werden muss, 
                                       % bevor eine Gleitseite oder Gleitkolumne gebildet werden darf

% Layout:
\RequirePackage[paperwidth=16cm,paperheight=23cm]{geometry}
\geometry{tmargin=2.4cm, bmargin=2.3cm, textwidth=12cm, marginparwidth=5em, marginparsep=1em}

% cropmarks of 3mm at print:
\ifthenelse{\boolean{var@print}}{
  \RequirePackage[cam,width=163truemm,height=233truemm,center]{crop}
}{}  

\newcommand{\var@chapterimg}{}
\newcommand{\var@chapterimgcredit}{}

\setlength{\parskip}{0pt}
\setlength{\parindent}{0pt}
\RequirePackage[explicit]{titlesec}

\RequirePackage{float}
\RequirePackage{graphicx}

\RequirePackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{calc}

\RequirePackage{setspace}
\onehalfspacing

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% Grafiken im allgemeinen und überbreite Grafiken (sollen den jeweiligen Marginalienrand ausnutzen)
%%
\RequirePackage{ifoddpage}
\newcommand{\var@figure}[5][\var@null]{
  \begin{figure}[#2]\centering
    #3
  \caption{\label{#4}#5}\ifthenelse{\equal{\var@null}{#1}}{#2}{\var@credit[#4]{#1}}
  \end{figure}
  \edef\marginnotetextwidth{\the\textwidth}
}  
\newcommand{\var@figureWide}[5][\var@null]{
  \var@figure[#1]{#2}{
    \if@twoside% test for twoside instead of \bool{\var@print} because of possible future use of twoside
      \checkoddpage
      \ifoddpage
        #3
      \else
        \hspace{-15mm}#3
      \fi
    \else% ebook/oneside
      #3
    \fi%
  }{#4}{#5}
}
\newcommand{\vargraphics}[6][\var@null]{
  \var@figure[#1]{#2}{\includegraphics[width=#3\textwidth]{#4}}{#5}{#6}}
\newcommand{\vargraphicsWide}[5][\var@null]{
  \var@figureWide[#1]{#2}{\includegraphics[width=\dimexpr(\textwidth + 15mm)]{#3}}{#4}{#5}}
\newcommand{\vargraphicsWideRotate}[5][\var@null]{
  \var@figureWide[#1]{#2}{\includegraphics[height=\dimexpr(\textwidth + 15mm),angle=90]{#3}}{#4}{#5}}
  

\newenvironment{vartable}[4][]{
  \begin{table}[#1]
    \caption{\label{#3}#4}
    \begin{adjustbox}{center,%
      max width={\textwidth},%
      max totalheight={\textheight}}
      \begin{tabular}{#2}
}{
      \end{tabular}
    \end{adjustbox}
  \end{table}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% chapter headings
%% chapter picture width at print \paperwidth + 3mm for 3mm cropmarks (STE-Vorgabe)
%% chapter picture width at ebook \paperwidth for 3mm cropmarks (STE-Vorgabe)
%%
\titlespacing*{\chapter}{0pt}{*27.5}{*6}
\ifthenelse{\boolean{var@draft}}{
  \titleformat{\chapter}[display]
  {\bfseries\Large}
  {}
  {-3ex}
  {\tikz[remember picture,overlay]\node[inner sep=0pt] at ($(current page.north) + (0,-3.5cm)$) {};
    \\\filcenter \Huge\sffamily #1
  }
  [\vspace{1ex}%
  \titlerule]%
}{
  \ifthenelse{\boolean{var@print}}{
    \titleformat{\chapter}[display]
      {\bfseries\Large}
      {}
      {-3ex}
      {\tikz[remember picture,overlay]\node[inner sep=0pt] at ($(current page.north) + (0,-3.5cm)$) {\includegraphics[width=\dimexpr(\paperwidth + 3mm)]{\var@chapterimg}};
        \\\filcenter \Huge\sffamily #1
      }
      [\vspace{1ex}%
      \titlerule]%
  }{
    \titleformat{\chapter}[display]
      {\bfseries\Large}
      {}
      {-3ex}
      {\tikz[remember picture,overlay]\node[inner sep=0pt] at ($(current page.north) + (0,-3.5cm)$) {\includegraphics[width=\paperwidth]{\var@chapterimg}};
      \\\filcenter \Huge\sffamily #1
      }
      [\vspace{1ex}%
      \titlerule]%
  }
}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% foliation, page numbering etc.
%%
\RequirePackage{calc}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\newcommand{\var@howtocite}{}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\fancyhf{} % clear the headers
\ifthenelse{\boolean{var@print}}{
  \fancyhead[EL,OR]{\sffamily\itshape
    \ifnum\value{chapter}>0 \thechapter. \fi
    \leftmark}
  \fancyfoot[EL,OR]{\thepage}
  \fancyfoot[ER]{}
  \fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhf{}
    \fancyfoot[EL]{\thepage\hfill\parbox{10cm}{\footnotesize\textsf{\var@howtocite}}}
    \fancyfoot[OR]{\parbox{10cm}{\footnotesize\textsf{\var@howtocite}}\hfill\thepage}
  }
  \newcommand{\var@pageBreakForOdd}{
    \newpage\checkoddpage\ifoddpage%
    \else%
      \thispagestyle{empty}\newpage
    \fi%
  }
  \newcommand{\var@pageBreakForEven}{
    \newpage~\checkoddpage\ifoddpage%
      \thispagestyle{empty}\newpage~
    \fi%
  }
}{
  \fancyhead[OR]{\sffamily\itshape
    \ifnum\value{chapter}>0 \thechapter. \fi
    \leftmark}
  \fancyfoot[OR]{\thepage}
  \fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhf{}
    \fancyfoot[OR]{\parbox{10cm}{\footnotesize\textsf{\var@howtocite}}\hfill\thepage}
  }    
  \newcommand{\var@pageBreakForOdd}{\newpage}
  \newcommand{\var@pageBreakForEven}{\var@pageBreakForOdd}

}
  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% Index
%%
\RequirePackage{imakeidx}
\makeindex
\indexsetup{level=\chapter,toclevel=chapter} 
\indexprologue{\var@credit{\var@chapterimgcredit}\var@prepareactivitiessection{Index}}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Abbreviations
%%
\RequirePackage{nomencl}
\renewcommand{\thenomenclature}{
  \varchapter{\var@abbreviationsname}{}
  \nompreamble
  \list{}{
  \labelwidth\nom@tempdim
  \leftmargin\labelwidth
  \advance\leftmargin\labelsep
  \itemsep\nomitemsep
  \let\makelabel\nomlabel}}
\renewcommand{\endthenomenclature}{\endlist\nompostamble}
\makenomenclature

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Excursus-Box
%%
\RequirePackage{marginnote}
\let\marginpar\marginnote
\RequirePackage{tcolorbox}
\newenvironment{varexcursus}[1]{
  \begin{figure}
    \begin{tcolorbox}[colback=var@colour05!5!var@colour02,colframe=var@colour06!75!var@colour01,coltitle=var@colour02,fonttitle=\sffamily,title={\var@excursusname{}: #1}]
}{
    \end{tcolorbox}
  \end{figure}}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% remark environment
%%
\RequirePackage[framemethod=default]{mdframed} 

\newmdenv[skipabove=7pt,
          skipbelow=7pt,
          backgroundcolor=var@colour01!5,
          linecolor=var@colour04,
          innerleftmargin=5pt,
          innerrightmargin=5pt,
          innertopmargin=5pt,
          leftmargin=0cm,
          rightmargin=0cm,
          innerbottommargin=5pt]{var@remarkbox}
\newenvironment{varremark}{
  \par\vspace{1ex}%
  \begin{var@remarkbox}%
    \marginnote{
      \begin{tikzpicture}
        \node[draw=var@colour06,line width=1pt,circle,fill=var@colour06,font=\sffamily\bfseries,inner sep=3pt,outer sep=0pt] at (0pt,0pt){\textcolor{var@colour02}{\Huge{!}}};
      \end{tikzpicture}} 
    \advance\baselineskip -1pt
}{
  \end{var@remarkbox}%
  \vskip1ex
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Activity Environment ("Aktivitätsschritt") mit Verzeichnisliste in jedem Kapitel
%%
\newmdenv[skipabove=0pt,
          skipbelow=2ex,
          rightline=true,
          leftline=true,
          topline=true,
          bottomline=true,
          backgroundcolor=var@colour04!10,
          linecolor=var@colour04,
          innerleftmargin=5pt,
          innerrightmargin=5pt,
          innertopmargin=0pt,
          innerbottommargin=5pt,
          leftmargin=1em,
          rightmargin=1em,
          linewidth=0.4pt]{var@activitieslistbox}	

\newmdenv[skipabove=7pt,
          skipbelow=7pt,
          rightline=false,
          leftline=true,
          topline=false,
          bottomline=false,
          backgroundcolor=var@colour04!10,
          linecolor=var@colour04,
          innerleftmargin=5pt,
          innerrightmargin=5pt,
          innertopmargin=5pt,
          innerbottommargin=5pt,
          leftmargin=0cm,
          rightmargin=0cm,
          linewidth=4pt]{var@activitybox}	

\RequirePackage[section]{placeins}
\RequirePackage{etoc}
\RequirePackage{titlesec}

\etocarticlestyle 
\newcounter{var@activitycounter}[chapter]
\etocsetlevel{activity}{6}
\newenvironment{varactivity}[2][]{
  \refstepcounter{var@activitycounter}
  \par\medskip\begin{var@activitybox}
  \etoctoccontentsline{activity}{\thechapter{}.\thevar@activitycounter{} \@ifnotempty{#1}{#1: }#2}
  \noindent\sffamily\textbf{\var@activityname~\thechapter.\thevar@activitycounter{}\@ifnotempty{#1}{ (#1)}:}\\ 
  \textbf{\var@objectivename:} #2\\\rmfamily}{\end{var@activitybox}\medskip}
\newcommand{\var@lastchaptername}{}
\newcommand{\var@prepareactivitiessection}[1]{
  \renewcommand{\var@lastchaptername}{#1}
  \invisiblelocaltableofcontents\label{toc:{\var@lastchaptername}}
}
\newcommand{\varactivitiessection}{
  \clearpage
  \section*{\var@activitiesname}
  \begin{var@activitieslistbox}
    \etocsettocstyle{\subsubsection*{\textsf{\var@activitiesheadingname{}:}}}{}
    \etocsetlevel{activity}{1}
    \etocsetstyle{activity}%
    {\begin{small}\sffamily}%
      {}
      {\noindent\etocname\strut\leaders\etoctoclineleaders\hfill\etocpage\par}
    {\end{small}}
    \etocsetlevel{section}{2} 
    \setcounter{tocdepth}{1}%
    \tableofcontents\ref{toc:{\var@lastchaptername}}
  \end{var@activitieslistbox}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%%  lstlisting 
%% 
\renewcommand{\lstlistingname}{\var@listingname}
\lstdefinestyle{nonumbers}{numbers=none}
\lstset{
    backgroundcolor={\color{var@colour03}},
    frame=single,
    language=Java,
    numbers=left,
    stepnumber=1,
    numberfirstline=false,
    basicstyle={\footnotesize\ttfamily},
    breaklines=true,
    showstringspaces=false,
    tabsize=4
}
\DeclareCaptionFormat{listing}{\raggedright{}#1#2#3}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% commands for the document structure: varpart, varchapter
%%
\newcommand{\varpart}[3][]{%
  \renewcommand{\var@chapterimg}{}
  \renewcommand{\var@chapterimgcredit}{}
  \renewcommand{\var@howtocite}{}
  \ifthenelse{\equal{\thepage}{1}}{}{\var@pageBreakForOdd}
  \part{#2}
  \renewcommand{\var@chapterimg}{#3}
  \renewcommand{\var@chapterimgcredit}{#1}
}

\newcommand{\varchapter}[2]{%
  \renewcommand{\var@howtocite}{#2}
  \var@pageBreakForOdd
  \chapter{#1}\ifthenelse{\equal{\var@chapterimgcredit}{\var@null}}{}{\var@credit{\var@chapterimgcredit}}
  \var@prepareactivitiessection{chapt\thechapter}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% listing of credits/image licenses
%%
\newcounter{var@creditcounter}
\setcounter{var@creditcounter}{0}
\newcommand{\var@credit}[2][\var@null]{
  \refstepcounter{var@creditcounter}
  \label{credit:\thevar@creditcounter}
  \ifthenelse{\equal{\var@null}{#1}}{
    % without opt. parameter (label of figure)
    \write\@auxout{
      \noexpand\listgadd{\noexpand\var@creditslist}{#2}
    }
  }{% with opt. parameter (label of figure)
    \write\@auxout{
      \noexpand\listgadd{\noexpand\var@creditslist}{\var@figname{} \noexpand\ref{#1},~#2}
    }
  }
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% Hooks
%%
\AtBeginDocument{
  \def\labelitemiii{\(\circ\)}
  \setmainlanguage{\var@lang}
  \captionsetup[lstlisting]{format=listing}
  \ifthenelse{\not\boolean{var@draft}}{
    \pagenumbering{roman}
    \ifthenelse{\boolean{var@print}}{
      \setcounter{page}{5} % print (the first 4 pages provided by publisher)
    }{
      \setcounter{page}{6} % ebook (titlepage additionally included)
    }
    \ifthenelse{\equal{\var@null}{\var@prefacefile}}{
      % no preface
    }{% a prefacefile is provided
      \input{\var@prefacefile}
      \newpage
      \ifthenelse{\boolean{var@print}}{
        \checkoddpage\ifoddpage\else%
          ~\thispagestyle{empty}\newpage
        \fi%
      }{}
    }
    \tableofcontents% 
    \ifthenelse{\boolean{var@print}}{
      \checkoddpage\ifoddpage%
        \newpage~\thispagestyle{empty}
        \fi%
    }{}
    \newpage\pagenumbering{arabic}
  }{ % if draft no preface, toc etc.
  }
}

\AtEndDocument{
  \ifthenelse{\not\boolean{var@draft}}{
    \ifthenelse{\isundefined{\var@appendixcredits}}{
      \varpart{\var@appendixname}{\var@appendiximg}
    }{
      \varpart[\var@appendixcredits]{\var@appendixname}{\var@appendiximg}
    }
    \printindex
    \var@pageBreakForOdd
    \printnomenclature[2.4cm]
    \newcounter{var@irun}
    \setcounter{var@irun}{0}
    \ifthenelse{\isundefined\var@creditslist}{}{    
      \varchapter{\var@creditsname}{}
      \begin{description}
        \raggedright
        \footnotesize
        \sloppy
        \ifthenelse{\isundefined\var@covercredits}{
        }{
          \item[\var@covername{}:] \var@covercredits{}.
        }
        \renewcommand*{\do}[1]{
          \refstepcounter{var@irun}
          \item[\var@pagename{} \pageref{credit:\thevar@irun}:] #1.
        }
        \dolistloop{\var@creditslist}
      \end{description}
    }
    \ifthenelse{\equal{\var@null}{\var@lastpagefile}}{
      % no last page
    }{% the last page has to be an inner page (= even page number). a normale pagebreak is sufficient at e-books
      \var@pageBreakForEven
      \input{\var@lastpagefile}
    }
  }{% if draft no index, nomenclature, credits, lastpage etc.
  }
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% internationalization (hyphenation etc.)
%%
% from the ployglossia doc: "In general, it is advisable to activate the languages after all packages have been loaded."
\RequirePackage{polyglossia}
\setmainlanguage{\var@lang}
\renewcommand\contentsname{\var@contentsname} % not working from polyglossia?
