% todo: "Interface" definieren (CheckCommand's, Environments)
% todo: falls lastpagefile/prefacefile nicht angegeben werden, weglassen
% alle internen Variablen und Funktionen mit @ zu lokalen Namen machen
% todo: Bildnachweis des Titels als Parameter
% todo: Bild und Bildquelle für Anhang-KapitelIllu als Parameter übergeben
% andere Startseitenzahl bei ebook
% todo: lst-Konfiguration nach private.sty verschieben
% todo: Anhang-Bild, part-Name, Bildnachweise, S. bei Bildnachweise als Parameter übergeben
% issue: Erklärung zu fehlenden ersten vier Seiten
% issue: Erklärung xetex + latex und fontspec
% modus draft (draft für book + ebook + keine Kapitelgrafik), draft.tex automatisch aus Makefile generieren (bindet nur chapter ein)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{var}[2020/07/05 var book series LaTeX class]
\makeatletter
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{kvoptions}
\DeclareBoolOption[false]{ebook}
\DeclareBoolOption[false]{draft}
\DeclareStringOption[german]{lang}
\DeclareStringOption{prefacefile}
\DeclareStringOption{lastpagefile}
\newcommand{\var@titlecredit}{blubber} %TODO
\ProcessKeyvalOptions*
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
\csname var@captions\var@lang \endcsname

% "print" complementary to "ebook"
\newboolean{var@print} 
\ifthenelse{\boolean{var@ebook}}{
  \setboolean{var@print}{false}
}{
  \setboolean{var@print}{true}
}

\ifthenelse{\boolean{var@print}}{
  \LoadClass[10pt,twoside]{book}
}{
  \LoadClass[10pt,oneside]{book}
}

\RequirePackage{xunicode}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% href, url, etc. with bookmark and URL-hyphenation/breaking not only at _
%%
\PassOptionsToPackage{hyphens}{url}
\usepackage[linktoc=all,unicode=true,bookmarks=true,bookmarksnumbered=true,bookmarksopen=true,bookmarksopenlevel=0,breaklinks=true,pdfborder={0 0 0},backref=false,colorlinks=false]{hyperref}
\def\UrlBreaks{\do\/\do-\do\_} % breaks URLs also at /, - and _

\RequirePackage{listings}

\RequirePackage{fix-cm}

\RequirePackage[export]{adjustbox}
\RequirePackage{fontspec,xltxtra,xunicode}
\defaultfontfeatures{Mapping=tex-text}
% portable Fonts (http://www.gust.org.pl/projects/e-foundry/tex-gyre/whole)
\setmainfont[Mapping=tex-text]{TeX Gyre Termes}
\setsansfont[Mapping=tex-text]{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}

% captions right ragged, hanging, etc.
\RequirePackage{ragged2e}
\RequirePackage[font=small,labelfont=bf,labelsep=colon,format=plain,justification=RaggedRight,singlelinecheck=false]{caption}

% section headings (below chapter) all right ragged:
\RequirePackage{sectsty}
\sectionfont{\raggedright}
\subsectionfont{\raggedright}
\subsubsectionfont{\raggedright}
\paragraphfont{\raggedright}

% Layout:
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

% Anschnitt von 3mm bei Print:
\ifthenelse{\boolean{var@print}}{
  \RequirePackage[cam,width=163truemm,height=233truemm,center]{crop}
}{}  

\newcommand{\kapitelbild}{}
\newcommand{\kapitelbildsrc}{}

\setlength{\parskip}{0pt}
\setlength{\parindent}{0pt}
\RequirePackage[explicit]{titlesec}

\RequirePackage{color}
\RequirePackage{float}
\RequirePackage{graphicx}

\RequirePackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{calc}

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
% chapter headings
% chapter picture width at print \paperwidth + 3mm for 3mm side cutting (STE-Vorgabe)
% chapter picture width at ebook \paperwidth for 3mm side cutting (STE-Vorgabe)
%
\titlespacing*{\chapter}{0pt}{*27.5}{*6}
\ifthenelse{\boolean{var@print}}{
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
% foliation, page numbering etc.

\RequirePackage{calc}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\newcommand{\ccnote}{}
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
\indexprologue{\bildnachweis{\kapitelbildsrc}\prepareactivitiessection{Index}}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Abk.verz.
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
    \begin{tcolorbox}[colback=yellow!5!white,colframe=orange!75!black,coltitle=white,fonttitle=\sffamily,title={\var@excursusname{}: #1}]
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

\newenvironment{activity}[2]{
  \refstepcounter{activ}
  \etoctoccontentsline{activity}{\thechapter{}.\theactiv{} \@ifnotempty{#2}{#2: }#1}
  \par\medskip\begin{activitybox}\noindent\sffamily\textbf{\var@activityname~\thechapter.\theactiv{}\@ifnotempty{#2}{ (#2)}:}\\ 
  {\bfseries \var@objectivename:} #1\\\rmfamily}{\end{activitybox}\medskip}
\newcommand{\lastchaptername}{}
\newcommand{\prepareactivitiessection}[1]{
  \renewcommand{\lastchaptername}{#1}
  \invisiblelocaltableofcontents\label{toc:{\lastchaptername}}
}
\newcommand{\activitiessection}{
  \clearpage
  \section*{\var@activitiesname}
  \begin{activityListBox}
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
\renewcommand{\lstlistingname}{\var@listingname}
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
\newcommand{\bildnachweis}[1]{
  \refstepcounter{bildnachweisnummer}
  \label{bildnachweis:\thebildnachweisnummer}
  \write\@auxout{\noexpand\listgadd{\noexpand\bildnachweisliste}{#1}}
}

\AtBeginDocument{
  \def\labelitemiii{\(\circ\)}
  \setmainlanguage{\var@lang}
  \captionsetup[lstlisting]{format=listing}
  \pagenumbering{roman}
  \setcounter{page}{5}
  \input{\var@prefacefile}
  \newpage
  \ifthenelse{\boolean{var@print}}{
    \checkoddpage\ifoddpage\else%
      ~\thispagestyle{empty}\newpage
    \fi%
  }{}
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
  \pageBreakForOdd
  \printnomenclature[2.4cm]
  \varchapter{\var@creditsname}{}
  \newcounter{var@irun}
  \setcounter{var@irun}{0}
  \ifthenelse{\isundefined\bildnachweisliste}{}{    
    \begin{description}
      \raggedright
      \footnotesize
      \sloppy
      \renewcommand*{\do}[1]{
        \refstepcounter{var@irun}
        \item[S.~\pageref{bildnachweis:\thevar@irun}:] #1.
      }
      \dolistloop{\bildnachweisliste}
    \end{description}
  }
 % die letzte Seite muss bei Print innen (=gerade) sein. bei E-Book reicht ein normaler Umbruch
  \pageBreakForEven
  \input{\var@lastpagefile}
}

% from the ployglossia doc: "In general, it is advisable to activate the languages after all packages have been loaded."
\RequirePackage{polyglossia}
\setmainlanguage{\var@lang}
\renewcommand\contentsname{\var@contentsname}

\makeatother