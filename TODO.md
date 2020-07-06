# TODO
- kein makeatletter/makeatother in var.cls
- Bild und Bildquelle für Anhang-KapitelIllu als Parameter übergeben
- Fehler: bildnachweis bei floats: label wird nicht in float gesetzt, sondern dort, wo es erzeugt wird

- Kommandos für floats (insb. figure wg. bildnachweisen)

- credits des Titels als mit \varcredits*{Titelseite}{...}, falls nicht angegeben, nicht im Bildquellenverzeichnis
- Anhang-Bild als Parameter
- credits des Anhang part-Bilds als mit \varcredits*{appendix}{...}, falls nicht angegeben, nicht im Bildquellenverzeichnis

- zur Auslieferung: neutrale Grafiken
- README: Doku zu Ende

\begin{figure}[b] oder nicht
    \begin{center}
        \includegraphics[width=1.0\textwidth]{VAR1-GoogleAppEngine-CloudGCPKonsole-GAE04b.png}
        \caption{\label{fig:GAE04b}...}
    \end{center}
\end{figure}

\begin{adjustbox}{center,%
  max width={\textwidth},%
  max totalheight={\textheight}}
    \begin{scriptsize}
        \begin{tabular}{...}
            ...
        \end{tabular}
    \end{scriptsize}
\end{adjustbox}
