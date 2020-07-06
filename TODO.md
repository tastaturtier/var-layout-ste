# TODO
- Kommandos für floats (insb. figure wg. bildnachweisen)
- appendix chapter imgs leer lassen, falls varappendiximg \nicht angegeben => \varpart img optional, in varchapter prüfen

- README: Doku zu Ende
- zur Auslieferung: neutrale Grafiken
- log checken

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
