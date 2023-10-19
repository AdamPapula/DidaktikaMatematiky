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
    echo "$DIRECTORY"
    if [ -d "$DIRECTORY" ] && [ "$DIRECTORY" != "Assets/" ] && [ "$DIRECTORY" != "Styles/" ]
    then   
        cd "$DIRECTORY" || continue
        TEX_FILE=$(find . -name "*.tex" -maxdepth 1)
        echo "$TEX_FILE"
        if [ -n "$TEX_FILE" ]; then
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


    # for DIRECTORY in */; do
    #     if [ -d "$DIRECTORY" ] && [ "$DIRECTORY" != "Assets/" ] && [ "$DIRECTORY" != "Styles/" ]
    #         then
    #         cd "$DIRECTORY" || continue
    #         PDF_FILES=(*.pdf)
    #         if [ ${#PDF_FILES[@]} -gt 0 ]
    #         then
    #             for PDF_FILE in "${PDF_FILES[@]}"; do
    #                 NEW_FILENAME="${DIRECTORY%/}.pdf"  # Nový název souboru bude jméno složky s příponou .pdf
    #                 mv "$PDF_FILE" ~/releases/"$NEW_FILENAME"
    #                 echo "Přejmenováno a přesunuto: $PDF_FILE -> ~/releases/$NEW_FILENAME"
    #             done
    #         fi
    #     fi
    #     cd "$CURRENT_PATH"
    # done
  
fi