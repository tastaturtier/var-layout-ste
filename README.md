# LaTeX layout class var-layout-ste
LaTeX (XeLaTeX) layout class for Steinbeis Edition series "Verteilte Architekturen" (var)

# Options
- ``lang=german/british`` (optional, default: ``german``) 
- ``ebook=true/false`` (optional, default: ``false``)
- ``prefacefile=texfile``
- ``lastpagefile=texfile``

## Language Option: ``lang=xxx`` (``xxx`` one of ``german``, ``british``)
- ``xxx`` will be passed to the _polyglossia_ packageas default/main language, thus in principle all polyglossia languages ca be used
- additionally some names specific for the ``var`` layout class will be activated. Currently there are only two sets of names: one for ``german`` and one for ``british`` new languages (that are supported by polyglossia) can be added as with ``british``:

    \def\var@captionsbritish{%
        \def\var@excursusname{Excursus}%
        \def\var@activitiesname{Exercises}%
        \def\var@activityname{Activity Step}%
        \def\var@objectivename{Objective}%
        \def\var@activitiesheadingname{Activity Steps}%
        \def\var@abbreviationsname{Abbreviations}%
        \def\var@listingname{Listing}%
        \def\var@creditsname{Credits}%
        \def\var@contentsname{Table of Contents}
    }

## Option E-Book: ``ebook=true``
- oneside instead of twoside
- margin always on the right
- no side cuttings
- chapters, parts, etc. do not start on pages with odd numbers
- no need to fill up with empty pages to meet the pages with odd numbers

## Option Print: ``ebook=false`` (or leaving ebook option away)
- Vorwort (fancy, aber ohne Kapitelname im Header), römische Seitenzahlen, Beginn bei V
- auffüllen bis vor ungerade Seite mit leeren Seiten
- TOC (Standard-Kopf/Fußzeile), römische Seitenzahlen
- auffüllen bis vor ungerade Seite mit leeren Seiten
- Part (plain), arabische Seitenzahlen, Beginn bei 1
- auffüllen bis vor ungerade Seite mit leeren Seiten
- Kapitel (auf ungerader Seite beginnen), arabische Seitenzahlen

# Environments
## ``excursus``
- for additional topics
- will be formatted as floating box and placed somewhere near the point where it is created in the text
- content may consist of several text paragraphs, includegraphic, table etc. are allowed
- footnotes, floats, etc. are not allowed
- text (i.e. the box itself) must fit on one page
  
    \begin{excursus}{title info}
        text 
    \end{excursus}

## ``remark``
- for important information
- will be formatted highlighted (with "!" at the outer margin)
- placed exactly where created
- content should be short but may consist of several paragraphs
- footnotes, floats, etc. allowed

    \begin{remark}
        text
    \end{remark}

## ``activity``


# Macros/Commands

## ``varpart``

## ``varchapter``

## ``varactivitysection``


