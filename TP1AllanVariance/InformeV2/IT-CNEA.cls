% IT-CNEA.cls
%
% Agosto 2016  J.I. Marquez Damian marquezj (at) cab.cnea.gov.ar
% Marzo 2015   Ezequiel O. Fogliatto fogliatto (at) cab.cnea.gov.ar
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%       CLASE PAR LA GENERACI\'ON DE INFORMES T\'ECNICOS DE CNEA, BASADA EN
%       CLASE PAR LA GENERACI\'ON DE INFORMES T\'ECNICOS DE MECOM
%
%
%
%
%
%
% --- Estructura de la clase: secci\'on de identificaci\'on
% ---
\ProvidesClass{IT-CNEA}[2016/08/19 Informes Tecnicos CNEA]
\NeedsTeXFormat{LaTeX2e}


% --- Estructura de la clase: declaraci\'on de opciones
% ---
% Esta clase extiende la clase article
% Lee todas las opciones de documentclass, y las pasa a article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}


% --- Estructura de la clase: ejecuci\'on de opciones
% ---
\ProcessOptions\relax

% Carga de clase base
\LoadClass{article}




% Carga de paquetes adicionales
\RequirePackage[T1]{fontenc}          % Usar T1 enconding
\RequirePackage{fancyhdr}             % Encabezados y pies de p\'agina
\RequirePackage{cals}                 % Generaci\'on de tablas con tama\~nos absolutos
\RequirePackage{lastpage}             % Determina la cantidad total de p\'aginas
\RequirePackage{graphicx}             % Manejo de gr\'aficos
\RequirePackage{setspace}             % Interlineado en partes espec\'ificas
\RequirePackage{indentfirst}          % Genera sangr\'ia para el primer p\'arrafo despu\'es del t\'itulo de secci\'on
\RequirePackage{amsmath,amsfonts}     % S\'imbolos matem\'aticos
\RequirePackage{fixltx2e}             % Multicolumn
\RequirePackage{placeins}             % Fuerza el salto de p\'agina despu\'es de figuras con \FloatBarrier
\RequirePackage[intoc]{nomencl}       % Tabla de abreviaturas
\RequirePackage[format=hang]{caption} % Formato de captions
\RequirePackage{xpatch}               % Espacio en tabla de abreviaturas
\RequirePackage{multirow}             % Unir filas en tablas
\RequirePackage{booktabs}             % Formato de tablas
\RequirePackage[a4paper]{geometry}             % Formato de margenes (distinto para la primera pagina)
\RequirePackage[spanish]{babel}
\RequirePackage{blindtext}               % Opcional. Solo para insertar texto "dummy"
\RequirePackage[nottoc,numbib]{tocbibind}    % Manejo de bibliograf\'ia en TOC
\RequirePackage[authormarkup=footnote,authormarkuptext=name]{changes}              % Edici\'on - correcci\'on del documento
\RequirePackage[width=0.95\textwidth]{subcaption}

% Margenes
\geometry{inner=2.4cm,width=17cm,height=24cm,head=2cm,headsep=10pt,top=3.36cm}


% Sangria e interlineado
\setlength{\parindent}{0.75cm}          % Sangria
\renewcommand{\baselinestretch}{1.1}   % Factor de espacio entre lineas
\setlength{\parskip}{2mm}               % Espacio extra entre p\'arrafos
%%\setlength{\textfloatsep}{12pt}
%%\setlength{\abovedisplayskip}{6pt}
%%\setlength{\belowdisplayskip}{6pt}
%%\setlength{\abovecaptionskip}{6pt}
%%\setlength{\belowcaptionskip}{6pt}


%% Uso de Helvetica (parecida a Arial) como fuente
%\renewcommand{\rmdefault}{phv}
%\renewcommand{\sfdefault}{phv}
%\usepackage{courier}
\renewcommand{\ttdefault}{pcr}
% \usepackage{helvet}
% \renewcommand{\familydefault}{\sfdefault}
%\usepackage{sansmath} % Enables turning on sans-serif math mode, and using other environments
%\sansmath % Enable sans-serif math for rest of document

