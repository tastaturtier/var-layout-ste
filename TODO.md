# TODO
- Kommandos für floats (insb. figure wg. bildnachweisen)

- -papersize=string als Parameter fpr xelatex?

- credits des Titels als mit \varcredits*{Titelseite}{...}, falls nicht angegeben, nicht im Bildquellenverzeichnis
- Bild und Bildquelle für Anhang-KapitelIllu als Parameter übergeben
- credits des Anhang part-Bilds als mit \varcredits*{appendix}{...}, falls nicht angegeben, nicht im Bildquellenverzeichnis

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
