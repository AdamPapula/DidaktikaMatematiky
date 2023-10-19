#!/bin/sh

COMPILE=true

if [ "$COMPILE" = true ]
then
  sudo apt-get update -y > update.log
  sudo apt-get upgrade -y > upgrade.log
  sudo apt-get install -y texlive texlive-latex-base texlive-publishers texlive-science texlive-lang-czechslovak cm-super latexmk > install.log

  CURRENT_PATH=$(pwd)
  mkdir releases
  for DIRECTORY in */; do
    echo Trying dir "$DIRECTORY"
    if [ -d "$DIRECTORY" ] && [ "$DIRECTORY" != "Assets/" -a "$DIRECTORY" != "Styles/" -a "$DIRECTORY" != "releases/" ]
    then   
        cd "$DIRECTORY" || continue
        TEX_FILE=$(find . -name "*.tex" -maxdepth 1)
        echo Compiling LaTeX file "$TEX_FILE" in "$DIRECTORY"
        if [ -n "$TEX_FILE" ]
        then
            lualatex  --synctex=0 --interaction=nonstopmode --output-directory="../releases/" --jobname="${DIRECTORY%/}" "$TEX_FILE" > out.log
            lualatex  --synctex=0 --interaction=nonstopmode --output-directory="../releases/" --jobname="${DIRECTORY%/}" "$TEX_FILE" > out.log
            lualatex  --synctex=0 --interaction=nonstopmode --output-directory="../releases/" --jobname="${DIRECTORY%/}" "$TEX_FILE" > out.log
        else
            echo "No LaTeX file found, exit."
        fi
        cd "$CURRENT_PATH"
    fi
    done

    ls ./releases/

    find ./releases -type f ! -name "*.pdf" -exec rm -f {} \;
    
    hub release create -a releases/* -m "Verze 1.0" v1.0
fi