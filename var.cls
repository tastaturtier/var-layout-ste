% todo: Bildnachweis des Titels als Parameter
% todo: Bild und Bildquelle für Anhang-KapitelIllu
% andere Startseitenzahl bei ebook
% todo: lst-Konfiguration nach private.sty verschieben
% todo: widefigure etc. prüfen und ebook berücksichtigen
% todo: "Interface" definieren (CheckCommand's, Environments)
% todo: Sprachoption für class, \setXYZ statt \renewcommand für Texte => keyval's
% todo: Dateien für vorwort und letzte Seite der Klasse als Parameter übergeben
% todo: Anhang-Bild, part-Name, Bildnachweise, S. bei Bildnachweise als Parameter übergeben
% issue: Erklärung zu fehlenden ersten vier Seiten
% issue: Erklärung xetex + latex und fontspec
% feature: Makefile und Projekt-Layout zum Clonen

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{var}[2020/06/29 var book series LaTeX class]
\RequirePackage{ifthen}

\newboolean{print}
\setboolean{print}{true}
\DeclareOption{ebook}{\setboolean{print}{false}}
\DeclareOption*{\PackageWarning{var}{Unknown ‘\CurrentOption’}}
\ProcessOptions\relax
\ifthenelse{\boolean{print}}{
  \LoadClass[10pt,twoside]{book}
}{
  \LoadClass[10pt,oneside]{book}
}

\RequirePackage{polyglossia}
\setdefaultlanguage[babelshorthands=true]{german}
    

\newcommand{\exkursname}{Exkurs}
\newcommand{\activitiesname}{Praktikum}
\newcommand{\activityname}{Aktivitätsschritt}
\newcommand{\objectivename}{Ziel}
\newcommand{\activitiestocheading}{Aktivitätsschritte}
\newcommand{\varnomname}{Abkürzungsverzeichnis}
\newcommand{\varlistingname}{Listing}
\newcommand{\varbildnachweisename}{Bildnachweise}
\renewcommand{\contentsname}{Inhaltsverzeichnis}
\newcommand{\prefacefile}{foreword}
\newcommand{\lastpagefile}{lastpage}
\newcommand{\titelbildnachweis}{blubber}

\RequirePackage{xunicode}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% href, url, etc. mit Bookmark und URL-Umbrüche nicht nur bei _
%%
\PassOptionsToPackage{hyphens}{url}
\usepackage[linktoc=all,unicode=true,bookmarks=true,bookmarksnumbered=true,bookmarksopen=true,bookmarksopenlevel=0,breaklinks=true,pdfborder={0 0 0},backref=false,colorlinks=false]{hyperref}
\def\UrlBreaks{\do\/\do-\do\_} % bricht url's auch bei /, - und _

\RequirePackage{listings}

\RequirePackage{fix-cm}

\RequirePackage[export]{adjustbox}
\RequirePackage{fontspec,xltxtra,xunicode}
\defaultfontfeatures{Mapping=tex-text}
% portable Fonts (http://www.gust.org.pl/projects/e-foundry/tex-gyre/whole)
\setmainfont[Mapping=tex-text]{TeX Gyre Termes}
\setsansfont[Mapping=tex-text]{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}

% Bildunterschriften linksbündig hängend, etc.
\RequirePackage{ragged2e}
\RequirePackage[font=small,labelfont=bf,labelsep=colon,format=plain,justification=RaggedRight,singlelinecheck=false]{caption}

% Abschnittsüberschriften (unter chapter) alle linksbündig, Flattersatz:
\RequirePackage{sectsty}
\sectionfont{\raggedright}
\subsectionfont{\raggedright}
\subsubsectionfont{\raggedright}
\paragraphfont{\raggedright}

% Layout:
\RequirePackage[all]{nowidow} % keine Hurenkinder und Schusterjungen nach Möglichkeit
\raggedbottom % "Flattersatz" zum Seitenende
\sloppy
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


% Anschnitt von 3mm bei Print:
\ifthenelse{\boolean{print}}{
  \RequirePackage[cam,width=163truemm,height=233truemm,center]{crop}
}{}  

\RequirePackage{array} % benötigt?
\newcommand{\kapitelbild}{}
\newcommand{\kapitelbildsrc}{}

\setlength{\parskip}{0pt}
\setlength{\parindent}{0pt}
\RequirePackage[explicit]{titlesec}

\RequirePackage{color}
\RequirePackage{float}
\RequirePackage{graphicx}
\RequirePackage{multirow}

\RequirePackage{tikz}
\usetikzlibrary{shapes}
\usetikzlibrary{shadings}
\usetikzlibrary{positioning}
\usetikzlibrary{fit}
\usetikzlibrary{calc}
\usetikzlibrary{arrows}
\usetikzlibrary{arrows.meta}

\RequirePackage{setspace}
\onehalfspacing

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
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
  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kapitelüberschrift
% Bild ist bei Print \paperwidth + 3mm breit für 3mm Anschnitt (STE-Vorgabe)
% Bild ist bei E-Book \paperwidth breit
%
\titlespacing*{\chapter}{0pt}{*27.5}{*6}
\ifthenelse{\boolean{print}}{
  \titleformat{\chapter}[display]
    {\bfseries\Large}
    {}
    {-3ex}
    {\tikz[remember picture,overlay]\node[inner sep=0pt] at ($(current page.north) + (0,-3.5cm)$) {\includegraphics[width=\dimexpr(\paperwidth + 3mm)]{\kapitelbild}};
      \\\filcenter \Huge\sffamily #1
    }
    [\vspace{1ex}%
    \titlerule]%
}{
  \titleformat{\chapter}[display]
    {\bfseries\Large}
    {}
    {-3ex}
    {\tikz[remember picture,overlay]\node[inner sep=0pt] at ($(current page.north) + (0,-3.5cm)$) {\includegraphics[width=\paperwidth]{\kapitelbild}};
    \\\filcenter \Huge\sffamily #1
    }
    [\vspace{1ex}%
    \titlerule]%
}
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paginierung etc.

%\RequirePackage{eso-pic} % benötigt??
\RequirePackage{ifthen}
\RequirePackage{graphicx,calc}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\newcommand{\ccnote}{}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\fancyhf{} % clear the headers
\ifthenelse{\boolean{print}}{
  \fancyhead[EL,OR]{\sffamily\itshape
    \ifnum\value{chapter}>0 \thechapter. \fi
    \leftmark}
  \fancyfoot[EL,OR]{\thepage}
  \fancyfoot[ER]{}
  \fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhf{}
    \fancyfoot[EL]{\thepage\hfill\parbox{10cm}{\footnotesize\textsf{\ccnote}}}
    \fancyfoot[OR]{\parbox{10cm}{\footnotesize\textsf{\ccnote}}\hfill\thepage}
  }
  \newcommand{\pageBreakForOdd}{
    \newpage\checkoddpage\ifoddpage%
    \else%
      \thispagestyle{empty}\newpage
    \fi%
  }
  \newcommand{\pageBreakForEven}{
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
    \fancyfoot[OR]{\parbox{10cm}{\footnotesize\textsf{\ccnote}}\hfill\thepage}
  }    
  \newcommand{\pageBreakForOdd}{\newpage}
  \newcommand{\pageBreakForEven}{\pageBreakForOdd}

}
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Index
%%
\RequirePackage{imakeidx}
\makeindex
\indexsetup{level=\chapter,toclevel=chapter} 
\indexprologue{\prepareactivitiessection{Index}}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Abk.verz.
%%
\RequirePackage{nomencl}

\renewcommand{\thenomenclature}{
  \varchapter{\varnomname}{}
  \nompreamble
  \list{}{
  \labelwidth\nom@tempdim
  \leftmargin\labelwidth
  \advance\leftmargin\labelsep
  \itemsep\nomitemsep
  \let\makelabel\nomlabel}}
\renewcommand{\endthenomenclature}{\endlist\nompostamble}
\makenomenclature
%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Exkurs-Box
%%
\RequirePackage{marginnote}
\let\marginpar\marginnote
\RequirePackage{tcolorbox}
\RequirePackage{float}
\newenvironment{exkurs}[1]{
  \begin{figure}
    %\marginnote{
    %  \begin{tikzpicture}
    %    \node[draw=orange,line width=1pt,circle,fill=orange,font=\sffamily\bfseries,inner sep=2pt,outer sep=0pt] at (0pt,0pt){\textcolor{white}{\Large{Ex.}}};
    %  \end{tikzpicture}}
    \begin{tcolorbox}[colback=yellow!5!white,colframe=orange!75!black,coltitle=white,fonttitle=\sffamily,title={\exkursname{}: #1}]
}{
    \end{tcolorbox}
  \end{figure}}
%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Activity Environment ("Aktivitätsschritt") mit Verzeichnisliste in jedem Kapitel
%% \begin{activity}{Ziel}{optional in Klammern hinter Aktivitätsschritt x.xx}
%%
\RequirePackage[section]{placeins}
\RequirePackage{etoc}
\RequirePackage{titlesec}
\RequirePackage{amsgen} % (\@ifnotempty)
\etocarticlestyle % vielleicht auch nicht (Positionierung von Fließobjekten besser, dafür Chapterhead mit Grafik
\newcounter{activ}[chapter]
\etocsetlevel{activity}{6}
\makeatletter
\newenvironment{activity}[2]{
  \refstepcounter{activ}
  \etoctoccontentsline{activity}{\thechapter{}.\theactiv{} \@ifnotempty{#2}{#2: }#1}
  \par\medskip\begin{activitybox}\noindent\sffamily\textbf{\activityname~\thechapter.\theactiv{}\@ifnotempty{#2}{ (#2)}:}\\ 
  {\bfseries \objectivename:} #1\\\rmfamily}{\end{activitybox}\medskip}
\makeatother
\newcommand{\lastchaptername}{}
\newcommand{\prepareactivitiessection}[1]{
  \renewcommand{\lastchaptername}{#1}
  \invisiblelocaltableofcontents\label{toc:{\lastchaptername}}
}
\newcommand{\activitiessection}{
  \clearpage
  \section*{\activitiesname}
  \begin{activityListBox}
    %\etoctocstyle[section]{1}{}
    \etocsettocstyle{\subsubsection*{\textsf{\activitiestocheading{}:}}}{}
    \etocsetlevel{activity}{1}
    \etocsetstyle{activity}%
    {\begin{small}\sffamily}%
      {}
      {\noindent\etocname\strut\leaders\etoctoclineleaders\hfill\etocpage\par}
    {\end{small}}
    \etocsetlevel{section}{2} 
    \setcounter{tocdepth}{1}%
    \tableofcontents\ref{toc:{\lastchaptername}}
  \end{activityListBox}
}
%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
  

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Remark-Box
%% + activityListBox box
%%
\RequirePackage[framemethod=default]{mdframed} 
\definecolor{ocre}{RGB}{243,102,25} 	  
\newmdenv[skipabove=7pt,
          skipbelow=7pt,
          backgroundcolor=black!5,
          linecolor=ocre,
          innerleftmargin=5pt,
          innerrightmargin=5pt,
          innertopmargin=5pt,
          leftmargin=0cm,
          rightmargin=0cm,
          innerbottommargin=5pt]{remBox}
\newenvironment{remark}{
  \par\vspace{1ex}%
  \begin{remBox}%
    \marginnote{
      \begin{tikzpicture}
        \node[draw=orange,line width=1pt,circle,fill=orange,font=\sffamily\bfseries,inner sep=3pt,outer sep=0pt] at (0pt,0pt){\textcolor{white}{\Huge{!}}};
      \end{tikzpicture}} 
    \advance\baselineskip -1pt
}{
  \end{remBox}%
  \vskip1ex
}
\newmdenv[skipabove=0pt,
          skipbelow=2ex,
          rightline=true,
          leftline=true,
          topline=true,
          bottomline=true,
          backgroundcolor=ocre!10,
          linecolor=ocre,
          innerleftmargin=5pt,
          innerrightmargin=5pt,
          innertopmargin=0pt,
          innerbottommargin=5pt,
          leftmargin=1em,
          rightmargin=1em,
          linewidth=0.4pt]{activityListBox}	

\newmdenv[skipabove=7pt,
          skipbelow=7pt,
          rightline=false,
          leftline=true,
          topline=false,
          bottomline=false,
          backgroundcolor=ocre!10,
          linecolor=ocre,
          innerleftmargin=5pt,
          innerrightmargin=5pt,
          innertopmargin=5pt,
          innerbottommargin=5pt,
          leftmargin=0cm,
          rightmargin=0cm,
          linewidth=4pt]{activitybox}	
%%
%% %%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%
%% 
%%  lstlisting 
%% 
\renewcommand{\lstlistingname}{\varlistingname}
\lstdefinestyle{nonumbers}{numbers=none}
\definecolor{antiquewhite}{rgb}{0.98, 0.92, 0.84}
\lstset{
    backgroundcolor={\color{antiquewhite}},
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
\RequirePackage{caption}
\DeclareCaptionFormat{listing}{\raggedright{}#1#2#3}
%%
%% %%%%%%%%%%%%%%%%

\RequirePackage{etoolbox}

\newcommand{\varpart}[3]{%
  \renewcommand{\kapitelbild}{}
  \renewcommand{\kapitelbildsrc}{}
  \renewcommand{\ccnote}{}
  \ifthenelse{\equal{\thepage}{1}}{}{\pageBreakForOdd}
  \part{#1}
  \renewcommand{\kapitelbild}{#2}
  \renewcommand{\kapitelbildsrc}{#3}
  %\pageBreakForOdd 
}

\newcommand{\varchapter}[2]{%
  \renewcommand{\ccnote}{#2}
  \pageBreakForOdd
  \chapter{#1}\bildnachweis{\kapitelbildsrc} 
  \prepareactivitiessection{chapt\thechapter}
}


\newcounter{bildnachweisnummer}
\setcounter{bildnachweisnummer}{0}
\newcommand{\tempvarforparameter}{}
\makeatletter
\newcommand{\bildnachweis}[1]{
  \refstepcounter{bildnachweisnummer}
  \label{bildnachweis:\thebildnachweisnummer}
  \write\@auxout{\noexpand\listgadd{\noexpand\bildnachweisliste}{#1}}
}
\makeatother

\AtBeginDocument{
  \def\labelitemiii{\(\circ\)}
  \captionsetup[lstlisting]{format=listing}
  \pagenumbering{roman}
  \setcounter{page}{5}
  \input{\prefacefile}
  \newpage
  \ifthenelse{\boolean{print}}{
    \checkoddpage\ifoddpage\else%
      ~\thispagestyle{empty}\newpage
    \fi%
  }{}
  \tableofcontents% 
  \ifthenelse{\boolean{print}}{
    \checkoddpage\ifoddpage%
      \newpage~\thispagestyle{empty}
      \fi%
  }{}
  \newpage\pagenumbering{arabic}
}

\AtEndDocument{
  \varpart{Anhang}{img/headappendix.png}{ 
    Ausschnitt aus einem Foto von Florian Richter («florianric» bei Flickr), lizensiert unter CC BY 2.0 (\url{https://creativecommons.org/licenses/by/2.0/}). Bezug via Flickr (\url{https://www.flickr.com/photos/florianric/7263382550/}, letzter Zugriff: 14.10.2018)}
  \bildnachweis{\kapitelbildsrc}\printindex
  \pageBreakForOdd
  \printnomenclature[2.4cm]
  \varchapter{\varbildnachweisename}{}
  \newcounter{varirun}
  \setcounter{varirun}{0}
  \ifthenelse{\isundefined\bildnachweisliste}{}{    
    \begin{description}
      \raggedright
      \footnotesize
      \sloppy
      \renewcommand*{\do}[1]{
        \refstepcounter{varirun}
        \item[S.~\pageref{bildnachweis:\thevarirun}:] #1.
      }
      \dolistloop{\bildnachweisliste}
    \end{description}
  }
 % die letzte Seite muss bei Print innen (=gerade) sein. bei E-Book reicht ein normaler Umbruch
  \pageBreakForEven
  \input{\lastpagefile}
}