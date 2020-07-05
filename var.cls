%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% var class for xelatex2e
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{var}[2020/07/05 VAR book series LaTeX class]
%% 
%% author: Sandro Leuchter (sandro.leuchter@dama.io), github.com: tastaturtier 
%%
%% This layout class has been developed for my series of books called "Verteilte Architekturen" (VAR)
%% published by Steinbeis Edition in Stuttgart, Germany (https://verteiltearchitekturen.de/)
%%
%% The editorial office of the publisher helped a lot with layout, typography, and book styling
%% during copy editing cycles of the first number of the series. The grown latex code was then 
%% revised and rewritten as a layout bundled together with a scaffolding project layout and build 
%% toolset. Starting with the second number of the book series XeLaTex, GUST's Tex Gyre fonts, and
%% the var layout class are used for the production.
%%  
%% You may use and modify this class for your own book projects as long as it is mentioned: 
%% "Typesetting with XeLaTeX and VAR layout class (github.io/tastaturtier/var-layout-ste) using 
%% the Tex Gyre fonts Termes, Heros and Cursor of GUST."
%% "Textsatz mit XeLaTeX und VAR Layout Klasse (github.io/tastaturtier/var-layout-ste) unter 
%% Verwendung der Tex Gyre Schriften Termes, Heros und Cursor der GUST."
%% 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter

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
  \def\var@contentsname{Table of Contents}% not properly working with polyglossia?
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% handling of options
%%
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{kvoptions}
\DeclareBoolOption[false]{ebook}
\DeclareBoolOption[false]{draft}
\DeclareStringOption[german]{lang}
\newcommand{\var@null}{}
\DeclareStringOption[\var@null]{prefacefile}
\DeclareStringOption[\var@null]{lastpagefile}
\newcommand{\var@titlecredit}{blubber} %TODO
\ProcessKeyvalOptions*
\csname var@captions\var@lang \endcsname

% from the amsgen package (not clear if available outside miktex)
% http://www.texdoc.net/texmf-dist/doc/latex/amsmath/amsgen.pdf
\long\def\@ifempty#1{\@xifempty#1@@..\@nil}
\long\def\@xifempty#1#2@#3#4#5\@nil{%
  \ifx#3#4\expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi}
\long\def\@ifnotempty#1{\@ifempty{#1}{}}

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
\ifthenelse{\boolean{var@print}}{
  \LoadClass[10pt,twoside]{book}
}{
  \LoadClass[10pt,oneside]{book}
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
%% überbreite Grafiken; sollen den jeweiligen Marginalienrand ausnutzen
%%
\RequirePackage{ifoddpage}
\newcommand{\varwidefigure}[3]{
  \begin{figure}
  \checkoddpage
  \ifoddpage
    #1
  \else
    \hspace{-15mm}#1
  \fi 
  \caption{\label{#2}#3}
  \end{figure}
  \edef\marginnotetextwidth{\the\textwidth}}
\newcommand{\varwidegraphics}[3]{
  \begin{figure}
  \checkoddpage
  \ifoddpage
    \includegraphics[width=\dimexpr(\textwidth + 15mm)]{#1}
  \else
    \hspace{-15mm}\includegraphics[width=\dimexpr(\textwidth + 15mm)]{#1}
  \fi 
  \caption{\label{#2}#3}
  \end{figure}
  \edef\marginnotetextwidth{\the\textwidth}}
\newcommand{\varwidegraphicsRotate}[3]{
  \begin{figure}
  \checkoddpage
  \ifoddpage
    \includegraphics[height=\dimexpr(\textwidth + 15mm),angle=90]{#1}
  \else
    \hspace{-15mm}\includegraphics[height=\dimexpr(\textwidth + 15mm),angle=90]{#1}
  \fi 
  \caption{\label{#2}#3}
  \end{figure}
  \edef\marginnotetextwidth{\the\textwidth}}
  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% chapter headings
%% chapter picture width at print \paperwidth + 3mm for 3mm cropmarks (STE-Vorgabe)
%% chapter picture width at ebook \paperwidth for 3mm cropmarks (STE-Vorgabe)
%%
\titlespacing*{\chapter}{0pt}{*27.5}{*6}
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
\indexprologue{\varcredit{\var@chapterimgcredit}\var@prepareactivitiessection{Index}}

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
\newenvironment{excursus}[1]{
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
\newenvironment{remark}{
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
%% \begin{activity}{Ziel}{optional in Klammern hinter Aktivitätsschritt x.xx}
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
\newenvironment{activity}[2]{
  \refstepcounter{var@activitycounter}
  \etoctoccontentsline{activity}{\thechapter{}.\thevar@activitycounter{} \@ifnotempty{#2}{#2: }#1}
  \par\medskip\begin{var@activitybox}\noindent\sffamily\textbf{\var@activityname~\thechapter.\thevar@activitycounter{}\@ifnotempty{#2}{ (#2)}:}\\ 
  {\bfseries \var@objectivename:} #1\\\rmfamily}{\end{var@activitybox}\medskip}
\newcommand{\var@lastchaptername}{}
\newcommand{\var@prepareactivitiessection}[1]{
  \renewcommand{\var@lastchaptername}{#1}
  \invisiblelocaltableofcontents\label{toc:{\var@lastchaptername}}
}
\newcommand{\varactivitiessection}{
  \clearpage
  \section*{\var@activitiesname}
  \begin{var@activitieslistbox}
    %\etoctocstyle[section]{1}{}
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
\newcommand{\varpart}[3]{%
  \renewcommand{\var@chapterimg}{}
  \renewcommand{\var@chapterimgcredit}{}
  \renewcommand{\var@howtocite}{}
  \ifthenelse{\equal{\thepage}{1}}{}{\var@pageBreakForOdd}
  \part{#1}
  \renewcommand{\var@chapterimg}{#2}
  \renewcommand{\var@chapterimgcredit}{#3}
}

\newcommand{\varchapter}[2]{%
  \renewcommand{\var@howtocite}{#2}
  \var@pageBreakForOdd
  \chapter{#1}\varcredit{\var@chapterimgcredit} 
  \var@prepareactivitiessection{chapt\thechapter}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% listing of credits/image licenses
%%
\newcounter{var@creditcounter}
\setcounter{var@creditcounter}{0}
\newcommand{\varcredit}[1]{
  \refstepcounter{var@creditcounter}
  \label{credit:\thevar@creditcounter}
  \write\@auxout{\noexpand\listgadd{\noexpand\var@creditslist}{#1}}
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% Hooks
%%
\AtBeginDocument{
  \def\labelitemiii{\(\circ\)}
  \setmainlanguage{\var@lang}
  \captionsetup[lstlisting]{format=listing}
  \pagenumbering{roman}
  \setcounter{page}{5}
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
}

\AtEndDocument{
  \varpart{Anhang}{img/headappendix.png}{ 
    Ausschnitt aus einem Foto von Florian Richter («florianric» bei Flickr), lizensiert unter CC BY 2.0 (\url{https://creativecommons.org/licenses/by/2.0/}). Bezug via Flickr (\url{https://www.flickr.com/photos/florianric/7263382550/}, letzter Zugriff: 14.10.2018)}
  \printindex
  \var@pageBreakForOdd
  \printnomenclature[2.4cm]
  \varchapter{\var@creditsname}{}
  \newcounter{var@irun}
  \setcounter{var@irun}{0}
  \ifthenelse{\isundefined\var@creditslist}{}{    
    \begin{description}
      \raggedright
      \footnotesize
      \sloppy
      \renewcommand*{\do}[1]{
        \refstepcounter{var@irun}
        \item[S.~\pageref{credit:\thevar@irun}:] #1.
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
}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%% internationalization (hyphenation etc.)
%%
% from the ployglossia doc: "In general, it is advisable to activate the languages after all packages have been loaded."
\RequirePackage{polyglossia}
\setmainlanguage{\var@lang}
\renewcommand\contentsname{\var@contentsname} % not working from polyglossia?

\makeatother