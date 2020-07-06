# TODO
- appendix chapter imgs leer lassen, falls varappendiximg \nicht angegeben => \varpart img optional, in varchapter prüfen

- Kommandos für floats (insb. figure wg. bildnachweisen)
    \newcommand{\varfigure}
    \newcommand{\varfigure*}[4][]

    \newcommand{\var@figure}[]{

    }
    \begin{figure}[b]
        \begin{center}
            \includegraphics[width=1.0\textwidth]{file}
            \caption{\label{label}text}
        \end{center}
    \end{figure}

    \begin{adjustbox}{center,%
    max width={\textwidth},%
    max totalheight={\textheight}}
        \begin{tabular}{...}
            ...
        \end{tabular}
    \end{adjustbox}

- README: Doku zu Ende schreiben, I/F festlegen (Benennung der environments)
- zur Auslieferung: neutrale Grafiken
- log checken
