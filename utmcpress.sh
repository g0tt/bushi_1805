#!/bin/sh

# 
# utmcpress.sh
# 
# Usage: 
# utmcpress.sh (todvi | topdf | clear)
# 
#  Coded by hyuga.
# 

echo "[error]\tThis script is deprecated." >/dev/stderr
echo "[error]\tPlease use 'make' instead." >/dev/stderr
exit 1

##############################
# General settings here
##############################
# Text encoding
KANJI="utf8"
# Temporary directory
TMP_DIR="tmp"
# Compiled dvi or pdf file will be output here.
OUT_DIR="out"
# Target TeX file.
TARGET="utmcpress"
# Preview
PREVIEW="preview"

##############################
# Programs to use
##############################
MKDIR="mkdir -p"
RM="rm -r"
MV="mv"
PLATEX="platex"
DVIPDFMX="dvipdfmx"
DVIPNG="dvipng"
DVIGIF="dvigif"
# Adobe Reader = "acroread"
if [ ! "${PDFVIEWER}" ]; then
	PDFVIEWER="xpdf"
fi
if [ ! "${DVIVIEWER}" ]; then
	DVIVIEWER="xdvi"
fi

#init(){
#	echo " * Initializing..."
#	${MKDIR} ${TMP_DIR}
#	${MKDIR} ${OUT_DIR}
#}

todvi(){
	echo " * Compiling to dvi..."
	${MKDIR} ${TMP_DIR}
	${MKDIR} ${OUT_DIR}
	${MKDIR} ${TMP_DIR}/includes
	${MKDIR} ${TMP_DIR}/articles
	# Compile three times
	for i in eins twei drei; do
		${PLATEX} -kanji=${KANJI} -output-directory="${TMP_DIR}" -interaction=nonstopmode "$1.tex"
		if [ $? -ne 0 ]; then
			errorexit "An error has occured during processing TeX file."
		fi
	done
	# Check if dvi file exists.
	if [ ! -e "${TMP_DIR}/$1.dvi" ]; then
		errorexit "Cannot convert tex to dvi."
	fi
	${MV} "${TMP_DIR}/$1.dvi" "${OUT_DIR}"
}

showdvi(){
	echo " * Launching dvi viewer..."
	${DVIVIEWER} ${OUT_DIR}/$1.dvi &
}

topdf(){
	echo " * Converting dvi to pdf..."
	CURRENT=`pwd`
	cd ${OUT_DIR}
	${DVIPDFMX} -o ${TARGET}.pdf ${TARGET}.dvi
	cd ${CURRENT}
}

showpdf(){
	echo " * Launching pdf viewer..."
	${PDFVIEWER} ${OUT_DIR}/${TARGET}.pdf
}

clean(){
	echo " * Cleaning the temporary direcotry..."
	${RM} ${TMP_DIR}/*
	${RM} ${OUT_DIR}/*
	${MKDIR} ${TMP_DIR}
	${MKDIR} ${OUT_DIR}
	${MKDIR} ${TMP_DIR}/includes
	${MKDIR} ${TMP_DIR}/articles
}

help(){
	echo "Usage: utmcpress.sh (todvi | topdf | preview | clean | help)"
	echo ""
	echo "todvi     Compile the tex file and output dvi file."
	echo "topdf     Compile the tex file and output pdf file."
	echo "preview   Compile an article only, then shows dvi."
	echo "clean     Clean temporary direcotry."
	echo "help      Show this message."
	echo ""
	echo "To customize detailes, please edit this executable text file. ;D"
}

errorexit(){
	echo "************************************************************"
	if test ! "$1"; then
		ERROR_MSG="Unexpected error."
	else
		ERROR_MSG=$1
	fi
	echo " [error] "${ERROR_MSG}
	echo "************************************************************"
	exit
}

case $1 in
	preview)
		clean
		todvi $PREVIEW
		showdvi $PREVIEW;;
	todvi)
		clean
		todvi $TARGET
		showdvi $TARGET;;
	topdf)
		clean
		todvi $TARGET
		topdf
		showpdf;;
	clean)
		clean;;
	help)
		help;;
	*)
		echo "[error]\tUnknown option or option not specified."
		help;;
esac

exit

