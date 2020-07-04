# LaTeX Klasse var-layout-ste
LaTeX (XeLaTeX) layout class for Steinbeis Edition series "Verteilte Architekturen"

## Optionen

ebook=true
lang=german => polyglossia

\newcommand{\exkursname}{Exkurs}

\newcommand{\activitiesname}{Praktikum}
\newcommand{\activityname}{Aktivitätsschritt}
\newcommand{\objectivename}{Ziel}
\newcommand{\activitiestocheading}{Aktivitätsschritte}

\varbildnachweisename
\newcommand{\nomname}{Abkürzungsverzeichnis}
\renewcommand{\lstlistingname}{Listing}
\renewcommand{\contentsname}{Inhaltsverzeichnis}
\renewcommand{\indexname}{Stichwortverzeichnis}

prefacefile=vorwort
lastpagefile=VAR-Reihe


## Option ebook
Falls nicht ``ebook``:
- zweiseitig sonst einseitig
- Anschnitt 3mm
- Kapitelbeginn und Abschnittstitel immer auf ungeraden Seiten, ggf. wird mit leeren Seiten aufgefüllt


## bei Print (default):
- Vorwort (fancy, aber ohne Kapitelname im Header), römische Seitenzahlen, Beginn bei V
- auffüllen bis vor ungerade Seite mit leeren Seiten
- TOC (Standard-Kopf/Fußzeile), römische Seitenzahlen
- auffüllen bis vor ungerade Seite mit leeren Seiten
- Part (plain), arabische Seitenzahlen, Beginn bei 1
- auffüllen bis vor ungerade Seite mit leeren Seiten
- Kapitel (auf ungerader Seite beginnen), arabische Seitenzahlen