% Definicion de las macros objetivo, alcance, revisores, etc
\newcommand*{\numeroIT}[1]{\gdef\@numeroIT{#1}}
\newcommand*{\objetivo}[1]{\gdef\@objetivo{#1}}
\newcommand*{\alcance}[1]{\gdef\@alcance{#1}}
\newcommand*{\autores}[2]{{\gdef\@fautor{#1}} {\gdef\@sautor{#2}}}
\newcommand*{\revisores}[3]{{\gdef\@frev{#1}} {\gdef\@srev{#2}} {\gdef\@trev{#3}}}
\newcommand*{\calidad}[1]{\gdef\@calidad{#1}}
\newcommand*{\aprobacion}[1]{\gdef\@aprobacion{#1}}
\newcommand*{\titulo}[1]{\gdef\@titulo{#1}}
\newcommand*{\alttitulo}[1]{\gdef\@alttitulo{#1}}

% Captions
\captionsetup{width=0.85\textwidth,textfont=footnotesize,labelfont={bf,small},format=hang}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Abreviaturas                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makenomenclature

% Quita el nombre de la seccion abreviaturas
\renewcommand{\nomname}{Definiciones, acr\'onimos y s\'imbolos}

% Coloca las abreviaturas en negrita
%\renewcommand{\nomlabel}[1]{\bf #1}

% Inserta espacio antes de cada item
\patchcmd{\thenomenclature}
  {\leftmargin\labelwidth}
  {\leftmargin\labelwidth\itemindent 0.75cm }
  {}{}

% Creacion de grupos: Acronimos (A) y nomenclaturas (N)
\RequirePackage{ifthen}
\renewcommand{\nomgroup}[1]{%
    \ifthenelse{\equal{#1}{A}}{\item[\textbf{Acr\'onimos}]}{%
        \ifthenelse{\equal{#1}{N}}{\item[\textbf{S\'imbolos}]}{}}}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                Caratula                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\pnormal}[1]{\fontsize{11pt}{13pt}\selectfont #1}
\newcommand*{\psmall}[1]{\fontsize{10pt}{11pt}\selectfont #1}
\newcommand*{\psmallx}[1]{\fontsize{8pt}{8pt}\selectfont #1}
\newcommand*{\plarge}[1]{\fontsize{12pt}{14pt}\selectfont #1}

\newcommand{\portada}{

    % Fija el ajuste de la primera pagina. Se pueden cambiar los margenes globales del documento sin afectar la forma de esta pagina
    \newgeometry{inner=2cm,width=17cm,height=24cm,head=2cm,headsep=10pt,top=3.36cm}
    

        \newpage     
        \vspace*{-1in}    
        \begin{calstable}
            \colwidths{{17.36cm}}
            \brow 
                \cell{ \small FO-PR-001 r2 }
            \erow
        \end{calstable}            

        \def\cals@framecs@width{2pt}
        \def\cals@framers@width{2pt}
        \def\cals@rs@width{2pt}
        \def\cals@cs@width{2pt}

%
% CABECERA
%        
        \begin{calstable}
            \colwidths{{2.8cm}{10.86cm}{3.7cm}}
            \brow 
                \alignC \nullcell{ltr} \alignC 
		\cell{{\vfil \plarge{ \bf INSTITUTO BALSEIRO}} \\[4pt] \pnormal{MAESTR\'IA EN INGENIER\'IA}}
                \cell{\vfil \pnormal{\small \@numeroIT}}  
                \ht\cals@current@row=2.0cm 
            \erow
            \brow 
                \nullcell{lrb}\spancontent{\vfil \includegraphics[width=1\linewidth]{logoIB.pdf}} 
                \cell{{ \bf }}\cell{\vfil \pnormal{P\'agina: \thepage \hspace{1pt} de \pageref{LastPage}}} 
                \ht\cals@current@row=0.85cm
            \erow
        \end{calstable}     
        
        \begin{calstable}
            \colwidths{{2.25cm}{15.11cm}}
            \brow 
                \alignC \cell{\vfil \plarge{ \bf T\'ITULO:}} \def\cals@borderL{0pt} \cell{\vfil \bf \pnormal{\@titulo}}  
                \ht\cals@current@row=1.35cm 
            \erow
        \end{calstable}  
        
%
% OBJETIVO Y ALCANCE
%        
        \begin{calstable}
            \colwidths{{17.36cm}}
            \brow 
                \cell{
                    \vspace{10pt}            
                    {\section{OBJETIVO}} \par
                    {\parindent=0.75cm \pnormal{\@objetivo}}
                     
%                    {\section{ALCANCE}} \par
%                    {\parindent=0.75cm \pnormal{\@alcance}}
                 } 
                \ht\cals@current@row=7cm 
            \erow
        \end{calstable}            

        \begin{calstable}
            \colwidths{{2.48cm}}
            \brow 
                \alignC \nullcell{ltb} \nullcell{rtb}\spancontent{\vfil \bf \pnormal{Prepar\'o} } 
                \nullcell{ltb} \nullcell{tb} \nullcell{rtb} \spancontent{\vfil \bf \pnormal{Revis\'o} } 
                \cell{\vfil \bf \begin{spacing}{1}\pnormal{Intervino calidad}\end{spacing}} 
                \cell{\vfil \bf \pnormal{Aprob\'o}} 
                \ht\cals@current@row=1.15cm 
            \erow
        \end{calstable} 
        
        \def\cals@cs@width{1pt}
        \begin{calstable}
            \colwidths{{2.48cm}}
            \brow
                \alignC \cell{\vfill \pnormal{\@fautor}}\cell{\vfill \pnormal{\@sautor}}             % Autores
                \cell{\vfill \pnormal{\@frev}} \cell{\vfill \pnormal{\@srev}} \cell{\vfill \pnormal{\@trev}}   % Revisores
                \cell{\vfill \pnormal{\@calidad}}                                          % Calidad
                \cell{\vfill \pnormal{\@aprobacion}}                                       % Aprobacion
                \ht\cals@current@row=2.95cm 
            \erow
        \end{calstable} 
        \def\cals@cs@width{2pt}

%
% REVISIONES
%        

        \begin{calstable}
            \colwidths{{17.36cm}}
            \brow 
                \cell{
                    {\plarge{\bf REVISIONES}} \par
                 } 
                \ht\cals@current@row=0.78cm 
            \erow
        \end{calstable}            

        \begin{calstable}
            \colwidths{{2.48cm}}
            \brow 
                \alignC \cell{\vfil \bf \pnormal{Rev.}} 
               \cell{\vfil \bf \pnormal{Fecha }} 
                \nullcell{ltb} \nullcell{tb} \nullcell{rtb} \nullcell{rtb} \nullcell{rtb} \spancontent{\vfil \bf \pnormal{Modificaciones} } 
                \ht\cals@current@row=0.78cm 
            \erow
        \end{calstable} 

        \def\cals@rs@width{1pt}
        \begin{calstable}
            \colwidths{{2.48cm}}
            \brow 
                \alignC \cell{\vfil} 
                \cell{} 
                \nullcell{ltb} \nullcell{tb} \nullcell{rtb} \nullcell{rtb} \nullcell{rtb} \spancontent{ } 
                \ht\cals@current@row=0.78cm 
            \erow
            \brow 
                \alignC \cell{\vfil} 
                \cell{} 
                \nullcell{ltb} \nullcell{tb} \nullcell{rtb} \nullcell{rtb} \nullcell{rtb} \spancontent{ } 
                \ht\cals@current@row=0.78cm 
            \erow
            \brow 
                \alignC \cell{\vfil} 
                \cell{} 
                \nullcell{ltb} \nullcell{tb} \nullcell{rtb} \nullcell{rtb} \nullcell{rtb} \spancontent{ } 
                \ht\cals@current@row=0.78cm 
            \erow
            \brow 
                \alignC \cell{\vfil} 
                \cell{} 
                \nullcell{ltb} \nullcell{tb} \nullcell{rtb} \nullcell{rtb} \nullcell{rtb} \spancontent{ } 
                \ht\cals@current@row=0.78cm 
            \erow
        \end{calstable} 
        \def\cals@rs@width{2pt}

%
% VIGENCIA
%        

        \begin{calstable}
            \colwidths{{17.36cm}}
            \brow 
                \cell{
                    {\plarge{\bf FECHA DE VIGENCIA:}} \par
                 } 
                \ht\cals@current@row=0.78cm 
            \erow
        \end{calstable}            

        \def\cals@rs@width{0pt}
        \def\cals@framers@width{0pt}
        \begin{calstable}
            \colwidths{{8.68cm}}
            \brow 
                \alignC  \cell{
                    {\plarge{\bf DISTRIBUCI\'ON}} \par
                 } 
                 \cell{
                    {\plarge{\bf ESTADO DEL DOCUMENTO}} \par
                 }
                \ht\cals@current@row=0.78cm 
            \erow
        \end{calstable} 

        \begin{calstable}
            \colwidths{{3.68cm}}
            \brow 
                  \cell{
                    {\plarge{Copia N$^\circ$:}} \par
                 } 
        \def\cals@cs@width{0pt}
            \colwidths{{5.cm}}
                   \nullcell{tlr}
%                  \cell{
%                    {\plarge{Copia N$^\circ$:}} \par
%                 } 
        \def\cals@cs@width{2pt}
            \colwidths{{8.68cm}}
                 \cell{ }
                \ht\cals@current@row=0.78cm 
            \erow
            \colwidths{{3.68cm}}
            \brow 
                  \cell{
                    {\plarge{Distribuy\'o:}} \par
                 } 
        \def\cals@cs@width{0pt}
            \colwidths{{5.cm}}
                   \nullcell{blr}\spancontent{ \includegraphics[height=1.5cm]{sello-gescalgin} }
%                  \cell{
%                    {\plarge{Copia N$^\circ$:}} \par
%                 } 
        \def\cals@cs@width{2pt}
            \colwidths{{8.68cm}}
                  \cell{
                    {\plarge{Fecha: 03/10/2019}} \par
                 } 
                \ht\cals@current@row=0.78cm 
            \erow
        \end{calstable} 

        \begin{calstable}
            \colwidths{{8.68cm}}
            \brow 
                  \cell{
                    {\begin{onehalfspace}\psmallx{Una vez impreso este documento se considerar\'a copia no controlada a menos que cuente con sello y firma original del responsable de Calidad de la GIN.}\end{onehalfspace}} \par
                 } 
                  \cell{
                    {\plarge{Firma:}} \par
                 } 
                \ht\cals@current@row=1.20cm 
            \erow
        \end{calstable} 
        \def\cals@rs@width{2pt}
        \def\cals@framers@width{2pt}

%
% Copyright CNEA
%

        \begin{calstable}
            \colwidths{{1.15cm}{16.21cm}}
            \brow 
                \cell{\psmallx{ \bf \vspace{1pt} NOTA:}} \def\cals@borderL{0pt} 
                \cell{ \begin{spacing}{0.8} \psmallx{ Este documento es propiedad de CNEA y se reserva todos los derechos legales sobre \'el. No est\'a permitida la explotaci\'on, transferencia o liberaci\'on de ninguna informaci\'on en el contenido, ni hacer reproducciones y entregarlas a terceros sin un acuerdo previo y escrito de CNEA.}\end{spacing}} 
                \ht\cals@current@row=1.2cm 
            \erow
        \end{calstable}     



    \restoregeometry

  } 





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                Cabeceras                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Primera p\'agina
\fancypagestyle{firstpage}{
    \fancyhf{}                            % Borra todos los campos
    \renewcommand{\headrulewidth}{0pt}    % Elimina la l\'inea del encabezado
    \renewcommand{\footrulewidth}{0pt}    % Elimina la l\'inea del pie de p\'agina
}

% Resto de las p\'aginas
\fancypagestyle{followingpage}{
    \fancyhf{}                            % Borra todos los campos
    \renewcommand{\headrulewidth}{0pt}    % Elimina la l\'inea del encabezado
    \renewcommand{\footrulewidth}{0pt}    % Elimina la l\'inea del pie de p\'agina
    \fancyhead[CO,CE]{
        \begin{calstable}
            \def\cals@framecs@width{1.5pt}
            \def\cals@framers@width{1.5pt}
            \def\cals@rs@width{1.5pt}
            \def\cals@cs@width{1.5pt}    
            \colwidths{{2.8cm}{10.14cm}{4.06cm}}
            \brow 
                \alignC \cell{\vfil \bf Instituto Bailseiro} 
                \cell{ \vfil \bf \@alttitulo}              
                \cell{\vfil {\small \@numeroIT} \\[2pt] P\'agina: \thepage \hspace{1pt} de \pageref{LastPage} }
                \ht\cals@current@row=1.7cm 
            \erow
        \end{calstable}
        }
}

\pagestyle{followingpage}
\AtBeginDocument{\thispagestyle{firstpage}}










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Titulos de secciones y subsecciones                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Agrega al punto despues del numero de (sub/subsub)seccion
\renewcommand{\thesection}      {\textup{\arabic{section}}}
\renewcommand{\thesubsection}   {\textup{\thesection.\arabic{subsection}}}
\renewcommand{\thesubsubsection}{\textup{\thesubsection.\arabic{subsubsection}}}


% Formato del titulo de la (sub/subsub)seccion
\renewcommand{\section}{\@startsection{section}{1}{0mm}%
                                     {-12pt}%
                                     {11pt}%                Espacio despues del t\'itulo
                                     {\bfseries\Large\uppercase}}%
\renewcommand{\subsection}{\@startsection{subsection}{2}{0mm}%
                                     {-12pt}%
                                     {11pt}%
                                     {\bfseries\large}}%
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0mm}%
                                     {-12pt}%
                                     {11pt}%
                                     {\bfseries\normalsize}}%                                     








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Tabla de contenidos                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cambio del nombre
\AtBeginDocument{\renewcommand{\contentsname}{\'INDICE}}

% Centrado del nombre, comienza nueva p\'agina al final
\makeatletter       
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
            \newpage
            \begin{center}      %%%   
            \Large              %%%   
            \bfseries           %%%   
            \contentsname       %%%  
            \end{center}        %%%
%            \addvspace{1cm}     %%%   Añade o quita espacio vertical 
    \@mkboth{%
       \MakeUppercase\contentsname}{\MakeUppercase\contentsname} 
    {\large \@starttoc{toc} }
    \if@restonecol\twocolumn\fi
    \newpage
    }
\makeatother



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Figuras, tablas y referencias                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colocar al principio del documento, para evitar la sobreescritura realizada por el paquete babel
\AtBeginDocument{%
    \renewcommand{\tablename}{Tabla}
%    \renewcommand{\refname}{\vspace{-1.5cm}}
%    \renewcommand{\tocbibname}{Bibliograf\'ia y referencias}
    \renewcommand{\tocbibname}{REFERENCIAS}
}
\renewcommand{\figurename}{Figura}

% Definiciones especiales. Estandariza la referencia a figuras
\newcommand{\fig}[1]{Fig.~\ref{#1}}
\newcommand{\figs}[2]{Figs.~\ref{#1} y \ref{#2}}
\newcommand{\tb}[1]{Tabla~\ref{#1}}

% pdf links
%\ifnum \mecomuselinks = 1
% Use color links
\RequirePackage{color}
\definecolor{url}{rgb}{0.8,0.,0.}
\RequirePackage[colorlinks,linkcolor=black,%
                urlcolor=url,citecolor=black,%
                plainpages=false,pdfpagelabels]{hyperref}
\RequirePackage{nameref,url}
\def\UrlFont{\mdseries}
%\fi


% Separaci\'on entre filas y columnas
\renewcommand{\arraystretch}{1.3}
\setlength{\tabcolsep}{5mm}

% Espesor de l\'ineas (del paquete booktabs)
\setlength{\heavyrulewidth}{1.5pt}


   

\endinput
