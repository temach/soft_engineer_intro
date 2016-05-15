%% Copyright 2004 Vjacheslav A. Fyodorov

\NeedsTeXFormat{LaTeX2e} \ProvidesClass{twoeskd}[2004/10/12 a4 eskd
format (V.Fyodorov@tltsu.ru)]

\newif\ifeskd@twoside
\eskd@twosidefalse

\newif\ifeskd@title
\eskd@titlefalse

\newcommand{\eskdheight}{282}
\newcommand{\eskdencoding}{utf8}
\newcommand{\eskdyear}{\number\year}

\newcommand{\eskd@thin}{0.2}
\newcommand{\eskd@half@thin}{0.1}

\newcommand{\eskd@thick}{0.4}
\newcommand{\eskd@half@thick}{0.2}

\RequirePackage{keyval}

\define@key{eskd}{height}{\renewcommand{\eskdheight}{#1}}
\define@key{eskd}{encoding}{\renewcommand{\eskdencoding}{#1}}
\define@key{eskd}{year}{\renewcommand{\eskdyear}{#1}}

\DeclareOption{title}{\eskd@titletrue}

\DeclareOption{twoside}{%
  \eskd@twosidetrue
  \PassOptionsToClass{\CurrentOption}{article}
  \PassOptionsToPackage{twosideshift=0pt}{geometry}
  }

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption*{\edef\@tempa{%
    \noexpand\setkeys{eskd}{\CurrentOption}}\@tempa}

\ProcessOptions\relax

\LoadClass[a4paper]{article}

\RequirePackage[utf8,\eskdencoding]{inputenc}
\RequirePackage[russian]{babel}
\RequirePackage[T2A]{fontenc}
\RequirePackage{rotating}
\RequirePackage{lastpage}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}

\RequirePackage{pscyr}
\renewcommand{\rmdefault}{far}

\RequirePackage[left=24mm,right=11mm,top=16mm,footskip=25pt,headsep=10pt]{geometry}

\newcommand{\set@eskd@bottom}[1]{%
  \setlength{\textheight}{\eskdheight mm}
  \addtolength{\textheight}{-#1}
  \addtolength{\textheight}{5 mm}
  }


\newsavebox{\eskd@vertical}

\newcommand{\make@eskd@vertical}{%
        \unitlength 1mm %
    \savebox{\eskd@vertical}(0,0){%
      \begin{rotate}{90}
        \begin{picture}(0,0)(0,0)
          \linethickness{\eskd@thick mm}
          \put(0,0){\line(0,1){12}}
          \put(25,0){\line(0,1){12}}
          \put(60,0){\line(0,1){12}}
          \put(85,0){\line(0,1){12}}
          \put(110,0){\line(0,1){12}}
          \put(145,0){\line(0,1){12}}
          \put(0,12){\line(0,1){\eskd@half@thick}}
          \put(145,12){\line(0,1){\eskd@half@thick}}
          \put(0,7){\line(1,0){145}}
          \put(0,12){\line(1,0){145}}
          % artem added 1 line below
          \put(0,0){\line(1,0){145}}
          \put(12.5,9.5){\makebox(0,0){\itshape
              \textar{Инв. \textnumero \ подл.}}}
          \put(42.5,9.5){\makebox(0,0){\itshape
              \textar{Подп. и дата}}}
          \put(72.5,9.5){\makebox(0,0){\itshape
              \textar{Взам. инв. \textnumero}}}
          \put(97.5,9.5){\makebox(0,0){\itshape
              \textar{Инв. \textnumero \ дубл.}}}
          \put(127.5,9.5){\makebox(0,0){\itshape
              \textar{Подп. и дата}}}
                                %
        \end{picture}%
        \end{rotate}
      }}





\newsavebox{\eskd@horizontal}

\newcommand{\hh}{20} % convenience variable height
\newcommand{\hw}{160} % convenience variable width
% left and right borders
\newcommand{\myleft}{-10} % convenience variable width

\newcommand{\make@eskd@horizontal}{%
  \savebox{\eskd@horizontal}(0,0){%
    \unitlength 1mm %
    \begin{picture}(0,0)(0,0)
      \linethickness{\eskd@thick mm}
      % y axis
      \put(\myleft,0){\line(0,1){\hh}}
      \put(150,0){\line(0,1){\hh}}
      % x axis
      \put(\myleft,0){\line(1,0){\hw}}
      \put(\myleft,20){\line(1,0){\hw}}
      \linethickness{\eskd@thin mm}
      % y thin
      \put(30,0){\line(0,1){\hh}}
      \put(60,0){\line(0,1){\hh}}
      \put(90,0){\line(0,1){\hh}}
      \put(120,0){\line(0,1){\hh}}
      % x thin
      \put(\myleft,5){\line(1,0){\hw}}
      \put(\myleft,10){\line(1,0){\hw}}
      \put(\myleft,15){\line(1,0){\hw}}
      % labels, first row left -> right
      \put(4,12){\makebox(0,0)[l]{\textar{Изм.}}}
      \put(34,12){\makebox(0,0)[l]{\textar{Лист}}}
      \put(64,12){\makebox(0,0)[l]{\textar{\textnumero \ докум.}}}
      \put(94,12){\makebox(0,0)[l]{\textar{Подп.}}}
      \put(124,12){\makebox(0,0)[l]{\textar{Дата}}}
      % labels second row, left -> right
      \put(4,2){\makebox(0,0)[l]{\textar{Инв. \textnumero подл.}}}
      \put(34,2){\makebox(0,0)[l]{\textar{Подп. и дата}}}
      \put(64,2){\makebox(0,0)[l]{\textar{Взам. инв. \textnumero}}}
      \put(94,2){\makebox(0,0)[l]{\textar{Инв. \textnumero дyбл.}}}
      \put(124,2){\makebox(0,0)[l]{\textar{Подп. и дата}}}
    \end{picture}
    }}




\newcommand{\make@eskd@myhoriz@style}{%
  \newsavebox{\eskd@myhoriz@signature}
  \savebox{\eskd@myhoriz@signature}{{\inputencoding{\eskdencoding}\scriptsize{\eskd@typeid}}}
  \setlength{\headheight}{30.2pt}
  \fancypagestyle{myhorizontaltable}{%
  % \fancyhf{}
  \fancyhead[L]{%
    \unitlength 1mm
    \begin{picture}(0,0)(3,-6)
      \put(10,-\eskdheight){%
          \begin{picture}(0,0)
            \usebox{\eskd@horizontal}
            \put(28,8){\makebox(0,0)[r]{\usebox{\eskd@myhoriz@signature}}}
          \end{picture}%
      }
    \end{picture}
    }
  \fancyhead[C]{\large{\bfseries\thepage \\ \textbf{\eskd@typeid}}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  }
}


\newcommand{\make@eskd@myvert@style}{%
  \newsavebox{\eskd@myvert@gost}
  \newsavebox{\eskd@myvert@signature}
  \savebox{\eskd@myvert@signature}{{\inputencoding{\eskdencoding}\eskd@typeid}}
  \fancypagestyle{myverticaltable}{%
  % clear the old headers. We don't do this.
  % \fancyhf{}
  \fancyhead[L]{%
    \unitlength 1mm
    \begin{picture}(0,0)(3,-6)
      \put(0,-\eskdheight){\usebox{\eskd@vertical}}
      \put(0,-\eskdheight){
            \begin{rotate}{90}%
            % \put(20,8){\makebox(0,0){\usebox{\eskd@myvert@signature}}}
            \end{rotate}
      }
    \end{picture}
    }
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
}



% Will put your work type id ("RU.17701729.509000 ТЗ 01-1-ЛУ") into all tables
\newcommand{\eskd@typeid}{}
\newcommand{\workTypeId}[1]{\renewcommand{\eskd@typeid}{#1}}


\newcommand{\eskdListOfChanges}{\newpage
{\small\noindent
\begin{tabular}{|c|*{7}{p{1.5cm}|}c|c|}
  \multicolumn{10}{c}{\Large\bf Лист регистрации изменений}\\\hline
& \multicolumn{4}{c|}{Номера листов
(страниц)}&&&&&\\\cline{2-5}
Изм.&из\-ме\-нен\-ных&за\-ме\-нен\-ных&но\-вых&%
ан\-ну\-ли\-ро\-ван\-ных&
Всего листов (страниц)
в докум.&\textnumero\ докум.&Вхо\-дя\-щий \textnumero\
сопроводительного докум. и дата&Подпись&Дата\\\hline
\vbox{\vspace{\eskdheight mm}\vspace{-9cm}}&&&&&&&&&\\\hline
\end{tabular}
}
}


\AtBeginDocument{%
  % clear settings for header and footer
  \fancyhf{}

  \set@eskd@bottom{55mm}

  \make@eskd@vertical
  \make@eskd@horizontal

  \make@eskd@myvert@style
  \make@eskd@myhoriz@style

  \relax
}
