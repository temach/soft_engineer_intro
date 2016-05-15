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

\RequirePackage[\eskdencoding]{inputenc}
\RequirePackage[russian]{babel}
\RequirePackage[T2A]{fontenc}
\RequirePackage{rotating}
\RequirePackage{lastpage}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}

\RequirePackage{pscyr}
\renewcommand{\rmdefault}{far}

\RequirePackage[left=24mm,right=11mm%
,top=10mm,nofoot,headsep=0pt]{geometry}

\newcommand{\set@eskd@bottom}[1]{%
  \setlength{\textheight}{\eskdheight mm}
  \addtolength{\textheight}{-#1}
  \addtolength{\textheight}{5 mm}
  }


\newsavebox{\eskd@vertical@frame}

\newcommand{\make@eskd@vertical@frame}{%
        \unitlength 1mm %
    \savebox{\eskd@vertical@frame}(0,0){%
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





\newsavebox{\eskd@common@left}

\newcommand{\hh}{20} % convenience variable height
\newcommand{\hw}{150} % convenience variable width

\newcommand{\make@eskd@common@left}{%
  \savebox{\eskd@common@left}(0,0){%
    \unitlength 1mm %
    \begin{picture}(0,0)(0,0)
      \linethickness{\eskd@thick mm}
      % y axis
      \put(0,0){\line(0,1){\hh}}
      \put(150,0){\line(0,1){\hh}}
      % x axis
      \put(0,0){\line(1,0){\hw}}
      \put(0,20){\line(1,0){\hw}}
      \linethickness{\eskd@thin mm}
      % y thin
      \put(30,0){\line(0,1){\hh}}
      \put(60,0){\line(0,1){\hh}}
      \put(90,0){\line(0,1){\hh}}
      \put(120,0){\line(0,1){\hh}}
      % x thin
      \put(0,5){\line(1,0){\hw}}
      \put(0,10){\line(1,0){\hw}}
      \put(0,15){\line(1,0){\hw}}
      % labels, first row left -> right
      \put(4,12){\makebox(0,0)[l]{\textar{Изм.}}}
      \put(34,12){\makebox(0,0)[l]{\textar{Лист}}}
      \put(64,12){\makebox(0,0)[l]{\textar{\textnumero докум.}}}
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
  \newsavebox{\eskd@myhoriz@gost}
  % \savebox{\eskd@myhoriz@gost}{\scriptsize\textar{ГОСТ 2.104-68
  %     Форма 2\ifeskd@twoside б\else a\fi}}
  \newsavebox{\eskd@myhoriz@signature}
  \savebox{\eskd@myhoriz@signature}{{\inputencoding{\eskdencoding}\eskd@ii}}
  \setlength{\headheight}{25.2pt}
  \fancypagestyle{myhorizontaltable}{%
  % \fancyhf{}
  \fancyhead[L]{%
    \unitlength 1mm
    \begin{picture}(0,0)(3,-6)
      % \put(0,0){\usebox{\eskd@border}}
      % \put(0,-\eskdheight){\usebox{\eskd@vertical@frame}}
      \put(10,-\eskdheight){\usebox{\eskd@common@left}}
      % \put(65,-\eskdheight){\usebox{\eskd@common@hole}}
      % \put(175,-\eskdheight){\usebox{\eskd@common@page}}
      % \put(0,-\eskdheight){\begin{picture}(0,0)
      %     \put(180,4){\makebox(0,0){\large\textbf{\textar{\thepage}}}}
      %     \put(120,7.5){\makebox(0,0){\usebox{\eskd@common@signature}}}
      %     \put(180,11.5){\makebox(0,0){\usebox{\eskd@common@list}}}
      %     \put(185,\ifeskd@twoside-1\else0\fi){\makebox(0,0)[rt]{%
      %         \usebox{\eskd@common@gost}}}
      %   \end{picture}}
    \end{picture}
    }
    \fancyhead[C]{\large{\bfseries\thepage \\ \textbf{RU.17701729.509000 T3 01-1}}}
  % \fancyhead[R]{\fancyplain{}{\bfseries\thepage}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  }
}


\newcommand{\make@eskd@myvert@style}{%
  \newsavebox{\eskd@myvert@gost}
  % \savebox{\eskd@myvert@gost}{\scriptsize\textar{ГОСТ 2.104-68
  %     Форма 2\ifeskd@twoside б\else a\fi}}
  \newsavebox{\eskd@myvert@signature}
  \savebox{\eskd@myvert@signature}{{\inputencoding{\eskdencoding}\eskd@ii}}
  \fancypagestyle{myverticaltable}{%
  % \fancyhf{}
  \fancyhead[L]{%
    \unitlength 1mm
    \begin{picture}(0,0)(3,-6)
      % \put(0,0){\usebox{\eskd@border}}
      \put(0,-\eskdheight){\usebox{\eskd@vertical@frame}}
      % \put(0,-\eskdheight){\usebox{\eskd@common@left}}
      % \put(65,-\eskdheight){\usebox{\eskd@common@hole}}
      % \put(175,-\eskdheight){\usebox{\eskd@common@page}}
      % \put(0,-\eskdheight){\begin{picture}(0,0)
      %     \put(180,4){\makebox(0,0){\large\textbf{\textar{\thepage}}}}
      %     \put(120,7.5){\makebox(0,0){\usebox{\eskd@common@signature}}}
      %     \put(180,11.5){\makebox(0,0){\usebox{\eskd@common@list}}}
      %     \put(185,\ifeskd@twoside-1\else0\fi){\makebox(0,0)[rt]{%
      %         \usebox{\eskd@common@gost}}}
      %   \end{picture}}
    \end{picture}
    }
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
}






\newcommand{\eskd@i}{}
\newcommand{\docName}[1]{\renewcommand{\eskd@i}{#1}}
\newcommand{\fI}{\docName}

\newcommand{\eskd@ii}{}
\newcommand{\docSignature}[1]{\renewcommand{\eskd@ii}{#1}}
\newcommand{\fII}[1]{\renewcommand{\eskd@ii}{#1}}

\newcommand{\eskd@ix}{}
\newcommand{\fIX}[1]{\renewcommand{\eskd@ix}{#1}}
\newcommand{\docLabel}[1]{\renewcommand{\eskd@ix}{#1}}

\newcommand{\eskd@x}{}
\newcommand{\middleLabel}[1]{\renewcommand{\eskd@x}{#1}}
\newcommand{\fX}[1]{\renewcommand{\eskd@x}{#1}}

\newcommand{\eskd@xiI}{}
\newcommand{\docAuthor}[1]{\renewcommand{\eskd@xiI}{#1}}
\newcommand{\fXIi}[1]{\renewcommand{\eskd@xiI}{#1}}

\newcommand{\eskd@xiII}{}
\newcommand{\docChecker}[1]{\renewcommand{\eskd@xiII}{#1}}
\newcommand{\fXIii}[1]{\renewcommand{\eskd@xiII}{#1}}

\newcommand{\eskd@xiIII}{}
\newcommand{\middleName}[1]{\renewcommand{\eskd@xiIII}{#1}}
\newcommand{\fXIiii}[1]{\renewcommand{\eskd@xiIII}{#1}}

\newcommand{\eskd@xiIV}{}
\newcommand{\normController}[1]{\renewcommand{\eskd@xiIV}{#1}}
\newcommand{\fXIiv}[1]{\renewcommand{\eskd@xiIV}{#1}}

\newcommand{\eskd@xiV}{}
\newcommand{\approvedBy}[1]{\renewcommand{\eskd@xiV}{#1}}
\newcommand{\fXIv}[1]{\renewcommand{\eskd@xiV}{#1}}


\newcommand{\eskd@title@i}{}
\newcommand{\titleTop}[1]{\renewcommand{\eskd@title@i}{#1}}
\newcommand{\tfI}[1]{\renewcommand{\eskd@title@i}{#1}}

\newif\ifeskd@title@appr \eskd@title@apprfalse
\newif\ifeskd@title@agr  \eskd@title@agrfalse

\newcommand{\eskd@des@list}{}

\newcommand{\eskd@title@iii@right@position}{}
\newcommand{\eskd@title@iii@right@name}{}
\newcommand{\titleApprovedBy}[2]{%
  \renewcommand{\eskd@title@iii@right@position}{#1}
  \renewcommand{\eskd@title@iii@right@name}{#2}
  \eskd@title@apprtrue
  }

\newcommand{\eskd@title@iii@left@position}{}
\newcommand{\eskd@title@iii@left@name}{}
\xdef\eskd@agr@list{}
\newcommand{\titleAgreedBy}[2]{%
  \ifeskd@title@agr
  \xdef\eskd@agr@list{\eskd@agr@list#1\par\vrule
    depth 0.8pt height -0.4pt width31mm~#2\par
    ''\vrule depth 0.8pt height -0.4pt width8mm''\vrule
    depth 0.8pt height -0.4pt width20mm\ \eskdyear\ \cyrg\par\vskip 3mm}
  \else
  \renewcommand{\eskd@title@iii@left@position}{#1}
  \renewcommand{\eskd@title@iii@left@name}{#2}
  \eskd@title@agrtrue
  \fi
  }

\xdef\eskd@author@list{}
\newcommand{\titleDesignedBy}[2]{%
  \xdef\eskd@author@list{\eskd@author@list#1\par\vrule
    depth 0.8pt height -0.4pt width31mm~#2\par
    ''\vrule depth 0.8pt height -0.4pt width8mm''\vrule
    depth 0.8pt height -0.4pt width20mm\ \eskdyear\ \cyrg\par\vskip 3mm}
  }

\newcommand{\tfIII}{\hyphenpenalty=10000 %
  \begin{tabular}{@{\hspace{5mm}}p{80mm}@{\hspace{10mm}}p{80mm}}%
    \ifeskd@title@agr  \hspace{15mm}\usebox{\eskd@agr}\fi &%
    \ifeskd@title@appr \hspace{15mm}\usebox{\eskd@appr}\fi \\[3mm]
    \ifeskd@title@agr{\raggedright \eskd@title@iii@left@position}\fi &%
    \ifeskd@title@appr{\raggedright
      \eskd@title@iii@right@position}\fi\\[3mm]
    \ifeskd@title@agr \rule[-1mm]{31mm}{0.4pt}~%
    \eskd@title@iii@left@name \fi &%
    \ifeskd@title@appr \rule[-1mm]{31mm}{0.4pt}~%
    \eskd@title@iii@right@name \fi\\[3mm]
    \ifeskd@title@agr ''\rule[-1mm]{8mm}{0.4pt}''\rule[-1mm]{20mm}{0.4pt}
    \eskdyear\ \cyrg\fi &%
    \ifeskd@title@appr ''\rule[-1mm]{8mm}{0.4pt}''\rule[-1mm]{20mm}{0.4pt}
    \eskdyear\ \cyrg\fi
  \end{tabular}
  }

\newcommand{\eskd@title@iv}{\eskd@i}
\newcommand{\titleName}[1]{\renewcommand{\eskd@title@iv}{#1}}
\newcommand{\tfIV}[1]{\renewcommand{\eskd@title@iv}{#1}}

\newcommand{\eskd@title@vi}{\eskd@ii}
\newcommand{\titleSignature}[1]{\renewcommand{\eskd@title@vi}{#1}}
\newcommand{\tfVI}[1]{\renewcommand{\eskd@title@vi}{#1}}



\newcommand{\eskd@title@bottom}{\eskdyear}
\newcommand{\titleBottom}[1]{\renewcommand{\eskd@title@bottom}{#1}}




\newcommand{\eskdListOfChanges}{\newpage
{\small\noindent
\begin{tabular}{|c|*{7}{p{1.5cm}|}c|c|}
  \multicolumn{10}{c}{\Large\bf Лист регистрации изменений}\\\hline
& \multicolumn{4}{c|}{Номера листов
(страниц)}&&&&&\\\cline{2-5}
Изм.&из\-ме\-нен\-ных&за\-ме\-нен\-ных&но\-вых&%
ан\-ну\-ли\-ро\-ван\-ных&
Всего листов (страниц)
в докум.&\No\ докум.&Вхо\-дя\-щий \No\
сопроводительного докум. и дата&Подпись&Дата\\\hline
\vbox{\vspace{\eskdheight mm}\vspace{-6cm}}&&&&&&&&&\\\hline
\end{tabular}
}
}


\AtBeginDocument{%
  \set@eskd@bottom{55mm}

  \make@eskd@vertical@frame
  \make@eskd@common@left

  \make@eskd@myvert@style
  \make@eskd@myhoriz@style

  \relax
}
