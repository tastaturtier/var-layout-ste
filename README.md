# LaTeX layout class var-layout-ste
LaTeX2e (XeLaTeX) layout class for Steinbeis Edition series "[Verteilte Architekturen](https://verteiltearchitekturen.de/)" (var)

This layout class has been developed for my series of books called ["Verteilte Architekturen" (VAR)](https://verteiltearchitekturen.de/) published by [Steinbeis Edition](https://www.steinbeis-edition.de/) in Stuttgart, Germany.

The editorial office of the publisher helped a lot with layout, typography, and book styling during copy editing cycles of the first number of the series. The grown latex code was then revised and rewritten as a layout bundled together with a scaffolding project layout and build toolset. Starting with the second number of the book series XeLaTex, GUST's Tex Gyre fonts, and the var layout class are used for the production.

You may use and modify this class for your own book projects, see [LICENSE](LICENSE)

# TeX-Envionment
For use with XeLaTeX only (uses Unicode, [``fontspec``](https://www.ctan.org/pkg/fontspec) for font selection and [``polyglossia``](https://www.ctan.org/pkg/polyglossia) for internationalization).

Works with [MiKTeX](https://miktex.org/) (tested) and [TeX Live](http://tug.org/texlive/).

Dependencies: XeLaTeX (XeTeX 4.0 + LaTeX2e), [some CTAN-packages](dependencies.md), and fonts...

# Fonts
This layout class uses fonts from the [TeX Gyre (TG) Collection of Fonts](http://www.gust.org.pl/projects/e-foundry/tex-gyre). These fonts support e.g. ligatures, alternative glyphs, and swashes. They can be used as Unicode OpenType fonts through [``fontspec``](https://www.ctan.org/pkg/fontspec).

You need to install the following three fonts in order to use the ``var`` layout class with XeLaTeX:
- [TeX Gyre Termes](http://www.gust.org.pl/projects/e-foundry/tex-gyre/termes/index_html)
- [TeX Gyre Heros](http://www.gust.org.pl/projects/e-foundry/tex-gyre/heros/index_html)
- [TeX Gyre Cursor](http://www.gust.org.pl/projects/e-foundry/tex-gyre/cursor/index_html)

**Before installing a TeX Gyre font, all files from the corresponding Quasi font — if present — should be deleted (including LaTeX support) lest conflicts ensue (consult the relevant documentation).** You can use the PostScript-flavoured OpenType fonts (file extension ``.otf``): download and install depending on your OS.

The TeX Gyre fonts are being released under the [GUST Font License (GFL)](http://www.gust.org.pl/projects/e-foundry/licenses), which is a free license, legally equivalent to the [LaTeX Project Public License (LPPL)](http://www.latex-project.org/lppl/), version 1.3c or later. The freedoms granted by GFL include the free use of the fonts for whatever purpose you wish. You can also take the fonts and modify them for your own use or redistribution, but to avoid confusion in such a case you are requested to change the name(s) of the font(s) and comprising files—please follow the guidance of the [license](http://www.gust.org.pl/projects/e-foundry/licenses/index_html).

# Options
The ``var`` layout class can be controlled through the following parameters:
- ``lang=german/british`` (optional, default: ``german``) 
- ``ebook=true/false`` (optional, default: ``false``)
- ``prefacefile=texfile`` (optional)
- ``lastpagefile=texfile`` (optional)
- ``draft=true/false`` (optional, default: ``false``)

## Language Option: ``lang=xxx`` (``xxx`` one of ``german``, ``british``)
- ``xxx`` will be passed to the [``polyglossia``](https://www.ctan.org/pkg/polyglossia) packageas default/main language, thus in principle all [``polyglossia``](https://www.ctan.org/pkg/polyglossia) languages ca be used
- additionally some names specific for the ``var`` layout class will be activated. Currently there are only two sets of names: one for ``german`` and one for ``british`` new languages (that are supported by [``polyglossia``](https://www.ctan.org/pkg/polyglossia)) can be added as with ``british``:

```latex
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
        \def\var@contentsname{Table of Contents}
    }
```
## Option: ``draft=true``
- if ``draft=true`` then ``ebook=true`` is automatically set (ignoring any manual setting of the ``ebook`` option) 
- in draft mode preface, table of content, and all appendices (index, abbreviations, credits, and lastpage) are ommitted
- in draft mode chapter images are omitted
- the draft option is passed to the underlying book class resulting in markings of bad layouts

## Option E-Book: ``ebook=true``
- oneside instead of twoside
- margin always on the right
- no cropmarks
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

## pagination
- Page numbers start with v (roman 5) (print)/vi (roman 6) (ebook).
- The first 4/5 pages are provided by the publisher.
- pages without text are empty (print) resp. are not included (e-book) 

# Macros/Commands

Parameters in brackets (``[`` ``]``) are optional and can be omitted. All three forms in the following example are valid:

```latex
    \varpart[]{First Part}{headA.png}
    \varpart{second Part}{headB.png}
    \varpart[heading image by Picasso]{Third Part}{headC.png}
```

## ``\varcovercredits{``_credits_``}``
- optional
- before ``\begin{document}``
- at least once needed, but it is OK to have several (last one wins)

## ``\varappendiximg[``_credits_``]{``_file_``}``
- optional
- before ``\begin{document}``
- at least once needed, but it is OK to have several (last one wins)

## ``\varpart[``_credits_``]{``_heading_``}{``_file_``}``

## ``\varchapter{``_heading_``}{``_how_to_cite_``}``

## ``\varactivitiessection``
- 0 or 1 per ``\varchapter``
- ``activity``-environments (at least one) must follow

## ``\vargraphics[``_credits_``]{``_pos_``}{``_width_fraction_``}{``_graphics_file_``}{``_label_``}{``_caption_``}``
- arbitrary number of occurences
- between ``\begin{document}`` and ``\end{document}``

## ``\vargraphicsWide[``_credits_``]{``_pos_``}{``_graphics_file_``}{``_label_``}{``_caption_``}``
- arbitrary number of occurences
- between ``\begin{document}`` and ``\end{document}``

## ``\vargraphicsWideRotate[``_credits_``]{``_pos_``}{``_graphics_file_``}{``_label_``}{``_caption_``}``
- arbitrary number of occurences
- between ``\begin{document}`` and ``\end{document}``

# Environments
## ``\begin{varexcursus}{``_title_text_``}
- for additional topics
- will be formatted as floating box and placed somewhere near the point where it is created in the text
- content may consist of several text paragraphs, includegraphic, table etc. are allowed
- footnotes, floats, etc. are not allowed
- text (i.e. the box itself) must fit on one page
  
```latex
    \begin{varexcursus}{title text \dots}
        text 
    \end{varexcursus}
```

## ``\begin{varremark}``
- for important information
- will be formatted highlighted (with "!" at the outer margin)
- placed exactly where created
- content should be short but may consist of several paragraphs
- footnotes, floats, etc. allowed

```latex
    \begin{varremark}
        text
    \end{varremark}
```

## ``\begin{vartable}[``_pos_``]{``_tabular_spec_``}{``_label_``}{``_caption_text_``}``

```latex
    \begin{vartable}[h]{rll}{label}{text \dots}
        x   & y   & z\\
        abc & def & ghi\\
        x   & y   & z\\
    \end{vartable}
```

## ``\begin{varactivity}[``_condition_text_``]{``_objective_``}``
- must be after ``\varactivitiessection``
